/* 
 * File:   functions.h
 * Author: luizl
 *
 * Created on 18 de Novembro de 2023, 22:22
 */

#ifndef FUNCTIONS_H
#define	FUNCTIONS_H

#include <xc.h>

void analyze(void);
void writeList(void);
void erase_list(void);
void writeMsg(const char *msg);
void writeMsg2(char *msg);
void getName(uint8_t i);
void bufferToEEPROM (uint8_t i);
void EEPROMTobuffer (uint8_t i);
uint8_t validName(char *msg);
uint8_t listAvailability(void);
uint8_t listBooked(void);

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

data client_buffer;

uint8_t command;
uint8_t temp;

const char msg0[] = "L-Exibe lista, A-Agenda, P-Proximo, R-Apaga lista";
const char msg1[] = "Lista de agendamentos";
const char msg2[] = "Lista de agendamentos vazia";
const char msg3[] = "Proximo:";
const char msg4[] = "Digite o nome:";
const char msg5[] = "Nao foi possivel agendar (nome vazio)";
const char msg6[] = "Todos os agendamentos foram atendidos";
const char msg7[] = "Nao dispomos de mais agendamentos";
const char msg8[] = "O agendamento foi realizado";

#endif	/* FUNCTIONS_H */

