#include <xc.inc>
    
CONFIG FOSC = INTRC_NOCLKOUT
    
global	cH
global	cL
global	mult_aux
global	iter
PSECT	udata_shr
cH:
    DS	1
cL:
    DS	1
mult_aux:
    DS	2
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
    CLRF    PORTE
    
    BANKSEL TRISA
    CLRF    TRISA
    CLRF    TRISC
    BCF	    OPTION_REG,7
    MOVLW   0xFF
    MOVWF   TRISB
    MOVWF   TRISD
    MOVLW   0x01
    MOVWF   TRISE
    
    BANKSEL ANSEL
    CLRF    ANSEL
    CLRF    ANSELH
    BANKSEL PORTA
    
    MOVLW   0x20
    MOVWF   FSR
    
pre_mult:
    CLRWDT			    ;testagem de valor zero nos operandos
    CLRF    cL
    CLRF    cH
    CLRF    mult_aux
    CLRF    mult_aux+1
    MOVF    PORTB,W
    BTFSC   STATUS,2
    GOTO    result
    MOVF    PORTD,W
    BTFSC   STATUS,2
    GOTO    result
				    ;subtração dos operando para determinar menor número e realizar menos iterações
    SUBWF   PORTB,W
    BTFSC   STATUS,0
    GOTO    $+6
    
    MOVF    PORTD,W
    MOVWF   mult_aux
    MOVF    PORTB,W
    MOVWF   iter
    GOTO    mult_select
    
    MOVF    PORTD,W
    MOVWF   iter
    MOVF    PORTB,W
    MOVWF   mult_aux
    
mult_select:
    BTFSC   PORTE,0
    GOTO    mult2
    
mult1:				    ;faz somas sucessivas do mult_auxiplicandor por iter vezes
    MOVF    mult_aux,W		    
    ADDWF   cL,F
    BTFSC   STATUS,0
    INCF    cH,F
    DECFSZ  iter
    GOTO    mult1
    GOTO    result
    
mult2:
    BTFSS   iter,0		    ;testagem do bit 0 do mult_auxiplicador para operação equivalente ao AND 
    GOTO    $+7
    
    MOVF    mult_aux,W		    ;acumulação dos valores deslocados do mult_auxiplicando
    ADDWF   cL,F
    BTFSC   STATUS,0
    INCF    cH,F
    MOVF    mult_aux+1,W
    ADDWF   cH,F
    
    BCF	    STATUS,0		    ;deslocamento do mult_auxiplicando
    RLF	    mult_aux
    RLF	    mult_aux+1
    
    BCF	    STATUS,0		    ;subtração da iteração (i--) e checagem de zero
    RRF	    iter
    MOVF    iter,F
    BTFSC   STATUS,2
    GOTO    result
    GOTO    mult2
    
result:				    ;escrita do valores em suas respctivas portas
    MOVF    cL,W
    MOVWF   PORTA	    
    MOVF    cH,W
    MOVWF   PORTC
    CALL    reg_ans
    GOTO    pre_mult
    
reg_ans:
    BCF	    FSR,7		    ;seleciona o banco 00 e move o operando PORTB para o endereço de FSR
    BCF	    STATUS,7
    MOVF    PORTB,W
    MOVWF   INDF
		    
    BSF	    FSR,7		    ;seleciona o banco 01 e move o operando PORTD para o endereço de FSR
    MOVF    PORTD,W
    MOVWF   INDF
				    ;seleciona o banco 11 e move o resultado cL para o endereço de FSR
    BSF	    STATUS,7
    MOVF    cL,W
    MOVWF   INDF
				    ;seleciona o banco 10 e move o resultado cH para o endereço de FSR
    BCF	    FSR,7
    MOVF    cH,W
    MOVWF   INDF
				    ;retorna a seleção para o banco 00
    BCF	    FSR,7
				    
    INCF    FSR,F		    ;incrementa o endereço apontado por FSR em 1 e compara com o número 0x6F
    MOVLW   0x6F
    XORWF   FSR,W  
    
    BTFSS   STATUS,2		    ;se FSR == 0x6F, FSR <= 0x20, o código encerra a função caso contrário
    RETURN
    MOVLW   0x20
    MOVWF   FSR
    
    RETURN