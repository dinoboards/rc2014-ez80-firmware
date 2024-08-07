;************************************************************************
;*    eZ80F92.inc
;*
;*		eZ80F92 Registers
;*
;************************************************************************
;* Start eZ80F92 Include file

;* TIMER registers

TMR0_CTL:	.equ	%80
TMR0_DR_L:	.equ	%81
TMR0_RR_L:	.equ	%81
TMR0_DR_H:	.equ	%82
TMR0_RR_H:	.equ	%82
TMR1_CTL:	.equ	%83
TMR1_DR_L:	.equ	%84
TMR1_RR_L:	.equ	%84
TMR1_DR_H:	.equ	%85
TMR1_RR_H:	.equ	%85
TMR2_CTL:	.equ	%86
TMR2_DR_L:	.equ	%87
TMR2_RR_L:	.equ	%87
TMR2_DR_H:	.equ	%88
TMR2_RR_H:	.equ	%88
TMR3_CTL:	.equ	%89
TMR3_DR_L:	.equ	%8a
TMR3_RR_L:	.equ	%8a
TMR3_DR_H:	.equ	%8b
TMR3_RR_H:	.equ	%8b
TMR4_CTL:	.equ	%8c
TMR4_DR_L:	.equ	%8d
TMR4_RR_L:	.equ	%8d
TMR4_DR_H:	.equ	%8e
TMR4_RR_H:	.equ	%8e
TMR5_CTL:	.equ	%8f
TMR5_DR_L:	.equ	%90
TMR5_RR_L:	.equ	%90
TMR5_DR_H:	.equ	%91
TMR5_RR_H:	.equ	%91
TMR_ISS:	.equ	%92

;* WDT Registers

WDT_CTL:	.equ	%93
WDT_RR:		.equ	%94


;* PORT Registers

PB_DR:		.equ	%9A
PB_DDR:		.equ	%9B
PB_ALT1:	.equ	%9C
PB_ALT2:	.equ	%9D
PC_DR:		.equ	%9E
PC_DDR:		.equ	%9F
PC_ALT1:	.equ	%A0
PC_ALT2:	.equ	%A1
PD_DR:		.equ	%A2
PD_DDR:		.equ	%A3
PD_ALT1:	.equ	%A4
PD_ALT2:	.equ	%A5

;* Chip Select
CS0_LBR:	.equ	%A8
CS0_UBR:	.equ	%A9
CS0_CTL:	.equ	%AA
CS1_LBR:	.equ	%AB
CS1_UBR:	.equ	%AC
CS1_CTL:	.equ	%AD
CS2_LBR:	.equ	%AE
CS2_UBR:	.equ	%AF
CS2_CTL:	.equ	%B0
CS3_LBR:	.equ	%B1
CS3_UBR:	.equ	%B2
CS3_CTL:	.equ	%B3

;* RAMCTL Registers
RAM_CTL0:	.equ	%B4
RAM_CTL:	.equ	%B4
RAM_ADDR_U:	.equ	%B5

;* SPI Registers

SPI_BRG_L:	.equ	%B8
SPI_BRG_H:	.equ	%B9
SPI_CTL:	.equ	%BA
SPI_SR:		.equ	%BB
SPI_RBR:	.equ	%BC
SPI_TSR:	.equ	%BC

;* UART0 Registers

UART0_RBR:	.equ	%C0
UART0_THR:	.equ	%C0
UART0_BRG_L:	.equ	%C0
UART0_IER:	.equ	%C1
UART0_BRG_H:	.equ	%C1
UART0_IIR:	.equ	%C2
UART0_FCTL:	.equ	%C2
UART0_LCTL:	.equ	%C3
UART0_MCTL:	.equ	%C4
UART0_LSR:	.equ	%C5
UART0_MSR:	.equ	%C6
UART0_SPR:	.equ	%C7

;* I2C Registers

