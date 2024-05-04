#include <xc.inc>
    
CONFIG FOSC = INTRC_NOCLKOUT
    
global	cH
global	cL
global	MultMSB
global	MultLSB
global	iter
PSECT	udata_shr
cH:
    DS	1
cL:
    DS	1
MultMSB:
    DS	1
MultLSB:
    DS	1
iter:
    DS	1
    
psect resetVec,class=CODE,delta=2   ; Vetor de Reset definido em xc.inc para os PIC10/12/16
resetVec:
    PAGESEL start		    ; Seleciona página de código de programa onde está start
    goto start 

psect code,class=CODE,delta=2	    ; Define uma secção o de código de programa 
start:
    BANKSEL PORTA
    CLRF    PORTA
    CLRF    PORTB
    CLRF    PORTC
    CLRF    PORTD
    
    BANKSEL TRISA
    CLRF    TRISA
    CLRF    TRISC
    MOVLW   0xFF
    MOVWF   TRISB
    MOVWF   TRISD
    MOVWF   WPUB
    
    BANKSEL ANSEL
    CLRF    ANSEL
    CLRF    ANSELH
    BANKSEL PORTA
    
pre_mult:
    CLRWDT
    MOVF    PORTB,W
    BTFSC   STATUS,2
    GOTO    result
    MOVF    PORTD,W
    BTFSC   STATUS,2
    GOTO    result

    SUBWF   PORTB,W
    BTFSC   STATUS,0
    GOTO    $+6

    MOVF    PORTD,W
    MOVWF   MultLSB
    MOVF    PORTB,W
    MOVWF   iter
    GOTO    mult

    MOVF    PORTD,W
    MOVWF   iter
    MOVF    PORTB,W
    MOVWF   MultLSB
    
mult:
    MOVF    MultLSB,W
    ADDWF   cL,F
    BTFSC   STATUS,0
    INCF    cH,F
    DECFSZ  iter
    GOTO    mult
    
result: 
    MOVF    cL,W
    MOVWF   PORTA
    MOVF    cH,W
    MOVWF   PORTC
    GOTO    pre_mult
    
    
    
    
	
