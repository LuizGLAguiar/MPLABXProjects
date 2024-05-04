#include <xc.inc>

global nibbleB
PSECT udata_shr
   nibbleB:
	DS 1
	
global nibbleC
PSECT udata_shr
    nibbleC:
	DS 1

psect resetVec,class=CODE,delta=2   ; Vetor de Reset definido em xc.inc para os PIC10/12/16
resetVec:
    PAGESEL start		    ; Seleciona p�gina de c�digo de programa onde est� start
    goto start 

psect code,class=CODE,delta=2	    ; Define uma sec��o o de c�digo de programa     
start:
    BANKSEL PORTA                   ; Sele��o do banco de mem�ria do registrador PORTA
    clrf    PORTA
    clrf    PORTB
    clrf    PORTC
    BANKSEL ANSEL                  ; Sele��o do banco de mem�ria do registrador ANSEL
    clrf    ANSEL
    clrf    ANSELH
    BANKSEL TRISA
    movlw   00100000B               ; Coloca constante em W para configurar PORTA atrav�s de TRISA
    movwf   TRISA
    movlw   0x0F
    movwf   TRISB
    movwf   TRISC
    BANKSEL WPUB
    movwf WPUB
    BANKSEL PORTA
    
loop:
    clrwdt                          ; Funcionalidade para "resetar" o Watchdog;
    movlw   0x0F		    ; Os 4 bits mais � direita representados pelo maior valor, o n� 15 e adiconei um breakpoint
    andwf   PORTB,W		    ; Estou selecionando os 4 bits mais � direita do PORTB
    movwf   nibbleB		    ; Guarda o valor mascarado de PORTB em nibbleB
    
    MOVLW   0x0F
    ANDWF   PORTC,W		    ; Estou selecionando os 4 bits mais � direita do PORTC
    MOVWF   nibbleC
    
    BTFSS   PORTA, 5        ; Check a bit condition
    GOTO    subt 
	
soma:
    MOVF nibbleC,W
    ADDWF nibbleB,W
    MOVWF PORTA
    GOTO loop

subt:
    MOVF nibbleC,W
    SUBWF nibbleB,W
    MOVWF PORTA
    GOTO  loop
	
;fim:
;    goto loop			    ; Pula para loop (fica aqui ate o desligamento�ou�reset)x