I2C_SAR:	.equ	%C8
I2C_XSAR:	.equ	%C9
I2C_DR:		.equ	%CA
I2C_CTL:	.equ	%CB
I2C_SR:		.equ	%CC
I2C_CCR:	.equ	%CC
I2C_SRR:	.equ	%CD

;* UART1 Registers

UART1_RBR:	.equ	%D0
UART1_THR:	.equ	%D0
UART1_BRG_L:	.equ	%D0
UART1_IER:	.equ	%D1
UART1_BRG_H:	.equ	%D1
UART1_IIR:	.equ	%D2
UART1_FCTL:	.equ	%D2
UART1_LCTL:	.equ	%D3
UART1_MCTL:	.equ	%D4
UART1_LSR:	.equ	%D5
UART1_MSR:	.equ	%D6
UART1_SPR:	.equ	%D7

;* IR Registers

IR_CTL:		.equ   %BF

;* CLK Registers

CLK_PPD1:	.equ   %DB
CLK_PPD2:	.equ   %DC

;* RTC Registers

RTC_SEC:	.equ	%E0
RTC_MIN:	.equ	%E1
RTC_HRS:	.equ	%E2
RTC_DOW:	.equ	%E3
RTC_DOM:	.equ	%E4
RTC_MON:	.equ	%E5
RTC_YR:		.equ	%E6
RTC_CEN:	.equ	%E7
RTC_ASEC:	.equ	%E8
RTC_AMIN:	.equ	%E9
RTC_AHRS:	.equ	%EA
RTC_ADOW:	.equ	%EB
RTC_ACTRL:	.equ	%EC
RTC_CTRL:	.equ	%ED

;* CSBMC Registers

CS0_BMC:	.equ	%F0
CS1_BMC:	.equ	%F1
CS2_BMC:	.equ	%F2
CS3_BMC:	.equ	%F3

;* FLASH Registers

FLASH_KEY:	.equ	%F5
FLASH_DATA:	.equ	%F6
FLASH_ADDR_U:	.equ	%F7
FLASH_CTRL:	.equ	%F8
FLASH_FDIV:	.equ	%F9
FLASH_PROT:	.equ	%FA
FLASH_IRQ:	.equ	%FB
FLASH_PAGE:	.equ	%FC
FLASH_ROW:	.equ	%FD
FLASH_COL:	.equ	%FE
FLASH_PGCTL:	.equ	%FF

CSX_WAIT_7	equ	(7 << 5)
CSX_WAIT_6	equ	(6 << 5)
CSX_WAIT_5	equ	(5 << 5)
CSX_WAIT_4	equ	(4 << 5)
CSX_WAIT_3	equ	(3 << 5)
CSX_WAIT_2	equ	(2 << 5)
CSX_WAIT_1	equ	(1 << 5)
CSX_WAIT_0	equ	(0 << 5)
CSX_TYPE_IO	equ	%10
CSX_TYPE_MEM	equ	0
CSX_ENABLED	equ	%08
CSX_DISABLED	equ	0

BMX_BM_EZ80		equ	(%00 << 6)
BMX_BM_Z80		equ	(%01 << 6)
BMX_BM_INTEL		equ	(%02 << 6)
BMX_BM_MOTOROLA		equ	(%03 << 6)
BMX_AD_SEPERATE		equ	(%0 << 5)
BMX_AD_MULTIPLEX	equ	(%1 << 5)
BMX_BC_0		equ	%00
BMX_BC_1		equ	%01
BMX_BC_2		equ	%02
BMX_BC_3		equ	%03
BMX_BC_4		equ	%04
BMX_BC_5		equ	%05
BMX_BC_6		equ	%06
BMX_BC_7		equ	%07
BMX_BC_8		equ	%08
BMX_BC_9		equ	%09
BMX_BC_10		equ	%0A
BMX_BC_11		equ	%0B
BMX_BC_12		equ	%0C
BMX_BC_13		equ	%0D
BMX_BC_14		equ	%0E
BMX_BC_15		equ	%0F

