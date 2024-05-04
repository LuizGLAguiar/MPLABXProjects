#include <xc.inc>

global count	                    ; Vari�vel global count
PSECT udata_shr			    ; localizada na zona espelhada da mem�ria de dados 
count:
    DS 1    
    
global nibbleB	                    ; Vari�vel global nibbleB
PSECT udata_shr			    ; localizada na zona espelhada da mem�ria de dados 
nibbleB:
    DS 1
    
global nibbleC	                    ; Vari�vel global nibbleC
PSECT udata_shr			    ; localizada na zona espelhada da mem�ria de dados 
nibbleC:
    DS 1
    
psect resetVec,class=CODE,delta=2   ; Vetor de Reset definido em xc.inc para os PIC10/12/16
resetVec:
    PAGESEL start		    ; Seleciona p�gina de c�digo de programa onde est� start
    goto start 

psect code,class=CODE,delta=2	    ; Define uma sec��o o de c�digo de programa 
    start:
    BANKSEL PORTA		    ; Sele��o do banco de mem�ria do registrador PORTA
    clrf    PORTA		    ; Zera PORTA, para quando as sa�das sejam configuradas os pinos fiquem em zero
    clrf    PORTB		    ; Zera PORTB, para quando as sa�das sejam configuradas os pinos fiquem em zero
    clrf    PORTC		    ; Zera PORTC, para quando as sa�das sejam configuradas os pinos fiquem em zero
    BANKSEL ANSEL		    ; Sele��o do banco de mem�ria do registrador ANSEL
    clrf    ANSEL		    ; Zera ANSEL, para usar todas as portas como digitais
    clrf    ANSELH		    ; Zera ANSELH, para usar todas as portas como digitais
    BANKSEL TRISA		    ; Sele��o do banco de mem�ria do registrador TRISA
    movlw   0x20		    ; Coloca constante em W para configurar PORTA atrav�s de TRISA
    movwf   TRISA		    ; Escreve em TRISA para configurar RA5 como entrada, o resto como sa�das
    movlw   0x0F		    ; Coloca constante em W para configurar PORTB e PORTC atrav�s de TRISB e TRISC
    movwf   TRISB		    ; Escreve em TRISB para configurar RB<3:0> como entradas, o resto como sa�das
    movwf   TRISC		    ; Escreve em TRISB para configurar RC<3:0> como entradas, o resto como sa�das
    movwf   WPUB		    ; Escreve em WPUB para configurar resistores de pulldown em RB<3:0>
    BANKSEL count		    ; Sele��o do banco de mem�ria do registrador count
    clrf    count		    ; Zera count, para quando as sa�das sejam configuradas os pinos fiquem em zero
    clrf    nibbleB		    ; Zera nibbleB, para quando as sa�das sejam configuradas os pinos fiquem em zero
    clrf    nibbleC		    ; Zera nibbleC, para quando as sa�das sejam configuradas os pinos fiquem em zero
    
    loop:
    clrwdt			    ; Zera Cao de Guarda (Watchdog Timer)
    movlw   0x0F		    ; Coloca constante em W para configurar m�scara de PORTB
    andwf   PORTB,W		    ; Aplica m�scara para quatro d�gitos menos significativos de PORTB e registra em W
    movwf   nibbleB		    ; Escreve m�scara de PORTB em NIBBLEB
    movlw   0x0F		    ; Coloca constante em W para configurar m�scara de PORTC
    andwf   PORTC,W		    ; Aplica m�scara para quatro d�gitos menos significativos de PORTB e registra em W
    movwf   nibbleC		    ; Escreve m�scara de PORTC em NIBBLEC
    
    soma:
    btfss   PORTA,5		    ;
    goto    subtrai		    ;
    movf    nibbleB,W		    ; Escreve nibbleB em W
    addwf   nibbleC,W		    ; Realiza a soma entre W e nibbleC e registra em W
    movwf   count		    ; Escreve em count a soma de 4 bits de nibbleB com nibbleC
    movwf   PORTA		    ; Escreve em PORTA a soma de 4 bits de nibbleB com nibbleC
    goto    loop		    ;
    
    subtrai:
    movf    nibbleC,W		    ; Escreve nibble C em W
    subwf   nibbleB,W		    ; Realiza a subtra��o entre W e nibbleB e registra em W
    movwf   count		    ; Escreve em count a subtra��o de 4 bits de nibbleB com nibbleC
    movwf   PORTA		    ; Escreve em PORTA a subtra��o de 4 bits de nibbleB com nibbleC
    goto    loop		    ;