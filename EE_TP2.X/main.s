#include <xc.inc>
    
CONFIG FOSC = INTRC_NOCLKOUT
    
global	cH
global	cL
global	mult_aux
global	iter
PSECT udata_shr
cH:
    DS	1
cL:
    DS	1
mult_aux:
    DS	2
iter:
    DS	1
    
psect resetVec,class=CODE,delta=2   
resetVec:
    PAGESEL start		   
    goto start 

psect code,class=CODE,delta=2	   
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
    
    MOVLW   0x20
    MOVWF   FSR
    
    BANKSEL ANSEL
    CLRF    ANSEL
    CLRF    ANSELH
    BANKSEL PORTA
    
loop:
    CLRWDT			    
    CLRF    cL
    CLRF    cH
    CLRF    mult_aux
    CLRF    mult_aux+1
    ;testa possível valor zero nos operandos
    MOVF    PORTB,W
    BTFSC   STATUS,2
    GOTO    result
    MOVF    PORTD,W
    BTFSC   STATUS,2
    GOTO    result 
    ;aplica otimização e chama a devida função
    CALL    otimiza_operandos
    BTFSC   PORTE,0
    CALL    mult2
    BTFSS   PORTE,0
    CALL    mult1
    NOP
    
result:				    
    MOVF    cL,W
    MOVWF   PORTA	    
    MOVF    cH,W
    MOVWF   PORTC
    ;chamada de função para armazenamento dos parâmetros
    CALL    reg_ans
    GOTO    loop
    
    
otimiza_operandos:
    SUBWF   PORTB,W
    BTFSC   STATUS,0
    GOTO    $+6
    ;PORTB < PORTD 
    MOVF    PORTD,W
    MOVWF   mult_aux
    MOVF    PORTB,W
    MOVWF   iter
    RETURN
    ;PORTB >= PORTD
    MOVF    PORTD,W
    MOVWF   iter
    MOVF    PORTB,W
    MOVWF   mult_aux
    RETURN
    
mult1:
    ;multiplicação por iter somas de mult_aux
    MOVF    mult_aux,W		    
    ADDWF   cL,F
    BTFSC   STATUS,0
    INCF    cH,F
    DECFSZ  iter
    GOTO    mult1
    RETURN
    
mult2:
    ;faz operação de soma somente quando iter(0) = '1'
    BTFSS   iter,0	
    GOTO    $+7
    ;soma com carry para acumulação em 2 bytes (16 bits)
    MOVF    mult_aux,W		    
    ADDWF   cL,F
    BTFSC   STATUS,0
    INCF    cH,F
    MOVF    mult_aux+1,W
    ADDWF   cH,F
    ;faz deslocamento no operando da multiplicação
    BCF	    STATUS,0		    
    RLF	    mult_aux
    RLF	    mult_aux+1
    ;faz deslocamento em iter para avaliar prox ciclo. Retorna em caso de valor zero
    BCF	    STATUS,0		    
    RRF	    iter
    MOVF    iter,F
    BTFSS   STATUS,2
    GOTO    mult2
    RETURN
    
reg_ans:
    ;seleciona banco 0 e salva PORTB no endereço apontado por FSR
    BCF	    FSR,7		    
    BCF	    STATUS,7
    MOVF    PORTB,W
    MOVWF   INDF
    ;seleciona banco 1 e salva PORTD no endereço apontado por FSR	    
    BSF	    FSR,7		    
    MOVF    PORTD,W
    MOVWF   INDF
    ;seleciona banco 3 e salva cL no endereço apontado por FSR
    BSF	    STATUS,7
    MOVF    cL,W
    MOVWF   INDF
    ;seleciona banco 2 e salva cH no endereço apontado por FSR			    
    BCF	    FSR,7
    MOVF    cH,W
    MOVWF   INDF				    
    BCF	    FSR,7
    ;incrementa FSR até que seja igual a 0x6F			    
    INCF    FSR,F		    
    MOVLW   0x6F
    XORWF   FSR,W  
    BTFSS   STATUS,2		    
    RETURN
    MOVLW   0x20
    MOVWF   FSR
    
    RETURN