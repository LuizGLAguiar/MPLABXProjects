#include <xc.inc>

global count	                    ; Variável global count
PSECT udata_shr			    ; localizada na zona espelhada da memória de dados 
count:
    DS 1    
    
global nibbleB	                    ; Variável global nibbleB
PSECT udata_shr			    ; localizada na zona espelhada da memória de dados 
nibbleB:
    DS 1
    
global nibbleC	                    ; Variável global nibbleC
PSECT udata_shr			    ; localizada na zona espelhada da memória de dados 
nibbleC:
    DS 1
    
psect resetVec,class=CODE,delta=2   ; Vetor de Reset definido em xc.inc para os PIC10/12/16
resetVec:
    PAGESEL start		    ; Seleciona página de código de programa onde está start
    goto start 

psect code,class=CODE,delta=2	    ; Define uma secção o de código de programa 
    start:
    BANKSEL PORTA		    ; Seleção do banco de memória do registrador PORTA
    clrf    PORTA		    ; Zera PORTA, para quando as saídas sejam configuradas os pinos fiquem em zero
    clrf    PORTB		    ; Zera PORTB, para quando as saídas sejam configuradas os pinos fiquem em zero
    clrf    PORTC		    ; Zera PORTC, para quando as saídas sejam configuradas os pinos fiquem em zero
    BANKSEL ANSEL		    ; Seleção do banco de memória do registrador ANSEL
    clrf    ANSEL		    ; Zera ANSEL, para usar todas as portas como digitais
    clrf    ANSELH		    ; Zera ANSELH, para usar todas as portas como digitais
    BANKSEL TRISA		    ; Seleção do banco de memória do registrador TRISA
    movlw   0x20		    ; Coloca constante em W para configurar PORTA através de TRISA
    movwf   TRISA		    ; Escreve em TRISA para configurar RA5 como entrada, o resto como saídas
    movlw   0x0F		    ; Coloca constante em W para configurar PORTB e PORTC através de TRISB e TRISC
    movwf   TRISB		    ; Escreve em TRISB para configurar RB<3:0> como entradas, o resto como saídas
    movwf   TRISC		    ; Escreve em TRISB para configurar RC<3:0> como entradas, o resto como saídas
    movwf   WPUB		    ; Escreve em WPUB para configurar resistores de pulldown em RB<3:0>
    BANKSEL count		    ; Seleção do banco de memória do registrador count
    clrf    count		    ; Zera count, para quando as saídas sejam configuradas os pinos fiquem em zero
    clrf    nibbleB		    ; Zera nibbleB, para quando as saídas sejam configuradas os pinos fiquem em zero
    clrf    nibbleC		    ; Zera nibbleC, para quando as saídas sejam configuradas os pinos fiquem em zero
    
    loop:
    clrwdt			    ; Zera Cao de Guarda (Watchdog Timer)
    movlw   0x0F		    ; Coloca constante em W para configurar máscara de PORTB
    andwf   PORTB,W		    ; Aplica máscara para quatro dígitos menos significativos de PORTB e registra em W
    movwf   nibbleB		    ; Escreve máscara de PORTB em NIBBLEB
    movlw   0x0F		    ; Coloca constante em W para configurar máscara de PORTC
    andwf   PORTC,W		    ; Aplica máscara para quatro dígitos menos significativos de PORTB e registra em W
    movwf   nibbleC		    ; Escreve máscara de PORTC em NIBBLEC
    
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
    subwf   nibbleB,W		    ; Realiza a subtração entre W e nibbleB e registra em W
    movwf   count		    ; Escreve em count a subtração de 4 bits de nibbleB com nibbleC
    movwf   PORTA		    ; Escreve em PORTA a subtração de 4 bits de nibbleB com nibbleC
    goto    loop		    ;