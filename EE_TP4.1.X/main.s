;Luiz Guilherme Leão Aguiar - 190016990
;Eletrônica Embarcada
    
; PIC16F886 Configuration Bit Settings

; Assembly source line config statements

; CONFIG1
  CONFIG  FOSC = INTRC_NOCLKOUT ; Oscillator Selection bits (INTOSCIO oscillator: I/O function on RA6/OSC2/CLKOUT pin, I/O function on RA7/OSC1/CLKIN)
  CONFIG  WDTE = ON             ; Watchdog Timer Enable bit (WDT enabled)
  CONFIG  PWRTE = OFF           ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  MCLRE = ON            ; RE3/MCLR pin function select bit (RE3/MCLR pin function is MCLR)
  CONFIG  CP = OFF              ; Code Protection bit (Program memory code protection is disabled)
  CONFIG  CPD = OFF             ; Data Code Protection bit (Data memory code protection is disabled)
  CONFIG  BOREN = OFF           ; Brown Out Reset Selection bits (BOR disabled)
  CONFIG  IESO = OFF            ; Internal External Switchover bit (Internal/External Switchover mode is disabled)
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor Enabled bit (Fail-Safe Clock Monitor is disabled)
  CONFIG  LVP = OFF             ; Low Voltage Programming Enable bit (RB3 pin has digital I/O, HV on MCLR must be used for programming)

; CONFIG2
  CONFIG  BOR4V = BOR40V        ; Brown-out Reset Selection bit (Brown-out Reset set to 4.0V)
  CONFIG  WRT = OFF             ; Flash Program Memory Self Write Enable bits (Write protection off)
    
#include <xc.inc>
    
#define LedR PORTA,0
#define LedG PORTA,1

PSECT resetVec,class=CODE,delta=2   ; Vetor de Reset definido em xc.inc para os PIC10/12/16
resetVec:
    PAGESEL start		    
    goto start 

PSECT code,class=CODE,abs,delta=2   

ORG 0x100
start:
    MOVLW   0xFF
    MOVWF   PORTA		    ; PORTA inicializada com 11111111B
    BANKSEL TRISA	    
    CLRF    TRISA
    MOVLW   00110001B
    MOVWF   OSCCON		    ; Fosc = 500MHz
    CLRF    TRISA
    MOVLW   10000111B
    MOVWF   OPTION_REG		    ; Escala de 1:256 no prescaler de TIMER0 (Fosc/4)
    BANKSEL WDTCON
    MOVLW   00010101B
    MOVWF   WDTCON		    ; Escala de 1:32768 no prescaler do WDT
    BANKSEL ANSEL
    CLRF    ANSEL
    CLRF    STATUS		    ; Volta ao banco 0
    
loop:
    MOVLW   0x0A
    MOVWF   TMR0
    BCF	    LedR
    BTFSS   INTCON,2
    GOTO    $-1
    BSF	    LedR
    BCF	    INTCON,2
    SLEEP
    MOVLW   0x0A
    MOVWF   TMR0
    BCF	    LedG
    BTFSS   INTCON,2
    GOTO    $-1
    BSF	    LedG
    BCF	    INTCON,2
    SLEEP
    GOTO    loop
    
    END
