/* 
 * File:   main.h
 * Author: Luiz Aguiar
 *
 * Created on November 28, 2023, 10:03 PM
 */

#ifndef MAIN_H
#define	MAIN_H

uint8_t T, incX;
float a;

union
{
    uint8_t yx;
    struct
    {
        uint8_t y : 4;
        uint8_t x : 4;
    };
}coordinates;

void restart(void);
void renderMatrix(void);
void getParameters(void);

#endif	/* MAIN_H */

