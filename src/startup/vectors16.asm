;*****************************************************************************
; vectors16.asm
;
; eZ80's Reset, RST and first generation interrupt vector arrangement
;*****************************************************************************
; Copyright (C) 2005 by ZiLOG, Inc.  All Rights Reserved.
;*****************************************************************************

	XREF	__init
	XREF	__low_rom

	XDEF	_reset
	XDEF	__default_nmi_handler
	XDEF	__default_mi_handler
	XDEF	__nvectors
	XDEF	_init_default_vectors
	XDEF	__init_default_vectors
	XDEF	_set_vector
	XDEF	__set_vector
	XDEF	__2nd_jump_table
	XDEF	__1st_jump_table
	XDEF	__vector_table


NVECTORS EQU 48			; number of interrupt vectors

; Save Interrupt State
SAVEIMASK MACRO
	ld	a, i		; sets parity bit to value of IEF2
	push	af
	di			; disable interrupts while loading table
MACEND

; Restore Interrupt State
RESTOREIMASK MACRO
	pop	af
	jp	po, $+5		; parity bit is IEF2
    	ei
MACEND


;*****************************************************************************
; Reset and all RST nn's
;  1. diaable interrupts
;  2. clear mixed memory mode (MADL) flag
;  3. jump to initialization procedure with jp.lil to set ADL
	DEFINE	.RESET, SPACE = ROM
	SEGMENT	.RESET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	XREF	_rst_io
	XREF	_rst_rc2014_fnc
	XREF	_rst_rc2014_bank_switch
_reset:
_rst0:
	di
	stmix
	jp.lil	__init

	ORG	%08
_rst8:
	jp.lil	_rst_io

	org	%10
_rst10:
	jp.lil	_rst_rc2014_fnc

	org	%18
_rst18:
	jp.lil	_rst_rc2014_bank_switch

	org	%20
_rst20:
	di
	stmix
	jp.lil	__init
_rst28:
	di
	stmix
	jp.lil	__init
_rst30:
	di
	stmix
	jp.lil	__init
_rst38:
	di
	stmix
	jp.lil	__init
	ds %26
_nmi:
	jp.lil	__default_nmi_handler



;*****************************************************************************
; Startup code
	DEFINE .STARTUP, SPACE = ROM
	SEGMENT .STARTUP
	.ASSUME ADL=1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; number of vectors supported
__nvectors:
	DW	NVECTORS	; extern unsigned short _num_vectors;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Default Non-Maskable Interrupt handler
__default_nmi_handler:
	retn

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Default Maskable Interrupt handler
__default_mi_handler:
	ei
	reti

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Initialize all potential interrupt vector locations with a known
; default handler.
;
; void _init_default_vectors(void);
__init_default_vectors:
_init_default_vectors:
	push	af
	SAVEIMASK
	ld	hl, __default_mi_handler
	ld	a, %C3
	ld	(__2nd_jump_table), a		; place jp opcode
	ld	(__2nd_jump_table + 1), hl  	; __default_hndlr
	ld	hl, __2nd_jump_table
	ld	de, __2nd_jump_table + 4
	ld	bc, NVECTORS * 4 - 4
	ldir
	im	2				; Interrtup mode 2
	ld	a, __vector_table >> 8
	ld	i, a				; Load interrtup vector base
	RESTOREIMASK
	pop	af
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Installs a user interrupt handler in the 2nd interrupt vector jump table
;
; void * _set_vector(unsigned int vector, void(*handler)(void));
__set_vector:
_set_vector:
	push	iy
	ld	iy, 0
	add	iy, sp					; Standard prologue
	push	af
	SAVEIMASK
	ld	bc, 0					; clear bc
	ld	b, 2					; calculate 2nd jump table offset
	ld	c, (iy+6)			 	; vector offset
	mlt	bc			  		; bc is 2nd jp table offset
	ld	hl, __2nd_jump_table
	add	hl, bc		 			; hl is location of jp in 2nd jp table
	ld	(hl), %C3				; place jp opcode just in case
	inc	hl			  		; hl is jp destination address
	ld	bc, (iy+9)				; bc is isr address
	ld	de, (hl)				; save previous handler
	ld	(hl), bc				; store new isr address
	push	de
	pop	hl			  		; return previous handler
	RESTOREIMASK
	pop	af
	ld	sp, iy		 			; standard epilogue
	pop	iy
	ret


;*****************************************************************************
	DEFINE IVJMPTBL, SPACE = RAM
	SEGMENT IVJMPTBL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 2nd Interrupt Vector Jump Table
;  - this table must reside in RAM anywhere in the 16M byte range
;  - each 4-byte entry is a jump to an interrupt handler
__2nd_jump_table:
	DS NVECTORS * 4


