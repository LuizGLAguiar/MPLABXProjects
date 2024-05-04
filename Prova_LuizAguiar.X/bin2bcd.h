/* 
 * File:   bin2bcd.h
 * Author: Guillermo
 *
 * Created on 11 de Outubro de 2021, 23:17
 */

#ifndef BIN2BCD_H
#define	BIN2BCD_H

#include <string.h>
#include <stdint.h>
#include "bin2bcd.h"

 /**
 * Converte un valor Binario de 12 bits para BCD de 16 bits.
 * O valor de entrada deve estar entre 0 e 9999.
 * O valor devolvido estar� em formato BCD, correspondendo 
 * cada nibble com um d�gito em decimal. O nibble menos 
 * significativo corresponde com o d�gito decimal menos
 * significativo. Por exemplo, o valor 0x0123 corresponde
 * com o valor BCD 0x0291.
 * Se recomenda usar uma union para facilitar o manejo
 * dos nibles.
 * @param binVal Valor bin�rio a ser convertido para BCD.
 * @return Valor BCD retornado.
 */
uint16_t bin2bcd(uint16_t binVal);


#endif	/* BIN2BCD_H */

