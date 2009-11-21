;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.8.5 #5516 (Sep 20 2009) (UNIX)
; This file was generated Sat Nov 21 16:29:05 2009
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f4550
	__config 0x300000, 0x10
	__config 0x300001, 0x0a
	__config 0x300002, 0x00
	__config 0x300003, 0x00
	__config 0x300005, 0x01
	__config 0x300006, 0x80

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _main

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern _SPPDATAbits
	extern _SPPCFGbits
	extern _SPPEPSbits
	extern _SPPCONbits
	extern _UFRMLbits
	extern _UFRMHbits
	extern _UIRbits
	extern _UIEbits
	extern _UEIRbits
	extern _UEIEbits
	extern _USTATbits
	extern _UCONbits
	extern _UADDRbits
	extern _UCFGbits
	extern _UEP0bits
	extern _UEP1bits
	extern _UEP2bits
	extern _UEP3bits
	extern _UEP4bits
	extern _UEP5bits
	extern _UEP6bits
	extern _UEP7bits
	extern _UEP8bits
	extern _UEP9bits
	extern _UEP10bits
	extern _UEP11bits
	extern _UEP12bits
	extern _UEP13bits
	extern _UEP14bits
	extern _UEP15bits
	extern _PORTAbits
	extern _PORTBbits
	extern _PORTCbits
	extern _PORTDbits
	extern _PORTEbits
	extern _LATAbits
	extern _LATBbits
	extern _LATCbits
	extern _LATDbits
	extern _LATEbits
	extern _TRISAbits
	extern _TRISBbits
	extern _TRISCbits
	extern _TRISDbits
	extern _TRISEbits
	extern _OSCTUNEbits
	extern _PIE1bits
	extern _PIR1bits
	extern _IPR1bits
	extern _PIE2bits
	extern _PIR2bits
	extern _IPR2bits
	extern _EECON1bits
	extern _RCSTAbits
	extern _TXSTAbits
	extern _T3CONbits
	extern _CMCONbits
	extern _CVRCONbits
	extern _ECCP1ASbits
	extern _ECCP1DELbits
	extern _BAUDCONbits
	extern _CCP2CONbits
	extern _CCP1CONbits
	extern _ADCON2bits
	extern _ADCON1bits
	extern _ADCON0bits
	extern _SSPCON2bits
	extern _SSPCON1bits
	extern _SSPSTATbits
	extern _T2CONbits
	extern _T1CONbits
	extern _RCONbits
	extern _WDTCONbits
	extern _HLVDCONbits
	extern _OSCCONbits
	extern _T0CONbits
	extern _STATUSbits
	extern _FSR2Hbits
	extern _BSRbits
	extern _FSR1Hbits
	extern _FSR0Hbits
	extern _INTCON3bits
	extern _INTCON2bits
	extern _INTCONbits
	extern _TBLPTRUbits
	extern _PCLATHbits
	extern _PCLATUbits
	extern _STKPTRbits
	extern _TOSUbits
	extern _int_counter
	extern _SPPDATA
	extern _SPPCFG
	extern _SPPEPS
	extern _SPPCON
	extern _UFRML
	extern _UFRMH
	extern _UIR
	extern _UIE
	extern _UEIR
	extern _UEIE
	extern _USTAT
	extern _UCON
	extern _UADDR
	extern _UCFG
	extern _UEP0
	extern _UEP1
	extern _UEP2
	extern _UEP3
	extern _UEP4
	extern _UEP5
	extern _UEP6
	extern _UEP7
	extern _UEP8
	extern _UEP9
	extern _UEP10
	extern _UEP11
	extern _UEP12
	extern _UEP13
	extern _UEP14
	extern _UEP15
	extern _PORTA
	extern _PORTB
	extern _PORTC
	extern _PORTD
	extern _PORTE
	extern _LATA
	extern _LATB
	extern _LATC
	extern _LATD
	extern _LATE
	extern _TRISA
	extern _TRISB
	extern _TRISC
	extern _TRISD
	extern _TRISE
	extern _OSCTUNE
	extern _PIE1
	extern _PIR1
	extern _IPR1
	extern _PIE2
	extern _PIR2
	extern _IPR2
	extern _EECON1
	extern _EECON2
	extern _EEDATA
	extern _EEADR
	extern _RCSTA
	extern _TXSTA
	extern _TXREG
	extern _RCREG
	extern _SPBRG
	extern _SPBRGH
	extern _T3CON
	extern _TMR3L
	extern _TMR3H
	extern _CMCON
	extern _CVRCON
	extern _ECCP1AS
	extern _ECCP1DEL
	extern _BAUDCON
	extern _CCP2CON
	extern _CCPR2L
	extern _CCPR2H
	extern _CCP1CON
	extern _CCPR1L
	extern _CCPR1H
	extern _ADCON2
	extern _ADCON1
	extern _ADCON0
	extern _ADRESL
	extern _ADRESH
	extern _SSPCON2
	extern _SSPCON1
	extern _SSPSTAT
	extern _SSPADD
	extern _SSPBUF
	extern _T2CON
	extern _PR2
	extern _TMR2
	extern _T1CON
	extern _TMR1L
	extern _TMR1H
	extern _RCON
	extern _WDTCON
	extern _HLVDCON
	extern _OSCCON
	extern _T0CON
	extern _TMR0L
	extern _TMR0H
	extern _STATUS
	extern _FSR2L
	extern _FSR2H
	extern _PLUSW2
	extern _PREINC2
	extern _POSTDEC2
	extern _POSTINC2
	extern _INDF2
	extern _BSR
	extern _FSR1L
	extern _FSR1H
	extern _PLUSW1
	extern _PREINC1
	extern _POSTDEC1
	extern _POSTINC1
	extern _INDF1
	extern _WREG
	extern _FSR0L
	extern _FSR0H
	extern _PLUSW0
	extern _PREINC0
	extern _POSTDEC0
	extern _POSTINC0
	extern _INDF0
	extern _INTCON3
	extern _INTCON2
	extern _INTCON
	extern _PRODL
	extern _PRODH
	extern _TABLAT
	extern _TBLPTRL
	extern _TBLPTRH
	extern _TBLPTRU
	extern _PCL
	extern _PCLATH
	extern _PCLATU
	extern _STKPTR
	extern _TOSL
	extern _TOSH
	extern _TOSU
	extern _int_setup
	extern _osc_setup
	extern _serial_setup
	extern _serial_pop_fifo
	extern _m600_setup
	extern _m600_start_request
	extern _m600_schedule
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
WREG	equ	0xfe8
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PRODL	equ	0xff3


	idata
