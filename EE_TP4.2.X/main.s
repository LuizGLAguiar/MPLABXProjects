; PIC16F886 Configuration Bit Settings

; Assembly source line config statements

; CONFIG1
  CONFIG  FOSC = INTRC_NOCLKOUT ; Oscillator Selection bits (INTOSCIO oscillator: I/O function on RA6/OSC2/CLKOUT pin, I/O function on RA7/OSC1/CLKIN)
  CONFIG  WDTE = OFF            ; Watchdog Timer Enable bit (WDT disabled and can be enabled by SWDTEN bit of the WDTCON register)
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
    
#define SD1 PORTB,4
#define	SD2 PORTB,5
#define	MOT PORTB,1
    
global	W_TEMP, STATUS_TEMP, LOOP
PSECT udata_shr
W_TEMP:
    DS	1
STATUS_TEMP:
    DS	1
LOOP:
    DS	1

PSECT code,class=CODE,abs,delta=2   
ORG 0x000    			    
    PAGESEL start		    
    goto start 
 
ORG 0x004
    MOVWF   W_TEMP
    SWAPF   STATUS,W
    MOVWF   STATUS_TEMP
    
    CLRF    STATUS
    BTFSC   T0IF
    GOTO    TMR0_INT
    BTFSC   TMR2IF
    GOTO    TMR2_INT		    
    GOTO    END_ISR  
TMR0_INT:
    BCF	    T0IF
    MOVLW   0x38				; 56D			  
    MOVWF   TMR0
    DECFSZ  LOOP,F
    GOTO    END_ISR
    BCF	    MOT  
    GOTO    END_ISR
TMR2_INT:
    BCF	    TMR2IF
    BTFSC   SD1
    GOTO    $+9
    BCF	    SD2
    MOVLW   high(table)	 
    MOVWF   PCLATH
    SWAPF   LOOP,W
    CALL    table
    MOVWF   PORTC
    BSF	    SD1
    GOTO    END_ISR
    
    BCF	    SD1
    MOVLW   high(table)	 
    MOVWF   PCLATH
    MOVF    LOOP,W
    CALL    table
    MOVWF   PORTC
    BSF	    SD2
END_ISR:
    SWAPF   STATUS_TEMP,W
    MOVWF   STATUS
    SWAPF   W_TEMP,F
    SWAPF   W_TEMP,W
    RETFIE    

ORG 0x100
start:
    CLRF    PORTA
    CLRF    PORTB
    CLRF    PORTC
    MOVLW   0x1F
    MOVWF   T2CON			    ; prescaler de 1:4 e postcscaler de 1:16
    BCF	    TMR2IF
    BCF	    T0IF
    
    BANKSEL TRISA			  
    CLRF    TRISC			    
    CLRF    TRISB
    MOVLW   10101000B
    MOVWF   OPTION_REG			    ; Interrupt on falling edge of INT pin, Transition on T0CKI pin, Increment on low-to-high transition on T0CKI pin, Increment on low-to-high transition on T0CKI pin (1:1)
    BSF	    TMR2IE
    MOVLW   0x9C	    
    MOVLW   PR2				    ; PR2 = 156		    
    
    BANKSEL ANSEL
    CLRF    ANSEL
    CLRF    ANSELH
    MOVLW   11100000B
    MOVWF   INTCON			    ; GIE = 1, PEIE = 1, T0IE = 1
    CLRF    STATUS
    CLRF    LOOP
loop:
    CLRWDT
    MOVF    LOOP,F
    BTFSC   STATUS,2
    GOTO    loop
    MOVLW   0x38			  
    MOVWF   TMR0
    BSF	    MOT   
    
wait_int:
    CLRWDT
    MOVF    LOOP,F
    BTFSC   STATUS,2
    GOTO    loop
    GOTO    wait_int
    
ORG 0x400    
table:
    ANDLW   0x0F
    ADDWF   PCL,F		    
    RETLW   00111111B		    ;0
    RETLW   00110000B		    ;1
    RETLW   01101101B		    ;2
    RETLW   01111001B		    ;3
    RETLW   01110010B		    ;4
    RETLW   01011011B		    ;5
    RETLW   01011111B		    ;6
    RETLW   00110001B		    ;7
    RETLW   01111111B		    ;8
    RETLW   01111011B		    ;9
    RETLW   01110111B		    ;A
    RETLW   01111111B		    ;B
    RETLW   00001111B		    ;C
    RETLW   00111111B		    ;D
    RETLW   01001111B		    ;E
    RETLW   01000111B		    ;F
    
END
    