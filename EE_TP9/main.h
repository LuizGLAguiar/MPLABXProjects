/* 
 * File:   main.h
 * Author: Luiz Aguiar
 *
 * Created on November 13, 2023, 10:09 AM
 */

#ifndef MAIN_H
#define	MAIN_H

void analyze();
void writeMsg(const char *msg);
void getName(uint8_t);
void erase_list(void);

typedef union
{
    char all[22];
    struct
    {
        char status;
        char name[21];
    };
}data;

__eeprom data client[10];
__eeprom uint8_t clientPtr;

char name_buffer[21];

uint8_t command;

#endif	/* MAIN_H */

