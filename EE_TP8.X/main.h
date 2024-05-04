/* 
 * File:   main.h
 * Author: Luiz Guilherme Leão Aguiar
 *
 * Created on November 9, 2023, 11:37 PM
 */

#ifndef MAIN_H
#define	MAIN_H

#include <xc.h>

#define lum_const 0.9765625    // 100/1024 * 10
#define temp_const 2.0        // 150C/1500 * 10

void analyzeRx();
void transmitTx();

typedef union
{
    uint8_t fullReg;
    struct
    {
        uint8_t b0 : 1;
        uint8_t b1 : 1;
        uint8_t b2 : 1;
        uint8_t b3 : 1;
        uint8_t b4 : 1;
        uint8_t b5 : 1;
        uint8_t b6 : 1;
        uint8_t b7 : 1;
    };
    
}reg8Bits;

typedef union
{ 
    uint16_t fullReg;
    struct
    {
        reg8Bits valueL;
        reg8Bits valueH;
    };
}reg16Bits;

struct
{
    reg16Bits temp;
    reg16Bits lum;
    reg8Bits command;
}tx;

struct
{
    reg16Bits dataRx;
    reg8Bits command;
}rx;

bool measure;

float temp_gain, lum_gain;

uint8_t count;

#endif	/* MAIN_H */

