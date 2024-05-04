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
    clrf    PORTA                   ; Zera PORTA, para quando as sa�das sejam configuradas os pinos fiquem em zero
    BANKSEL ANSEL                  ; Sele��o do banco de mem�ria do registrador ANSEL
    clrf    ANSEL                  ; Zera ANSEL, para usar todas as portas como digitais
    BANKSEL TRISA                   ; Sele��o do banco de mem�ria do registrador ANSELA
    movlw   00100000B               ; Coloca constante em W para configurar PORTA atrav�s de TRISA
    movwf   TRISA                   ; Escreve em TRISA para configurar RA2 e RA0 como sa�da, o resto como entradas

; O Reg de B tem um registrador a mais, que � o registrador de Pull-Up
config_portB:
 ;Estou Definindo o Pull-Up nas pr�ximas 8 linhas   
    BANKSEL OPTION_REG
    Banksel WPUB
    BSF	WPUB, 0                 ;Ativa Pull-Up no pino RB0  (0)
    BSF	WPUB, 1		    ;Ativa Pull-Up no pino RB0  (1)
    BSF	WPUB, 2		    ;Ativa Pull-Up no pino RB0 	(2)
    BSF	WPUB, 3		    ;Ativa Pull-Up no pino RB0  (3)
    BANKSEL PORTB                   ; Sele��o do banco de mem�ria do registrador PORTA
    clrf    PORTB                   ; Zera PORTA, para quando as sa�das sejam configuradas os pinos fiquem em zero
    BANKSEL ANSELH                  ; Sele��o do banco de mem�ria do registrador ANSELH
    clrf    ANSELH
    clrf    ANSEL
    BANKSEL TRISB                  ; Sele��o do banco de mem�ria do registrador ANSELH
    clrf    TRISB		    ; Determinando que os pinos de PORTA v�os er sa�das
    movlw   11111111B               ; Coloca constante em W para configurar PORTB atrav�s de TRISA
    movwf   TRISB                   ; Escreve em TRISA para configurar RA2 e RA0 como sa�da, o resto como entradas
   
    
    
config_portC:
    BANKSEL PORTC                   ; Sele��o do banco de mem�ria do registrador PORTA
    clrf    PORTC                   ; Zera PORTA, para quando as sa�das sejam configuradas os pinos fiquem em zero
    BANKSEL TRISC                   ; Sele��o do banco de mem�ria do registrador ANSELA
    MOVLW   11111111B               ; Coloca constante em W para configurar PORTC atrav�s de TRISC
    MOVWF   TRISC                   ; Escreve em TRISA para configurar RA2 e RA0 como sa�da, o resto como entradas
    BANKSEL PORTA   


loop:
    MOVLW   00001111B		    ; Os 4 bits mais � direita representados pelo maior valor, o n� 15 e adiconei um breakpoint
    ANDWF   PORTB,W		    ; Estou selecionando os 4 bits mais � direita do PORTB
    MOVWF   nibbleB		    ; Guarda o valor mascarado de PORTB em nibbleB
    
    MOVLW   00001111B
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
;    goto loop			    ; Pula para loop (fica aqui ate o desligamento ou reset)x	

