;
; SYSTEM TIMER INTERFACE
;
; Access with RST.L %10 (A=2, B=sub function code)
;
; The System Timer track a counter that is incremented at a fixed rate.
; The rate can be selected, and is typically 50 Hz or 60 Hz.
;
; The timer is driven by the RTC if it is enabled, otherwise it is driven
; by the CPU clock.
;
; The interface provides function to access and reset the tick counter,
; as well as access a calibrated seconds value.
;
; The tick count is a 24 bit number, and will wrap to 0 after 2^24 ticks.
;
        INCLUDE "..\config.inc"

	XREF	__idivs
	XREF	__idivu
	XREF	__imul_b
	XREF	__imuls
	XREF	__iremu
	XREF	__stoiu

	XREF	_configure_tmr1_to_rtc
	XREF	_configure_tmr1_to_sysclk
	XREF	_get_ticks_for_rtcclk
	XREF	_get_ticks_for_sysclk
	XREF	_rtc_enabled
	XREF	_system_ticks
	XREF	_ticks_frequency

	SEGMENT	CODE

	.ASSUME ADL=1

	PUBLIC	_system_timer_isr
	PUBLIC	_system_timer_dispatch
;
; SYSTEM TIMER ISR
;
; This ISR is called at the tick frequency rate, and increments the 24 bit tick counter.
;
_system_timer_isr:
	PUSH	AF
	PUSH	HL

	IN0    A, (TMR1_CTL)				; CLEAR INTERRUPT SIGNAL

	LD	HL, (_system_ticks)			; POINT TO TICK COUNTER
	INC	HL
	LD	(_system_ticks), HL

	POP	HL
	POP	AF
	EI
	RETI.L
;
; SYSTEM TIMER DISPATCH
;
; Dispatcher for the RST.L %10 trap functions
; Inputs:
;   B      = Timer sub function index
; Outputs:
;   A	 = 0 -> Success, otherwise errored
;   Other registers as per sub-functions
;
_system_timer_dispatch:
	POP	BC					; RESTORE BC AND HL
	POP	HL

	LD	A, B					; SUB FUNCTION CODE
	OR	A					; TEST SUB FUNCTION CODE
	JR	Z, tmr_tick_get				; B = 0, SYSTMR_TICKS_GET
	DEC	A
	JR	Z, tmr_secs_get				; B = 1, SYSTMR_SECONDS_GET
	DEC	A
	JR	Z, tmr_tick_set				; B = 2, SYSTMR_TICKS_SET
	DEC	A
	JR	Z, tmr_secs_set				; B = 3, SYSTMR_SECONDS_SET
	DEC	A
	JR	Z, tmr_freq_get				; B = 4, SYSTMR_FREQTICK_GET
	DEC	A
	JR	Z, tmr_freq_set				; B = 5, SYSTMR_FREQTICK_SET

	LD	A, %FF					; FAILURE - UNKONWN SUB FUNCTION
	RET.L
;
; Function B = 0 -- SYSTMR_TICKS_GET
; Retrieve the current 24 bit tick count.
;
; Output:
;   uHL	 = Current timer tick count (24 bits)
;   EHL  = Current timer tick count (24 bits)
;   D	 = 0
;   C	 = tick frequency (typically 50 or 60)
;   A	 = 0 -> Success, otherwise errored
;
tmr_tick_get:
	DI
	LD	HL, (_system_ticks)
	LD	A, (_system_ticks+2)
	EI
	LD	D, 0
	LD	E, A
	LD	A, (_ticks_frequency)
	LD	C, A
	XOR	A					; SUCCESS
	RET.L
;
; Function B = 1 -- SYSTMR_SECONDS_GET
; Retrieve the current 24 bit number of seconds counted.
;
; Outputs:
;   uHL	 = Number of seconds counted
;   C	 = Number of ticks within the current second
;   DE	 = Number of milliseconds within the current second
;   A	 = 0 -> Success, otherwise errored
;
tmr_secs_get:
	LD	HL, (_system_ticks)
	LD	BC, 0
	LD	A, (_ticks_frequency)
	LD	C, A
	PUSH	BC
	CALL	__idivu

	POP	BC					; RESTORE _ticks_frequency
	PUSH	HL					; SAVE SECONDS = _system_ticks/_ticks_frequency

	LD	HL,(_system_ticks)
	CALL	__iremu
	LD	C, L					; SECOND FRACTION INTO C

	PUSH	BC
	CALL	get_milliseconds
	POP	BC
	LD	E, L					; DE = MILLISECONDS
	LD	D, H

	POP	HL					; RESTORE SECONDS

	XOR	A					; SUCCESS
	RET.L
;
; Calculate the number of milliseconds within the current second
; Inputs:
;  C = Number of ticks within the current second
; Output:
;  HL = Number of milliseconds within the current second
;
get_milliseconds:
	LD	B, 0					; BC = ticks within second
	CALL	__stoiu					; uHL = BC
	LD	BC, 16000
	CALL	__imuls					; uHL = uBC * uHL
	LD	DE, HL					; uDE = uHL = ticks_within_second * 16000

	LD	A,(_ticks_frequency)
	UEXT	HL
	LD	L,A
	LD	BC,HL					; uBC = _ticks_frequency
	LD	HL,DE					; uHL = ticks_within_second * 16000
	CALL	__idivs

	LD	IY, HL
	LEA	HL, IY+8				; uHL = uHL + 8
	LD	BC, 16
	JP	__idivs					; uHL = uHL / 16
;
; Function B = 2 -- SYSTMR_TICKS_SET
; Set the current 24 bit tick count.
; Inputs:
;   uHL	 = New timer tick count (24 bits)
; Outputs:
;   A	 = 0 -> Success, otherwise errored
;
tmr_tick_set:
	LD	(_system_ticks), HL

	XOR	A					; SUCCESS
	RET.L
;
; Function B = 3 -- SYSTMR_SECONDS_SET
; Set the current 24 bit number of seconds counted.
; Inputs:
;   uHL: Number of seconds to be assigned to counter
; Outputs:
;   A	 = 0 -> Success, otherwise errored
;
tmr_secs_set:
	LD	A, (_ticks_frequency)
	CALL	__imul_b

	LD	(_system_ticks), HL

	XOR	A					; SUCCESS
	RET.L
;
; Function B = 4 -- SYSTMR_FREQTICK_GET
; Retrieve the current timer frequency.
; Outputs:
;  C	 = tick frequency (typically 50 or 60)
;  A	 = 0 -> Success, otherwise errored
;
tmr_freq_get:
	LD	A, (_ticks_frequency)
	LD	C, A
	XOR	A					; SUCCESS
	RET.L
;
; Function B = 5 -- SYSTMR_FREQTICK_SET
; Set the on board system clock to track the desired frequency, typically
; this will be 50Hz or 60Hz.
; Inputs:
;   C 	 = new tick frequency (typically 50 or 60)
; Outputs:
;   A	 = 0 -> Success, otherwise errored
;
tmr_freq_set:
	LD	A, C
	LD	(_ticks_frequency), A

	LD	A, (_rtc_enabled)
	OR	A
	JR	Z, tmr_freq_set_for_cpuclk

tmr_freq_set_for_rtc:
	CALL	_get_ticks_for_rtcclk
	CALL	_configure_tmr1_to_rtc
	JR	tmr_freq_set_exit

tmr_freq_set_for_cpuclk:
	CALL	_get_ticks_for_sysclk
	CALL	_configure_tmr1_to_sysclk

tmr_freq_set_exit
	LD	HL, 0
	LD	(_system_ticks), HL
	XOR	A					; SUCCESS
	RET.L

	END
