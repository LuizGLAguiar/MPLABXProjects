/* 
 * File:   main.h
 * Author: luizl
 *
 * Created on December 4, 2023, 5:29 PM
 */

#ifndef MAIN_H
#define	MAIN_H

uint16_t lum = 0; 
uint16_t bright = 0; 
uint16_t park_uint = 999;
uint8_t cat = 0b10000000;

const uint8_t segVal[10] = {0b11011110,
                            0b00000110,
                            0b10011011,
                            0b10001111,
                            0b11000110,
                            0b11001101,
                            0b11011101,
                            0b10000111,
                            0b11011111,
                            0b11001111,
};   

union
{
    uint16_t all;
    struct
    {
        uint8_t dig1 : 4;
        uint8_t dig2 : 4;
        uint8_t dig3 : 4;
        uint8_t dig4 : 4;
    };
}park_bcd;

void displayMux(void);
void dattaOut(void);
void carIn(void);
void carOut(void);
uint8_t uint2ASCII(uint8_t num);

#endif	/* MAIN_H */

