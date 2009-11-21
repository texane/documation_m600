;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.8.5 #5516 (Sep 20 2009) (UNIX)
; This file was generated Sat Nov 21 16:31:00 2009
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f4550

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _serial_setup
	global _serial_sleep
	global _serial_read
	global _serial_pop_fifo
	global _serial_write
	global _serial_writei
	global _serial_writeb
	global _serial_handle_interrupt

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern __gptrget1
	extern __gptrput1
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
	extern _osc_set_power
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
WREG	equ	0xfe8
FSR0L	equ	0xfe9
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3
PRODH	equ	0xff4


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1
r0x05	res	1
r0x06	res	1
r0x07	res	1
r0x08	res	1
r0x09	res	1

udata_serial_0	udata
_gfifo	res	9

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_serial__serial_handle_interrupt	code
_serial_handle_interrupt:
;	.line	253; ../src/serial.c	void serial_handle_interrupt(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
;	.line	255; ../src/serial.c	if (!PIR1bits.RCIF)
	BTFSC	_PIR1bits, 5
	BRA	_00214_DS_
;	.line	256; ../src/serial.c	return ;
	BRA	_00224_DS_
_00214_DS_:
;	.line	258; ../src/serial.c	if (RCSTAbits.OERR)
	BTFSS	_RCSTAbits, 1
	BRA	_00222_DS_
	;	VOLATILE READ - BEGIN
	MOVF	_RCREG, W
	;	VOLATILE READ - END
	BANKSEL	_gfifo
;	.line	264; ../src/serial.c	gfifo.error = 1;
	BSF	_gfifo, 6, B
	BRA	_00223_DS_
_00222_DS_:
;	.line	266; ../src/serial.c	else if (RCSTAbits.FERR)
	BTFSS	_RCSTAbits, 2
	BRA	_00219_DS_
;	.line	268; ../src/serial.c	RCSTAbits.CREN = 0;
	BCF	_RCSTAbits, 4
;	.line	269; ../src/serial.c	RCSTAbits.CREN = 1;
	BSF	_RCSTAbits, 4
	BANKSEL	_gfifo
;	.line	271; ../src/serial.c	gfifo.error = 1;
	BSF	_gfifo, 6, B
	BRA	_00223_DS_
_00219_DS_:
	BANKSEL	_gfifo
;	.line	275; ../src/serial.c	if (gfifo.size < sizeof(gfifo.buffer))
	MOVF	_gfifo, W, B
	ANDLW	0x0f
	MOVWF	r0x00
	MOVF	r0x00, W
	ADDLW	0x80
	ADDLW	0x78
	BC	_00216_DS_
;	.line	276; ../src/serial.c	fifo_push(&gfifo, RCREG);
	MOVLW	HIGH(_gfifo)
	MOVWF	r0x01
	MOVLW	LOW(_gfifo)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVF	_RCREG, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_fifo_push
	MOVLW	0x04
	ADDWF	FSR1L, F
	BRA	_00223_DS_
_00216_DS_:
	BANKSEL	_gfifo
;	.line	278; ../src/serial.c	gfifo.overflow = 1;
	BSF	_gfifo, 7, B
_00223_DS_:
;	.line	281; ../src/serial.c	PIR1bits.RCIF = 0;
	BCF	_PIR1bits, 5
_00224_DS_:
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_serial__serial_writeb	code
_serial_writeb:
;	.line	247; ../src/serial.c	void serial_writeb(unsigned char b)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	249; ../src/serial.c	write_byte(b);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_write_byte
	INCF	FSR1L, F
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_serial__serial_writei	code
_serial_writei:
;	.line	239; ../src/serial.c	void serial_writei(unsigned int i)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	242; ../src/serial.c	write_byte(MASK_BYTE(i, 0));
	MOVFF	r0x01, r0x03
	MOVFF	r0x00, r0x02
	CLRF	r0x03
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_write_byte
	INCF	FSR1L, F
;	.line	243; ../src/serial.c	write_byte(MASK_BYTE(i, 1));
	MOVF	r0x01, W
	MOVWF	r0x00
	CLRF	r0x01
	CLRF	r0x01
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_write_byte
	INCF	FSR1L, F
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_serial__serial_write	code
_serial_write:
;	.line	230; ../src/serial.c	void serial_write(unsigned char* s, unsigned int len)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x09, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
	MOVLW	0x06
	MOVFF	PLUSW2, r0x04
;	.line	234; ../src/serial.c	for (i = 0; i < len; ++i)
	CLRF	r0x05
	CLRF	r0x06
_00189_DS_:
	MOVF	r0x04, W
	SUBWF	r0x06, W
	BNZ	_00198_DS_
	MOVF	r0x03, W
	SUBWF	r0x05, W
_00198_DS_:
	BC	_00193_DS_
;	.line	235; ../src/serial.c	write_byte(s[i]);
	MOVF	r0x05, W
	ADDWF	r0x00, W
	MOVWF	r0x07
	MOVF	r0x06, W
	ADDWFC	r0x01, W
	MOVWF	r0x08
	CLRF	WREG
	ADDWFC	r0x02, W
	MOVWF	r0x09
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, PRODL
	MOVF	r0x09, W
	CALL	__gptrget1
	MOVWF	r0x07
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	CALL	_write_byte
	INCF	FSR1L, F
;	.line	234; ../src/serial.c	for (i = 0; i < len; ++i)
	INCF	r0x05, F
	BTFSC	STATUS, 0
	INCF	r0x06, F
	BRA	_00189_DS_
_00193_DS_:
	MOVFF	PREINC1, r0x09
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_serial__serial_pop_fifo	code
_serial_pop_fifo:
;	.line	212; ../src/serial.c	int serial_pop_fifo(unsigned char* c)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
;	.line	214; ../src/serial.c	int res = -1;
	MOVLW	0xff
	MOVWF	r0x03
	MOVWF	r0x04
;	.line	216; ../src/serial.c	fifo_lock(&gfifo);
	MOVLW	HIGH(_gfifo)
	MOVWF	r0x06
	MOVLW	LOW(_gfifo)
	MOVWF	r0x05
	MOVLW	0x80
	MOVWF	r0x07
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	CALL	_fifo_lock
	MOVLW	0x03
	ADDWF	FSR1L, F
	BANKSEL	_gfifo
;	.line	218; ../src/serial.c	if (gfifo.size)
	MOVF	_gfifo, W, B
	ANDLW	0x0f
	MOVWF	r0x05
	MOVF	r0x05, W
	BZ	_00183_DS_
;	.line	220; ../src/serial.c	*c = fifo_pop(&gfifo);
	MOVLW	HIGH(_gfifo)
	MOVWF	r0x06
	MOVLW	LOW(_gfifo)
	MOVWF	r0x05
	MOVLW	0x80
	MOVWF	r0x07
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	CALL	_fifo_pop
	MOVWF	r0x05
	MOVLW	0x03
	ADDWF	FSR1L, F
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrput1
;	.line	221; ../src/serial.c	res = 0;
	CLRF	r0x03
	CLRF	r0x04
_00183_DS_:
;	.line	224; ../src/serial.c	fifo_unlock(&gfifo);
	MOVLW	HIGH(_gfifo)
	MOVWF	r0x01
	MOVLW	LOW(_gfifo)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_fifo_unlock
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	226; ../src/serial.c	return res;
	MOVFF	r0x04, PRODL
	MOVF	r0x03, W
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_serial__serial_read	code
_serial_read:
;	.line	204; ../src/serial.c	void serial_read(unsigned char* s, unsigned char len)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
;	.line	208; ../src/serial.c	*s = peek_byte();
	CALL	_peek_byte
	MOVWF	r0x03
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrput1
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_serial__serial_sleep	code
_serial_sleep:
;	.line	191; ../src/serial.c	void serial_sleep(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	195; ../src/serial.c	osc_set_power(OSC_PMODE_PRI_IDLE);
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	_osc_set_power
	INCF	FSR1L, F
_00170_DS_:
	sleep 
	BRA	_00170_DS_
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_serial__serial_setup	code
_serial_setup:
;	.line	156; ../src/serial.c	void serial_setup(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
;	.line	158; ../src/serial.c	fifo_init(&gfifo);
	MOVLW	HIGH(_gfifo)
	MOVWF	r0x01
	MOVLW	LOW(_gfifo)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_fifo_init
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	160; ../src/serial.c	SERIAL_TX_TRIS = 0;
	BCF	_TRISCbits, 6
;	.line	161; ../src/serial.c	SERIAL_RX_TRIS = 1;
	BSF	_TRISCbits, 7
;	.line	166; ../src/serial.c	TXSTA = 0;
	CLRF	_TXSTA
;	.line	167; ../src/serial.c	TXSTAbits.TXEN = 1;
	BSF	_TXSTAbits, 5
;	.line	169; ../src/serial.c	RCSTA = 0;
	CLRF	_RCSTA
;	.line	170; ../src/serial.c	RCSTAbits.SPEN = 1;
	BSF	_RCSTAbits, 7
;	.line	171; ../src/serial.c	RCSTAbits.CREN = 1;
	BSF	_RCSTAbits, 4
;	.line	176; ../src/serial.c	PIR1bits.RCIF = 0;
	BCF	_PIR1bits, 5
;	.line	177; ../src/serial.c	PIR1bits.TXIF = 0;
	BCF	_PIR1bits, 4
;	.line	178; ../src/serial.c	PIE1bits.RCIE = 1;
	BSF	_PIE1bits, 5
;	.line	179; ../src/serial.c	PIE1bits.TXIE = 0;
	BCF	_PIE1bits, 4
;	.line	184; ../src/serial.c	SPBRG = 12;
	MOVLW	0x0c
	MOVWF	_SPBRG
;	.line	185; ../src/serial.c	TXSTA = 0x20;
	MOVLW	0x20
	MOVWF	_TXSTA
;	.line	187; ../src/serial.c	BAUDCON = 0x00;
	CLRF	_BAUDCON
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_serial__read_byte	code
_read_byte:
;	.line	126; ../src/serial.c	static unsigned char read_byte(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
;	.line	128; ../src/serial.c	unsigned char has_read = 0;
	CLRF	r0x00
;	.line	129; ../src/serial.c	unsigned char c = 0;
	CLRF	r0x01
_00156_DS_:
;	.line	131; ../src/serial.c	while (!has_read)
	MOVF	r0x00, W
	BTFSS	STATUS, 2
	BRA	_00158_DS_
;	.line	133; ../src/serial.c	int_wait();
	CALL	_int_wait
;	.line	135; ../src/serial.c	fifo_lock(&gfifo);
	MOVLW	HIGH(_gfifo)
	MOVWF	r0x03
	MOVLW	LOW(_gfifo)
	MOVWF	r0x02
	MOVLW	0x80
	MOVWF	r0x04
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_fifo_lock
	MOVLW	0x03
	ADDWF	FSR1L, F
	BANKSEL	_gfifo
;	.line	137; ../src/serial.c	if (gfifo.size)
	MOVF	_gfifo, W, B
	ANDLW	0x0f
	MOVWF	r0x02
	MOVF	r0x02, W
	BZ	_00154_DS_
;	.line	139; ../src/serial.c	c = fifo_pop(&gfifo);
	MOVLW	HIGH(_gfifo)
	MOVWF	r0x03
	MOVLW	LOW(_gfifo)
	MOVWF	r0x02
	MOVLW	0x80
	MOVWF	r0x04
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_fifo_pop
	MOVWF	r0x01
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	140; ../src/serial.c	has_read = 1;
	MOVLW	0x01
	MOVWF	r0x00
	BRA	_00155_DS_
_00154_DS_:
	BANKSEL	_gfifo
;	.line	142; ../src/serial.c	else if (gfifo.error)
	BTFSS	_gfifo, 6, B
	BRA	_00155_DS_
;	.line	144; ../src/serial.c	has_read = 1;
	MOVLW	0x01
	MOVWF	r0x00
_00155_DS_:
;	.line	147; ../src/serial.c	fifo_unlock(&gfifo);
	MOVLW	HIGH(_gfifo)
	MOVWF	r0x03
	MOVLW	LOW(_gfifo)
	MOVWF	r0x02
	MOVLW	0x80
	MOVWF	r0x04
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_fifo_unlock
	MOVLW	0x03
	ADDWF	FSR1L, F
	BRA	_00156_DS_
_00158_DS_:
;	.line	150; ../src/serial.c	return c;
	MOVF	r0x01, W
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_serial__int_wait	code
_int_wait:
;	.line	117; ../src/serial.c	static void int_wait(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	119; ../src/serial.c	INTCONbits.PEIE = 1;
	BSF	_INTCONbits, 6
;	.line	120; ../src/serial.c	INTCONbits.GIE = 1;
	BSF	_INTCONbits, 7
	SLEEP 
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_serial__peek_byte	code
_peek_byte:
;	.line	102; ../src/serial.c	static unsigned char peek_byte(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
_00138_DS_:
;	.line	106; ../src/serial.c	while (!PIR1bits.RCIF)
	BTFSS	_PIR1bits, 5
	BRA	_00138_DS_
;	.line	109; ../src/serial.c	c = RCREG;
	MOVFF	_RCREG, r0x00
;	.line	111; ../src/serial.c	PIR1bits.RCIF = 0;
	BCF	_PIR1bits, 5
;	.line	113; ../src/serial.c	return c;
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_serial__write_byte	code
_write_byte:
;	.line	81; ../src/serial.c	static void write_byte(unsigned char c)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVLW	0x02
	MOVFF	PLUSW2, _TXREG
	NOP 
	NOP 
	NOP 
_00130_DS_:
;	.line	95; ../src/serial.c	while (!PIR1bits.TXIF)
	BTFSS	_PIR1bits, 4
	BRA	_00130_DS_
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_serial__fifo_unlock	code
_fifo_unlock:
;	.line	64; ../src/serial.c	static void fifo_unlock(struct fifo* f)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
;	.line	66; ../src/serial.c	INTCONbits.PEIE = f->peie;
	MOVFF	r0x00, r0x03
	MOVFF	r0x01, r0x04
	MOVFF	r0x02, r0x05
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
	SWAPF	WREG, W
	RRNCF	WREG, W
	ANDLW	0x01
	MOVWF	r0x03
	MOVF	r0x03, W
	ANDLW	0x01
	RRNCF	WREG, W
	RRNCF	WREG, W
	MOVWF	PRODH
	MOVF	_INTCONbits, W
	ANDLW	0xbf
	IORWF	PRODH, W
	MOVWF	_INTCONbits
;	.line	67; ../src/serial.c	INTCONbits.GIE = f->gie;
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	SWAPF	WREG, W
	ANDLW	0x01
	MOVWF	r0x00
	MOVF	r0x00, W
	ANDLW	0x01
	RRNCF	WREG, W
	MOVWF	PRODH
	MOVF	_INTCONbits, W
	ANDLW	0x7f
	IORWF	PRODH, W
	MOVWF	_INTCONbits
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_serial__fifo_lock	code
_fifo_lock:
;	.line	54; ../src/serial.c	static void fifo_lock(struct fifo* f)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
;	.line	56; ../src/serial.c	f->gie = INTCONbits.GIE;
	MOVFF	r0x00, r0x03
	MOVFF	r0x01, r0x04
	MOVFF	r0x02, r0x05
	CLRF	r0x06
	BTFSC	_INTCONbits, 7
	INCF	r0x06, F
	MOVF	r0x06, W
	ANDLW	0x01
	SWAPF	WREG, W
	MOVWF	PRODH
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
	ANDLW	0xef
	IORWF	PRODH, W
	MOVWF	POSTDEC1
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrput1
;	.line	57; ../src/serial.c	f->peie = INTCONbits.PEIE;
	CLRF	r0x03
	BTFSC	_INTCONbits, 6
	INCF	r0x03, F
	MOVF	r0x03, W
	ANDLW	0x01
	SWAPF	WREG, W
	RLNCF	WREG, W
	MOVWF	PRODH
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	ANDLW	0xdf
	IORWF	PRODH, W
	MOVWF	POSTDEC1
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrput1
;	.line	59; ../src/serial.c	INTCONbits.GIE = 0;
	BCF	_INTCONbits, 7
;	.line	60; ../src/serial.c	INTCONbits.PEIE = 0;
	BCF	_INTCONbits, 6
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_serial__fifo_push	code
_fifo_push:
;	.line	48; ../src/serial.c	static void fifo_push(struct fifo* f, unsigned char c)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
;	.line	50; ../src/serial.c	f->buffer[f->size++] = c;
	MOVF	r0x00, W
	ADDLW	0x01
	MOVWF	r0x04
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x05
	MOVLW	0x00
	ADDWFC	r0x02, W
	MOVWF	r0x06
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	ANDLW	0x0f
	MOVWF	r0x07
	INCF	r0x07, W
	MOVWF	r0x08
	MOVF	r0x08, W
	ANDLW	0x0f
	MOVWF	PRODH
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	ANDLW	0xf0
	IORWF	PRODH, W
	MOVWF	POSTDEC1
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrput1
	MOVF	r0x07, W
	ADDWF	r0x04, F
	CLRF	WREG
	ADDWFC	r0x05, F
	CLRF	WREG
	ADDWFC	r0x06, F
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, PRODL
	MOVF	r0x06, W
	CALL	__gptrput1
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_serial__fifo_pop	code
_fifo_pop:
;	.line	42; ../src/serial.c	static unsigned char fifo_pop(struct fifo* f)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
;	.line	44; ../src/serial.c	return f->buffer[--f->size];
	MOVF	r0x00, W
	ADDLW	0x01
	MOVWF	r0x03
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x04
	MOVLW	0x00
	ADDWFC	r0x02, W
	MOVWF	r0x05
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	ANDLW	0x0f
	MOVWF	r0x06
	DECF	r0x06, F
	MOVF	r0x06, W
	ANDLW	0x0f
	MOVWF	PRODH
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	ANDLW	0xf0
	IORWF	PRODH, W
	MOVWF	POSTDEC1
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrput1
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	ANDLW	0x0f
	MOVWF	r0x00
	MOVF	r0x00, W
	ADDWF	r0x03, F
	CLRF	WREG
	ADDWFC	r0x04, F
	CLRF	WREG
	ADDWFC	r0x05, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
	MOVWF	r0x03
	MOVF	r0x03, W
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_serial__fifo_init	code
_fifo_init:
;	.line	34; ../src/serial.c	static void fifo_init(struct fifo* f)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
;	.line	36; ../src/serial.c	f->size = 0;
	MOVFF	r0x00, r0x03
	MOVFF	r0x01, r0x04
	MOVFF	r0x02, r0x05
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
	ANDLW	0xf0
	MOVWF	POSTDEC1
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrput1
;	.line	37; ../src/serial.c	f->error = 0;
	MOVFF	r0x00, r0x03
	MOVFF	r0x01, r0x04
	MOVFF	r0x02, r0x05
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
	BCF	WREG, 6
	MOVWF	POSTDEC1
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrput1
;	.line	38; ../src/serial.c	f->overflow = 0;
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	BCF	WREG, 7
	MOVWF	POSTDEC1
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrput1
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	 2204 (0x089c) bytes ( 1.68%)
;           	 1102 (0x044e) words
; udata size:	    9 (0x0009) bytes ( 0.50%)
; access size:	   10 (0x000a) bytes


	end
