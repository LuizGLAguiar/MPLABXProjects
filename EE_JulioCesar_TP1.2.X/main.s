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
    PAGESEL start		    ; Seleciona página de código de programa onde está start
    goto start 

psect code,class=CODE,delta=2	    ; Define uma secção o de código de programa     
start:
    BANKSEL PORTA                   ; Seleção do banco de memória do registrador PORTA
    clrf    PORTA                   ; Zera PORTA, para quando as saídas sejam configuradas os pinos fiquem em zero
    BANKSEL ANSEL                  ; Seleção do banco de memória do registrador ANSEL
    clrf    ANSEL                  ; Zera ANSEL, para usar todas as portas como digitais
    BANKSEL TRISA                   ; Seleção do banco de memória do registrador ANSELA
    movlw   00100000B               ; Coloca constante em W para configurar PORTA através de TRISA
    movwf   TRISA                   ; Escreve em TRISA para configurar RA2 e RA0 como saída, o resto como entradas

; O Reg de B tem um registrador a mais, que é o registrador de Pull-Up
config_portB:
 ;Estou Definindo o Pull-Up nas próximas 8 linhas   
    BANKSEL OPTION_REG
    Banksel WPUB
    BSF	WPUB, 0                 ;Ativa Pull-Up no pino RB0  (0)
    BSF	WPUB, 1		    ;Ativa Pull-Up no pino RB0  (1)
    BSF	WPUB, 2		    ;Ativa Pull-Up no pino RB0 	(2)
    BSF	WPUB, 3		    ;Ativa Pull-Up no pino RB0  (3)
    BANKSEL PORTB                   ; Seleção do banco de memória do registrador PORTA
    clrf    PORTB                   ; Zera PORTA, para quando as saídas sejam configuradas os pinos fiquem em zero
    BANKSEL ANSELH                  ; Seleção do banco de memória do registrador ANSELH
    clrf    ANSELH
    clrf    ANSEL
    BANKSEL TRISB                  ; Seleção do banco de memória do registrador ANSELH
    clrf    TRISB		    ; Determinando que os pinos de PORTA vãos er saídas
    movlw   11111111B               ; Coloca constante em W para configurar PORTB através de TRISA
    movwf   TRISB                   ; Escreve em TRISA para configurar RA2 e RA0 como saída, o resto como entradas
   
    
    
config_portC:
    BANKSEL PORTC                   ; Seleção do banco de memória do registrador PORTA
    clrf    PORTC                   ; Zera PORTA, para quando as saídas sejam configuradas os pinos fiquem em zero
    BANKSEL TRISC                   ; Seleção do banco de memória do registrador ANSELA
    MOVLW   11111111B               ; Coloca constante em W para configurar PORTC através de TRISC
    MOVWF   TRISC                   ; Escreve em TRISA para configurar RA2 e RA0 como saída, o resto como entradas
    BANKSEL PORTA   


loop:
    MOVLW   00001111B		    ; Os 4 bits mais à direita representados pelo maior valor, o n° 15 e adiconei um breakpoint
    ANDWF   PORTB,W		    ; Estou selecionando os 4 bits mais à direita do PORTB
    MOVWF   nibbleB		    ; Guarda o valor mascarado de PORTB em nibbleB
    
    MOVLW   00001111B
    ANDWF   PORTC,W		    ; Estou selecionando os 4 bits mais à direita do PORTC
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

