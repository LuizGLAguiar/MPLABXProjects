#include <xc.inc>
   
global	NUM, DEN, QUOC, REST, aux, cnt
PSECT udata_shr
NUM:
    DS	1
DEN:
    DS	1
QUOC:
    DS	1
REST:
    DS	1
aux:
    DS	2
cnt:
    DS	1
    
RSTVAR	MACRO
    MOVF    PORTB,W
    MOVWF   NUM
    MOVWF   REST
    MOVF    PORTD,W
    MOVWF   DEN
    CLRF    QUOC
    MOVLW   0x04
    MOVWF   cnt
ENDM
    
PREPAUX	MACRO
    MOVLW   0x0F
    MOVWF   aux
    MOVLW   0xF0
    MOVWF   aux+1
ENDM
    
PREPAUX2 MACRO
    MOVLW   0xF8
    MOVWF   aux
    MOVLW   0x07
    MOVWF   aux+1
ENDM
    
psect resetVec,class=CODE,delta=2   
resetVec:
    PAGESEL start		   
    goto start 

PSECT code,class=CODE,abs,delta=2	   
start:
    CLRF    PORTA
    CLRF    PORTC
    
    BANKSEL ANSEL
    CLRF    ANSEL
    CLRF    ANSELH
    
    BANKSEL TRISA
    CLRF    TRISA
    CLRF    TRISC
    BCF	    RE1
    BSF	    RE0
    BCF	    OPTION_REG,7
    
    CLRF    STATUS
    MOVLW   0x20
    MOVWF   FSR
    
    MOVLW   0x04
    MOVWF   cnt
    
loop:
    CLRWDT
										;testagem dos operandos para valores de zero
    RSTVAR
    MOVF    PORTB,W
    BTFSC   STATUS,2
    GOTO    result
    MOVF    PORTD,W
    BTFSC   STATUS,2
    GOTO    result_error 
										;escolha do m�todo de divis�o
    BTFSS   RE0
    CALL    div1
    BTFSC   RE0
    CALL    div2
    
result:
										;escrita nas portas de sa�da, codifica��o e armazenamento dos resultados
    PREPAUX
    MOVF    QUOC,W 
    MOVWF   PORTA
    CALL    reg_ASCII
    PREPAUX
    MOVF    REST,W
    MOVWF   PORTC
    CALL    reg_ASCII
    GOTO    loop
    
result_error:
										;condi��o de divis�o por zero com acionamento do led em RE1
    BSF	    RE1
    GOTO    loop
    
div1:
										;divis�o por multiplas subtra��es
    BCF	    RE1
    MOVF    DEN,W
    SUBWF   REST,W
    BTFSS   STATUS,0
    RETURN
    MOVWF   REST
    INCF    QUOC,F
    GOTO    div1
    RETURN
    
div2:
    BCF	    RE1
    PREPAUX2
										;aplica��o de m�scara para cinco bits mais significativos do dividendo
    MOVF    REST,W
    ANDWF   aux,F
										;aplica��o de m�scara para tr�s bits menos significativos do dividendo
    MOVF    REST,W
    ANDWF   aux+1,F
										;deslocamento para esquerda dos cinco MSBs do dividendo para posterior subtra��o
    BCF	    STATUS,2
    RRF	    aux,F
    RRF	    aux,F
    RRF	    aux,F
										;subtra��o do dividendo pelo divisor (dividendo - divisor)
    MOVF    DEN,W
    SUBWF   aux,F
										;alocamento do bit de resultado no registrador de quociente
    RLF	    QUOC,F
										;registro (ou n�o) do resultado da subtra��o no registrador do dividendo
    BTFSS   QUOC,0
    GOTO    $+8
    BCF	    STATUS,0
    RLF	    aux
    RLF	    aux
    RLF	    aux
    MOVF    aux,W
    IORWF   aux+1,W
    MOVWF   REST
										;deslocamento do dividendo para a esquerda com o bit de resultado como entrada serial 
    BTFSC   QUOC,0
    GOTO    $+4
    BCF	    STATUS,0
    RLF	    REST,F
    GOTO    $+3
    BSF	    STATUS,0
    RLF	    REST,F
										;decremento do contador com testagem de fim de opera��o
    DECFSZ  cnt
    GOTO    div2
										;extra��o do valor de resto
    PREPAUX
    MOVF    aux+1,W
    ANDWF   REST,F
    SWAPF   REST,F 
    
    RETURN
    
reg_ASCII: 
										;extra��o dos nibbles mais e menos significativos
    ANDWF   aux,F
    ANDWF   aux+1,F
    SWAPF   aux+1,F
										;atualiza��o do PCLATCH
    MOVLW   high(table)	 
    MOVWF   PCLATH
										;chamada de tabela de codifica��o para nibble mais significativo e registro no endere�o apontado por FSR
    MOVF    aux+1,W
    CALL    table
    MOVWF   INDF
    INCF    FSR
										;atualiza��o do PCLATCH
    MOVLW   high(table)	 
    MOVWF   PCLATH
										;chamada de tabela de codifica��o para nibbel menos significativo e registro no endere�o apontado por FSR
    MOVF    aux,W
    CALL    table
    MOVWF   INDF
    INCF    FSR
										;testagem de FSR para que n�o ultrapasse o endere�o 0x24
    MOVF    FSR,W
    XORLW   0x24
    BTFSS   STATUS,2
    RETURN
    MOVLW   0x20
    MOVWF   FSR

    RETURN

ORG 0x400    
table:
    ANDLW   0x0F
    ADDWF   PCL,F
    RETLW   0x30  
    RETLW   0x31
    RETLW   0x32
    RETLW   0x33
    RETLW   0x34
    RETLW   0x35
    RETLW   0x36
    RETLW   0x37
    RETLW   0x38
    RETLW   0x39
    RETLW   0x41
    RETLW   0x42
    RETLW   0x43
    RETLW   0x44
    RETLW   0x45
    RETLW   0x46
    
    END resetVec