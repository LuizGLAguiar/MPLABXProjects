#include <xc.inc>
    
CONFIG FOSC = INTRC_NOCLKOUT ;
    
global acc
global cnt
global var_B
global var_D
PSECT udata_shr
acc:
    DS 2
var_B:
    DS 1
var_D:
    DS 2
cnt:
    DS 1

psect resetVec,class=CODE,delta=2   ; Vetor de Reset definido em xc.inc para os PIC10/12/16
resetVec:
    PAGESEL start		    ; Seleciona p�gina de c�digo de programa onde est� start
    goto start
psect code,class=CODE,delta=2	    ; Define uma sec��o o de c�digo de programa     

start:
;Configurando o Input do C�digo
;Definindo se a entrada � anal�gica ou digital com o ANSEL:
    BANKSEL ANSEL
    clrf    ANSEL
    clrf    ANSELH
; Configurando as portas relacionadas as vari�veis "a" e "b":
    BANKSEL PORTB
    clrf    PORTB
    clrf    PORTD
    clrf    PORTE
; N�o precisei selecionar o PORTD, pois o PORTB j� foi selecionado e pertence ao mesmo banco  
    BANKSEL TRISB
    MOVLW   11111111B 
    MOVWF   TRISB
    CLRF    TRISA
    CLRF    TRISC
; N�o precisei selecionar o TRISD, pois o TRISB j� foi selecionado e pertence ao mesmo banco  
    MOVWF   TRISD
    MOVLW   00000001B
    MOVWF   TRISE
    
config_output:
    MOVF    PORTB, W
    MOVWF   var_B
    
    MOVF    PORTD, W
    MOVWF   var_D
    
    MOVLW   0x08			;Estou movendo 08 para o Reg Contador
    MOVWF   cnt
    
    clrf    acc
    clrf    acc+1		;acc+1 � segundo Byte de acc
verifica_LSB_de_VAR_B:
    ;Verifica se o LSB=1, eu pulo
    BTFSS   var_B, 0
    goto    rotine_rotate_right
acumula_add:
    MOVF    var_D, W
    ADDWF   acc, F
    ;Quero visualizar se houve flag carry na opera��o envolvendo os primeiros bytes de acc e var_D
    BTFSC  STATUS, 0
    INCF    var_D + 1, F
    MOVF    var_D + 1, W
    ADDWF   acc, F
    
rotine_rotate_right:
    BCF	STATUS,2
    RLF	var_D
    RRF	var_D+1
    BCF	STATUS,2
    RRF	var_B
decrementa_contador:
    DECF    cnt, F
;Verificando se o cnt � zero:
    MOVF    cnt, F	    ;T� setando a flag
    BTFSS   STATUS, 2
    goto    verifica_LSB_de_VAR_B   ;Se o cnt n�o for igual a zero
    MOVF    acc, W
    MOVWF   PORTA
    GOTO    config_output
