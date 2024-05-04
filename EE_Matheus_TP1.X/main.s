#include <xc.inc>

global cntB
PSECT udata_shr
   cntB:
    DS 1

global cntC
PSECT udata_shr
    cntC:
    DS 1

psect resetVec,class=CODE,delta=2   ; Vetor de Reset definido em xc.inc para os PIC10/12/16
resetVec:
    PAGESEL start            ; Seleciona página de código de programa onde está start
    goto start 

psect code,class=CODE,delta=2        ; Define uma secção o de código de programa
start:

    BANKSEL ANSELH                  ; Seleção do banco de memória do registrador ANSELH (porta B)
    clrf    ANSELH            ; Zera ANSELH, para usar todas as portas como digitais
    clrf    ANSEL            ; Zera ANSEL, para usar todas as portas como digitais

    BANKSEL PORTB            ; Seleção do banco de memória do registrador PORTB
    clrf PORTA                ; zera PORTA
    clrf PORTB                ; zera PORTB
    clrf PORTC                ; zera PORTA

    BANKSEL TRISB             ;Seleção do banco de memória do registrador PORTB

    movlw 0x0f                 ;carrega a constante 00001111B em W para configurar TRISB atraves de TRISB
    movwf TRISB                 ; habilita RA0 até R3 como entradas
    movwf TRISC                 ; habilita RA0 até R3 como entradas
    movlw 0x00                 ; dar um clear em W 
    movlw 0xE0                 ; carrega 11100000 para W
    movwf TRISA                 ;carrega W em TRISA configurar as saidas  RA0 até  como RA4 como saidas e o resto como entradas

    BANKSEL PORTB

    loop:
    movlw 0x0f
    ANDWF PORTC,w
    movwf cntC
    movlw 0x0f
    ANDWF PORTB,W
    MOVWF cntB
    Clrf PORTA
    BTFSC PORTA,5
    goto SOMA
    goto SUB


    SOMA:
    MOVF cntC,w
    ADDWF cntB,w
    movwf PORTA
    goto loop

    SUB:
    MOVF cntB,w
    SUBWF cntC,w
    movwf PORTA
    goto loop