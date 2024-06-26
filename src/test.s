
	SECTION CODE

	.assume adl=1

	public	_spike
_spike:
	LD	HL, step1
	ld	de, 0b7E000h
	ld	bc, step1_size
	ldir

	LD	A, 0B7H
	LD	MB, A
	LD.SIS	SP, 0E700H
	NOP
	NOP
	CALL.IS	0E000H
	RET

	.assume adl = 0
step1:
	NOP
	LD	A, %67
	LD	B, %54
	LD	C, %10
	LD	D, %23
	LD	E, %34
	LD	H, %45
	LD	L, %56

	RST.L	%08		; I/O HELPER
	OUT	(%45), A

	RST.L	%08		; I/O HELPER
	OUT 	(C), A		; OUT (%FF10), %67

	RST.L	%08		; I/O HELPER
	OUT 	(C), B		; OUT (%FF10), %54

	RST.L	%08		; I/O HELPER
	OUT 	(C), C		; OUT (%FF10), %10

	RST.L	%08		; I/O HELPER
	OUT	(C), D		; OUT (%FF10), %23

	RST.L	%08		; I/O HELPER
	OUT	(C), E		; OUT (%FF10), %34

	RST.L	%08		; I/O HELPER
	OUT	(C), H		; OUT (%FF10), %45

	RST.L	%08		; I/O HELPER
	OUT	(C), L		; OUT (%FF10), %56


	RST.L	%08		; I/O HELPER
	IN	A, (C)		; IN (%FF10), A

	RST.L	%08		; I/O HELPER
	IN	B, (C)		; IN (%FF10), B
	LD	B, %54

	RST.L	%08		; I/O HELPER
	IN	C, (C)		; IN (%FF10), C
	LD	C, %10

	RST.L	%08		; I/O HELPER
	IN	D, (C)		; IN (%FF10), D

	RST.L	%08		; I/O HELPER
	IN	E, (C)		; IN (%FF10), E

	RST.L	%08		; I/O HELPER
	IN	H, (C)		; IN (%FF10), H

	RST.L	%08		; I/O HELPER
	IN	L, (C)		; IN (%FF10), L

	NOP
	NOP
	NOP
	NOP

	;LD	A, 2
	;LD	BC, %1234
	;RST.L	%10		; ACCESS FUNCTION 2

	;LD	A, %03		; bank to switch to
	;RST.L	%18		; fast bank switchiing


	RET.L
step1_end:

step1_size	equ	step1_end-step1