_toggle_led_ledc_1_1	db	0x00, 0x00
_toggle_led_ledv_1_1	db	0x00


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1

udata_main_0	udata
_main_is_done_1_1	res	2

udata_main_1	udata
_main_req_1_1	res	1

;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_main__main	code
_main:
	BANKSEL	_main_is_done_1_1
;	.line	37; ../src/main.c	volatile int is_done = 0;
	CLRF	_main_is_done_1_1, B
	BANKSEL	(_main_is_done_1_1 + 1)
	CLRF	(_main_is_done_1_1 + 1), B
;	.line	40; ../src/main.c	osc_setup();
	CALL	_osc_setup
;	.line	41; ../src/main.c	int_setup();
	CALL	_int_setup
;	.line	42; ../src/main.c	m600_setup();
	CALL	_m600_setup
;	.line	44; ../src/main.c	serial_setup();
	CALL	_serial_setup
_00117_DS_:
	BANKSEL	_main_is_done_1_1
;	.line	46; ../src/main.c	while (!is_done)
	MOVF	_main_is_done_1_1, W, B
	BANKSEL	(_main_is_done_1_1 + 1)
	IORWF	(_main_is_done_1_1 + 1), W, B
	BNZ	_00119_DS_
;	.line	48; ../src/main.c	toggle_led();
	CALL	_toggle_led
;	.line	53; ../src/main.c	if (serial_pop_fifo((unsigned char*)&req) == -1)
	MOVLW	HIGH(_main_req_1_1)
	MOVWF	r0x01
	MOVLW	LOW(_main_req_1_1)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serial_pop_fifo
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x03
	ADDWF	FSR1L, F
	MOVF	r0x00, W
	XORLW	0xff
	BNZ	_00126_DS_
	MOVF	r0x01, W
	XORLW	0xff
	BZ	_00117_DS_
_00126_DS_:
	BANKSEL	_main_req_1_1
;	.line	57; ../src/main.c	m600_start_request(req);
	MOVF	_main_req_1_1, W, B
	MOVWF	POSTDEC1
	CALL	_m600_start_request
	INCF	FSR1L, F
;	.line	58; ../src/main.c	m600_schedule();
	CALL	_m600_schedule
	BRA	_00117_DS_
_00119_DS_:
;	.line	61; ../src/main.c	return 0;
	CLRF	PRODL
	CLRF	WREG
	RETURN	

; ; Starting pCode block
S_main__toggle_led	code
_toggle_led:
;	.line	19; ../src/main.c	static void toggle_led(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	BANKSEL	_toggle_led_ledc_1_1
;	.line	24; ../src/main.c	if (++ledc < 0x4000)
	INCF	_toggle_led_ledc_1_1, F, B
	BNC	_10115_DS_
	BANKSEL	(_toggle_led_ledc_1_1 + 1)
	INCF	(_toggle_led_ledc_1_1 + 1), F, B
_10115_DS_:
	MOVLW	0x40
	BANKSEL	(_toggle_led_ledc_1_1 + 1)
	SUBWF	(_toggle_led_ledc_1_1 + 1), W, B
	BNZ	_00110_DS_
	MOVLW	0x00
	BANKSEL	_toggle_led_ledc_1_1
	SUBWF	_toggle_led_ledc_1_1, W, B
_00110_DS_:
;	.line	25; ../src/main.c	return ;
	BNC	_00107_DS_
;	.line	27; ../src/main.c	ledv ^= 1;
	MOVLW	0x01
	BANKSEL	_toggle_led_ledv_1_1
	XORWF	_toggle_led_ledv_1_1, F, B
;	.line	29; ../src/main.c	TRISA = 0;
	CLRF	_TRISA
;	.line	30; ../src/main.c	LATA = ledv;
	MOVFF	_toggle_led_ledv_1_1, _LATA
_00107_DS_:
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	  164 (0x00a4) bytes ( 0.13%)
;           	   82 (0x0052) words
; udata size:	    3 (0x0003) bytes ( 0.17%)
; access size:	    3 (0x0003) bytes


	end
