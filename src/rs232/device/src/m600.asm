;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.8.5 #5516 (Sep 20 2009) (UNIX)
; This file was generated Sat Nov 21 16:29:05 2009
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f4550

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _m600_setup
	global _m600_start_request
	global _m600_schedule

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern __gptrput2
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
	extern _serial_write
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
WREG	equ	0xfe8
FSR0L	equ	0xfe9
FSR0H	equ	0xfea
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
INDF0	equ	0xfef
POSTINC0	equ	0xfee
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3
PRODH	equ	0xff4


	idata
_m600_request	db	0xff


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1
r0x05	res	1
r0x06	res	1

udata_m600_0	udata
_m600_reply	res	162

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_m600__m600_schedule	code
_m600_schedule:
;	.line	197; ../src/m600.c	void m600_schedule(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	BANKSEL	_m600_request
;	.line	201; ../src/m600.c	switch (m600_request)
	MOVF	_m600_request, W, B
	BZ	_00173_DS_
_00197_DS_:
	BANKSEL	_m600_request
	MOVF	_m600_request, W, B
	XORLW	0x01
	BZ	_00174_DS_
_00199_DS_:
	BANKSEL	_m600_request
	MOVF	_m600_request, W, B
	XORLW	0x02
	BZ	_00193_DS_
_00201_DS_:
	BANKSEL	_m600_request
	MOVF	_m600_request, W, B
	XORLW	0x03
	BNZ	_00203_DS_
	BRA	_00176_DS_
_00203_DS_:
	BRA	_00178_DS_
_00173_DS_:
;	.line	205; ../src/m600.c	m600_reply.alarms = m600_read_card(m600_reply.card_data);
	MOVLW	HIGH(_m600_reply + 2)
	MOVWF	r0x01
	MOVLW	LOW(_m600_reply + 2)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_m600_read_card
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x03
	ADDWF	FSR1L, F
	MOVF	r0x00, W
	BANKSEL	_m600_reply
	MOVWF	_m600_reply, B
	MOVF	r0x01, W
	BANKSEL	(_m600_reply + 1)
	MOVWF	(_m600_reply + 1), B
;	.line	207; ../src/m600.c	do_reply = 1;
	MOVLW	0x01
	MOVWF	r0x00
;	.line	209; ../src/m600.c	break;
	BRA	_00179_DS_
_00174_DS_:
;	.line	214; ../src/m600.c	m600_reply.alarms = m600_read_alarms();
	CALL	_m600_read_alarms
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	r0x01, W
	BANKSEL	_m600_reply
	MOVWF	_m600_reply, B
	MOVF	r0x02, W
	BANKSEL	(_m600_reply + 1)
	MOVWF	(_m600_reply + 1), B
;	.line	216; ../src/m600.c	do_reply = 1;
	MOVLW	0x01
	MOVWF	r0x00
;	.line	218; ../src/m600.c	break;
	BRA	_00179_DS_
_00193_DS_:
;	.line	225; ../src/m600.c	for (i = 0; i < M600_COLUMN_COUNT; ++i)
	CLRF	r0x01
	CLRF	r0x02
	CLRF	r0x03
	CLRF	r0x04
_00182_DS_:
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00204_DS_
	MOVLW	0x50
	SUBWF	r0x01, W
_00204_DS_:
	BC	_00185_DS_
;	.line	226; ../src/m600.c	m600_reply.card_data[i] = i;
	MOVLW	LOW(_m600_reply + 2)
	ADDWF	r0x03, W
	MOVWF	r0x05
	MOVLW	HIGH(_m600_reply + 2)
	ADDWFC	r0x04, W
	MOVWF	r0x06
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	r0x01, POSTINC0
	MOVFF	r0x02, INDF0
;	.line	225; ../src/m600.c	for (i = 0; i < M600_COLUMN_COUNT; ++i)
	MOVLW	0x02
	ADDWF	r0x03, F
	BTFSC	STATUS, 0
	INCF	r0x04, F
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	BRA	_00182_DS_
_00185_DS_:
;	.line	228; ../src/m600.c	do_reply = 1;
	MOVLW	0x01
	MOVWF	r0x00
;	.line	230; ../src/m600.c	break;
	BRA	_00179_DS_
_00176_DS_:
;	.line	235; ../src/m600.c	uint8_t* const p = (uint8_t*)m600_reply.card_data;
	MOVLW	HIGH(_m600_reply + 2)
	MOVWF	r0x02
	MOVLW	LOW(_m600_reply + 2)
	MOVWF	r0x01
	MOVLW	0x80
	MOVWF	r0x03
;	.line	237; ../src/m600.c	p[0] = PORTA;
	MOVFF	_PORTA, POSTDEC1
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, PRODL
	MOVF	r0x03, W
	CALL	__gptrput1
;	.line	238; ../src/m600.c	p[1] = PORTB;
	MOVF	r0x01, W
	ADDLW	0x01
	MOVWF	r0x04
	MOVLW	0x00
	ADDWFC	r0x02, W
	MOVWF	r0x05
	MOVLW	0x00
	ADDWFC	r0x03, W
	MOVWF	r0x06
	MOVFF	_PORTB, POSTDEC1
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, PRODL
	MOVF	r0x06, W
	CALL	__gptrput1
;	.line	239; ../src/m600.c	p[2] = PORTC;
	MOVF	r0x01, W
	ADDLW	0x02
	MOVWF	r0x04
	MOVLW	0x00
	ADDWFC	r0x02, W
	MOVWF	r0x05
	MOVLW	0x00
	ADDWFC	r0x03, W
	MOVWF	r0x06
	MOVFF	_PORTC, POSTDEC1
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, PRODL
	MOVF	r0x06, W
	CALL	__gptrput1
;	.line	240; ../src/m600.c	p[3] = PORTD;
	MOVLW	0x03
	ADDWF	r0x01, F
	MOVLW	0x00
	ADDWFC	r0x02, F
	MOVLW	0x00
	ADDWFC	r0x03, F
	MOVFF	_PORTD, POSTDEC1
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, PRODL
	MOVF	r0x03, W
	CALL	__gptrput1
;	.line	242; ../src/m600.c	do_reply = 1;
	MOVLW	0x01
	MOVWF	r0x00
;	.line	244; ../src/m600.c	break;
	BRA	_00179_DS_
_00178_DS_:
;	.line	250; ../src/m600.c	do_reply = 0;
	CLRF	r0x00
_00179_DS_:
;	.line	257; ../src/m600.c	m600_request = M600_REQ_INVALID;
	MOVLW	0xff
	BANKSEL	_m600_request
	MOVWF	_m600_request, B
;	.line	259; ../src/m600.c	if (!do_reply)
	MOVF	r0x00, W
;	.line	260; ../src/m600.c	return ;
	BZ	_00186_DS_
;	.line	264; ../src/m600.c	serial_write((unsigned char*)&m600_reply, sizeof(m600_reply_t));
	MOVLW	HIGH(_m600_reply)
	MOVWF	r0x01
	MOVLW	LOW(_m600_reply)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0xa2
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serial_write
	MOVLW	0x05
	ADDWF	FSR1L, F
_00186_DS_:
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
S_m600__m600_start_request	code
_m600_start_request:
;	.line	191; ../src/m600.c	void m600_start_request(m600_request_t req)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVLW	0x02
	MOVFF	PLUSW2, _m600_request
;	.line	193; ../src/m600.c	m600_request = req;
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_m600__m600_setup	code
_m600_setup:
;	.line	156; ../src/m600.c	void m600_setup(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	163; ../src/m600.c	ADCON0 = 0;
	CLRF	_ADCON0
;	.line	164; ../src/m600.c	ADCON1 = 0xf;
	MOVLW	0x0f
	MOVWF	_ADCON1
;	.line	165; ../src/m600.c	ADCON2 = 0;
	CLRF	_ADCON2
;	.line	167; ../src/m600.c	SPPCON = 0;
	CLRF	_SPPCON
;	.line	170; ../src/m600.c	M600_TRIS_DATA_LOW = 1;
	MOVLW	0x01
	MOVWF	_TRISB
;	.line	171; ../src/m600.c	M600_TRIS_DATA_HIGH = 1;
	MOVLW	0x01
	MOVWF	_TRISA
;	.line	172; ../src/m600.c	M600_TRIS_ALARMS = 1;
	MOVLW	0x01
	MOVWF	_TRISD
;	.line	173; ../src/m600.c	M600_TRIS_INDEX_MARK = 1;
	BSF	_TRISCbits, 0
;	.line	174; ../src/m600.c	M600_TRIS_READY = 1;
	BSF	_TRISCbits, 1
;	.line	175; ../src/m600.c	M600_TRIS_BUSY = 1;
	BSF	_TRISCbits, 2
;	.line	183; ../src/m600.c	M600_TRIS_PICK_CMD = 0;
	BCF	_TRISDbits, 3
;	.line	187; ../src/m600.c	m600_request = M600_REQ_INVALID;
	MOVLW	0xff
	BANKSEL	_m600_request
	MOVWF	_m600_request, B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_m600__m600_read_card	code
_m600_read_card:
;	.line	90; ../src/m600.c	static m600_alarms_t m600_read_card(uint16_t* col_data)
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
_00139_DS_:
;	.line	95; ../src/m600.c	while (!M600_PIN_READY)
	BTFSS	_PORTCbits, 1
	BRA	_00139_DS_
_00142_DS_:
;	.line	99; ../src/m600.c	while (M600_PIN_BUSY)
	BTFSC	_PORTCbits, 2
	BRA	_00142_DS_
;	.line	107; ../src/m600.c	M600_PIN_PICK_CMD = 1;
	BSF	_LATDbits, 3
_00147_DS_:
;	.line	110; ../src/m600.c	while (M600_PIN_BUSY)
	BTFSS	_PORTCbits, 2
	BRA	_00149_DS_
;	.line	116; ../src/m600.c	if (M600_PIN_ERROR)
	BTFSS	_PORTDbits, 0
	BRA	_00147_DS_
;	.line	118; ../src/m600.c	M600_PIN_PICK_CMD = 0;
	BCF	_LATDbits, 3
;	.line	119; ../src/m600.c	return m600_read_alarms();
	CALL	_m600_read_alarms
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVFF	r0x04, PRODL
	MOVF	r0x03, W
	BRA	_00158_DS_
_00149_DS_:
;	.line	123; ../src/m600.c	M600_PIN_PICK_CMD = 0;
	BCF	_LATDbits, 3
;	.line	126; ../src/m600.c	while (col_count)
	MOVLW	0x50
	MOVWF	r0x03
	CLRF	r0x04
_00155_DS_:
	MOVF	r0x03, W
	IORWF	r0x04, W
	BZ	_00157_DS_
;	.line	135; ../src/m600.c	if (M600_PIN_INDEX_MARK)
	BTFSS	_PORTCbits, 0
	BRA	_00155_DS_
_00150_DS_:
;	.line	140; ../src/m600.c	while (M600_PIN_INDEX_MARK)
	BTFSC	_PORTCbits, 0
	BRA	_00150_DS_
;	.line	143; ../src/m600.c	*col_data = read_data_reg();
	CALL	_read_data_reg
	MOVWF	r0x05
	MOVFF	PRODL, r0x06
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, PRODH
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrput2
;	.line	145; ../src/m600.c	++col_data;
	MOVLW	0x02
	ADDWF	r0x00, F
	MOVLW	0x00
	ADDWFC	r0x01, F
	MOVLW	0x00
	ADDWFC	r0x02, F
;	.line	146; ../src/m600.c	--col_count;
	MOVLW	0xff
	ADDWF	r0x03, F
	BTFSS	STATUS, 0
	DECF	r0x04, F
	BRA	_00155_DS_
_00157_DS_:
;	.line	150; ../src/m600.c	return M600_ALARM_NONE;
	CLRF	PRODL
	CLRF	WREG
_00158_DS_:
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
S_m600__read_data_reg	code
_read_data_reg:
;	.line	80; ../src/m600.c	static uint16_t read_data_reg(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
;	.line	83; ../src/m600.c	(((unsigned int)M600_PORT_DATA_HIGH << 8) |
	MOVFF	_PORTA, r0x00
	CLRF	r0x01
	MOVF	r0x00, W
	MOVWF	r0x03
	CLRF	r0x02
	MOVFF	_PORTB, r0x00
	CLRF	r0x01
	MOVF	r0x00, W
	IORWF	r0x02, F
	MOVF	r0x01, W
	IORWF	r0x03, F
	MOVLW	0x0f
	ANDWF	r0x03, F
	MOVFF	r0x03, PRODL
	MOVF	r0x02, W
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_m600__m600_read_alarms	code
_m600_read_alarms:
;	.line	60; ../src/m600.c	static m600_alarms_t m600_read_alarms(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	62; ../src/m600.c	m600_alarms_t alarms = M600_ALARM_NONE;
	CLRF	r0x00
	CLRF	r0x01
;	.line	70; ../src/m600.c	SET_ALARM_IF_ASSERTED(alarms, ERROR);
	BTFSS	_PORTDbits, 0
	BRA	_00111_DS_
	MOVLW	0x01
	MOVWF	r0x00
	CLRF	r0x01
_00111_DS_:
;	.line	71; ../src/m600.c	SET_ALARM_IF_ASSERTED(alarms, HOPPER_CHECK);
	BTFSS	_PORTDbits, 1
	BRA	_00119_DS_
	BSF	r0x00, 1
_00119_DS_:
;	.line	72; ../src/m600.c	SET_ALARM_IF_ASSERTED(alarms, MOTION_CHECK);
	BTFSS	_PORTDbits, 2
	BRA	_00127_DS_
	BSF	r0x00, 2
_00127_DS_:
;	.line	74; ../src/m600.c	return alarms;
	MOVFF	r0x01, PRODL
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	  868 (0x0364) bytes ( 0.66%)
;           	  434 (0x01b2) words
; udata size:	  162 (0x00a2) bytes ( 9.04%)
; access size:	    7 (0x0007) bytes


	end
