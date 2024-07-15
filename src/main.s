	INCLUDE	"config.inc"

	SECTION CODE

	.assume adl=1

	PUBLIC	_main
	XREF	_uart0_init
	XREF	bank_init_z2
	XREF	_spike
	XREF	_rx_buffer_init
	xref	_measure_cpu_freq

_main:
	CALL	_uart0_init
	CALL	_rx_buffer_init
	CALL	bank_init_z2
	CALL	_measure_cpu_freq

	; call	_spike

	LD	A, Z80_ADDR_MBASE		; set MBASE to $B9
	LD	MB, A
	JP.SIS	0				; transfer to external Memory under Z80 Compatible mode

	SEGMENT BSS

_tmp:
	DS	3