TMR_ENABLED		equ	(1 << 0)
TMR_RST_EN		equ	(1 << 1)
TMR_CLK_DIV_4		equ	(0 << 2)
TMR_CLK_DIV_16		equ	(1 << 2)
TMR_CLK_DIV_64		equ	(2 << 2)
TMR_CLK_DIV_256		equ	(3 << 2)
TMR_SINGLE		equ	(0 << 4)
TMR_CONTINUOUS		equ	(1 << 4)
TMR_IRQ_EN		equ	(1 << 6)

P5_ALT2			EQU	(1<<5)
P4_ALT2			EQU	(1<<4)
P4_ALT1			EQU	(1<<4)
P5_DDR			EQU	(1<<5)


RTC_INT_DISABLE		EQU	%00
RTC_INT_ENABLE		EQU	%40
RTC_BCD_DISABLE		EQU	%00
RTC_BCD_ENABLE		EQU	%20
RTC_CLK_32KHZ		EQU	%00
RTC_CLK_60HZ		EQU	%10
RTC_CLK_50HZ		EQU	%18
RTC_UNLOCK		EQU	%01
RTC_LOCK		EQU	%00

RTC_ALARM_INT_ACTIVE	EQU	%80		; READ ONLY
RTC_SLP_WAKE_ACTIVE	EQU	%02		; READ ONLY

LCTL_5_BITS		EQU	%00		; 0000 0000
LCTL_6_BITS		EQU	%01		; 0000 0001
LCTL_7_BITS		EQU	%02		; 0000 0010
LCTL_8_BITS		EQU	%03		; 0000 0011
LCTL_1_STOP_BIT		EQU	%00		; 0000 0000
LCTL_2_STOP_BITS	EQU	%04		; 0000 0100
LCTL_NO_PARITY		EQU	%00		; 0000 0000
; LCTL_PARITY_ENABLED	EQU	%08		; 0000 1000
LCTL_ODD_PARITY		EQU	%08		; 0000 1000
LCTL_EVEN_PARITY	EQU	%18		; 0001 1000
LCTL_FORCE_PARITY_ERROR	EQU	%20		; 0010 0000
LCTL_SBREAK		EQU	%40		; 0100 0000

;;  UART_FCTL bits
UART_FCTL_TRIGMASK	EQU	%00
UART_FCTL_TRIG_1	EQU	%00
UART_FCTL_TRIG_4	EQU	%40
UART_FCTL_TRIG_8	EQU	%80
UART_FCTL_TRIG_14	EQU	%C0
UART_FCTL_CLRTxF	EQU	%04
UART_FCTL_CLRRxF	EQU	%02
UART_FCTL_FIFOEN	EQU	%01

LCTL_DLAB		EQU	(1 << 7)
LSR_THRE		EQU	(1 << 5)
LSR_DR			EQU	(1 << 0)
MCTL_RTS		EQU	(1 << 1)
MCTL_DTR		EQU	(1 << 0)

; UART_MSR bits
MSR_DCD			EQU	%80
MSR_RI			EQU	%40
MSR_DSR			EQU	%20
MSR_CTS			EQU	%10
MSR_DDCD		EQU	%08
MSR_TERI		EQU	%04
MSR_DDSR		EQU	%02
MSR_DCTS		EQU	%01

; TIMER INPUT SELECTIONS FOR TMR_ISS

TMR3_IN_SYSCLK		EQU	%00 << 6
TMR3_IN_RTC		EQU	%01 << 6
TMR3_IN_B1		EQU	%02 << 6

TMR2_IN_SYSCLK		EQU	%00 << 4
TMR2_IN_RTC		EQU	%01 << 4
TMR2_IN_B0		EQU	%02 << 4

TMR1_IN_SYSCLK		EQU	%00 << 2
TMR1_IN_RTC		EQU	%01 << 2
TMR1_IN_B1		EQU	%02 << 2

TMR0_IN_SYSCLK		EQU	%00
TMR0_IN_RTC		EQU	%01
TMR0_IN_B0		EQU	%02


;* End eZ80F92 inc file