;*****************************************************************************
; Interrupt Vector Table
;  - this segment must be aligned on a 256 byte boundary anywhere below
;    the 64K byte boundry
;  - each 2-byte entry is a 2-byte vector address
	DEFINE .IVECTS, SPACE = ROM, ALIGN = 100h
	SEGMENT .IVECTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__vector_table:
	dw	__1st_jump_table + %00
	dw	__1st_jump_table + %04
	dw	__1st_jump_table + %08
	dw	__1st_jump_table + %0c
	dw	__1st_jump_table + %10
	dw	__1st_jump_table + %14
	dw	__1st_jump_table + %18
	dw	__1st_jump_table + %1c
	dw	__1st_jump_table + %20
	dw	__1st_jump_table + %24
	dw	__1st_jump_table + %28
	dw	__1st_jump_table + %2c
	dw	__1st_jump_table + %30
	dw	__1st_jump_table + %34
	dw	__1st_jump_table + %38
	dw	__1st_jump_table + %3c
	dw	__1st_jump_table + %40
	dw	__1st_jump_table + %44
	dw	__1st_jump_table + %48
	dw	__1st_jump_table + %4c
	dw	__1st_jump_table + %50
	dw	__1st_jump_table + %54
	dw	__1st_jump_table + %58
	dw	__1st_jump_table + %5c
	dw	__1st_jump_table + %60
	dw	__1st_jump_table + %64
	dw	__1st_jump_table + %68
	dw	__1st_jump_table + %6c
	dw	__1st_jump_table + %70
	dw	__1st_jump_table + %74
	dw	__1st_jump_table + %78
	dw	__1st_jump_table + %7c
	dw	__1st_jump_table + %80
	dw	__1st_jump_table + %84
	dw	__1st_jump_table + %88
	dw	__1st_jump_table + %8c
	dw	__1st_jump_table + %90
	dw	__1st_jump_table + %94
	dw	__1st_jump_table + %98
	dw	__1st_jump_table + %9c
	dw	__1st_jump_table + %a0
	dw	__1st_jump_table + %a4
	dw	__1st_jump_table + %a8
	dw	__1st_jump_table + %ac
	dw	__1st_jump_table + %b0
	dw	__1st_jump_table + %b4
	dw	__1st_jump_table + %b8
	dw	__1st_jump_table + %bc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 1st Interrupt Vector Jump Table
;  - this table must reside in the first 64K bytes of memory
;  - each 4-byte entry is a jump to the 2nd jump table plus offset
__1st_jump_table:
	jp	__2nd_jump_table + %00
	jp	__2nd_jump_table + %04
	jp	__2nd_jump_table + %08
	jp	__2nd_jump_table + %0c
	jp	__2nd_jump_table + %10
	jp	__2nd_jump_table + %14
	jp	__2nd_jump_table + %18
	jp	__2nd_jump_table + %1c
	jp	__2nd_jump_table + %20
	jp	__2nd_jump_table + %24
	jp	__2nd_jump_table + %28
	jp	__2nd_jump_table + %2c
	jp	__2nd_jump_table + %30
	jp	__2nd_jump_table + %34
	jp	__2nd_jump_table + %38
	jp	__2nd_jump_table + %3c
	jp	__2nd_jump_table + %40
	jp	__2nd_jump_table + %44
	jp	__2nd_jump_table + %48
	jp	__2nd_jump_table + %4c
	jp	__2nd_jump_table + %50
	jp	__2nd_jump_table + %54
	jp	__2nd_jump_table + %58
	jp	__2nd_jump_table + %5c
	jp	__2nd_jump_table + %60
	jp	__2nd_jump_table + %64
	jp	__2nd_jump_table + %68
	jp	__2nd_jump_table + %6c
	jp	delegate_isr; external_isr; __2nd_jump_table + %70
	jp	__2nd_jump_table + %74
	jp	__2nd_jump_table + %78
	jp	__2nd_jump_table + %7c
	jp	__2nd_jump_table + %80
	jp	__2nd_jump_table + %84
	jp	__2nd_jump_table + %88
	jp	__2nd_jump_table + %8c
	jp	__2nd_jump_table + %90
	jp	__2nd_jump_table + %94
	jp	__2nd_jump_table + %98
	jp	__2nd_jump_table + %9c
	jp	__2nd_jump_table + %a0
	jp	__2nd_jump_table + %a4
	jp	__2nd_jump_table + %a8
	jp	__2nd_jump_table + %ac
	jp	__2nd_jump_table + %b0
	jp	__2nd_jump_table + %b4
	jp	__2nd_jump_table + %b8
	jp	__2nd_jump_table + %bc

delegate_isr:	; defer to the external ISR routine

	PUSH	IX
	LD	IX,+3
	ADD	IX,SP
	PUSH	AF

	LD	A, (IX)			; ADL MODE OF INTERRUPTED CODE (2 - Z80, 3 - ADL)
	CP	3
	JR	NZ, skip_24_reg_save

	PUSH	BC			; IF WE INTERRUPTED AN ADL ROUTINE,
	PUSH	DE			; THEN WE NEED TO SAVE ALL REGISTERS BEFORE
	PUSH	HL			; JUMPING INTO Z80 CODE
	PUSH	IY			; BECAUSE DESPITE IT ONLY HAVE ACCESS TO THE
	EXX				; LOWER 16 BIT OF REGISTERS, THE VARIOUS INSTRUCTIONS
	PUSH	AF			; CAN HAVE SIDE EFFECTS ON THE UPPER 8 BITS
	PUSH	BC
	PUSH	DE
	PUSH	HL
	EXX

skip_24_reg_save:
	RST.S	%38		; delegate to ISR routine of external ROM

	LD	A, (IX)
	CP	3
	JR	NZ, skip_24_reg_restore
	EXX
	POP	HL
	POP	DE
	POP	BC
	POP	AF
	EXX
	POP	IY
	POP	HL
	POP	DE
	POP	BC

skip_24_reg_restore:
	POP	AF
	POP	IX
	EI
	RETI.L			; return rom interrupt - back to ADL 0 or 1

	END
