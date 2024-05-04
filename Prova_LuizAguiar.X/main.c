/**
  Generated Main Source File

  Company:
    Microchip Technology Inc.

  File Name:
    main.c

  Summary:
    This is the main file generated using PIC10 / PIC12 / PIC16 / PIC18 MCUs

  Description:
    This header file provides implementations for driver APIs for all modules selected in the GUI.
    Generation Information :
        Product Revision  :  PIC10 / PIC12 / PIC16 / PIC18 MCUs - 1.81.8
        Device            :  PIC16F1827
        Driver Version    :  2.00
*/

/*
    (c) 2018 Microchip Technology Inc. and its subsidiaries. 
    
    Subject to your compliance with these terms, you may use Microchip software and any 
    derivatives exclusively with Microchip products. It is your responsibility to comply with third party 
    license terms applicable to your use of third party software (including open source software) that 
    may accompany Microchip software.
    
    THIS SOFTWARE IS SUPPLIED BY MICROCHIP "AS IS". NO WARRANTIES, WHETHER 
    EXPRESS, IMPLIED OR STATUTORY, APPLY TO THIS SOFTWARE, INCLUDING ANY 
    IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY, AND FITNESS 
    FOR A PARTICULAR PURPOSE.
    
    IN NO EVENT WILL MICROCHIP BE LIABLE FOR ANY INDIRECT, SPECIAL, PUNITIVE, 
    INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, COST OR EXPENSE OF ANY KIND 
    WHATSOEVER RELATED TO THE SOFTWARE, HOWEVER CAUSED, EVEN IF MICROCHIP 
    HAS BEEN ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE FORESEEABLE. TO 
    THE FULLEST EXTENT ALLOWED BY LAW, MICROCHIP'S TOTAL LIABILITY ON ALL 
    CLAIMS IN ANY WAY RELATED TO THIS SOFTWARE WILL NOT EXCEED THE AMOUNT 
    OF FEES, IF ANY, THAT YOU HAVE PAID DIRECTLY TO MICROCHIP FOR THIS 
    SOFTWARE.
*/

#include "mcc_generated_files/mcc.h"
#include "main.h"
#include "bin2bcd.h"

/*
                         Main application
 */

void main(void)
{
    // initialize the device
    SYSTEM_Initialize();
    TMR1_SetInterruptHandler(displayMux);
    TMR4_SetInterruptHandler(dattaOut);
    IOCBF0_SetInterruptHandler(carIn);
    IOCBF3_SetInterruptHandler(carOut);

    // When using interrupts, you need to set the Global and Peripheral Interrupt Enable bits
    // Use the following macros to:

    // Enable the Global Interrupts
    INTERRUPT_GlobalInterruptEnable();

    // Enable the Peripheral Interrupts
    INTERRUPT_PeripheralInterruptEnable();

    // Disable the Global Interrupts
    //INTERRUPT_GlobalInterruptDisable();

    // Disable the Peripheral Interrupts
    //INTERRUPT_PeripheralInterruptDisable();

    while (1)
    {
        lum = ADC_GetConversion(SENS_LUM);
        bright = (uint16_t)(lum*0.9 + 102);
        EPWM1_LoadDutyValue(bright);    
    }
}

void displayMux(void)
{   
    park_bcd.all = bin2bcd(park_uint);
    switch(cat)
    {
        case 0b01100000:
            cat = 0b10100000;
            PORTA = segVal[park_bcd.dig3];
            break;
        case 0b10100000:
            cat = 0b11000000;
            PORTA = segVal[park_bcd.dig2];
            break;
        case 0b11000000:
            cat = 0b01100000;
            PORTA = segVal[park_bcd.dig1];
            break;
        default:
            cat = 0b01100000;
            break;
    }
    
    TRISB = (TRISB & 0b00011111) | cat;
}

void dattaOut(void)
{
    park_bcd.all = bin2bcd(park_uint);
    
    EUSART_Write(0x24);
    EUSART_Write(uint2ASCII(park_bcd.dig3));
    EUSART_Write(uint2ASCII(park_bcd.dig2));
    EUSART_Write(uint2ASCII(park_bcd.dig1));
    EUSART_Write(0x0D);
}

void carIn(void)
{
    park_uint = (park_uint == 0)? park_uint : park_uint-1;
}

void carOut(void)
{
   park_uint = (park_uint == 999)? park_uint : park_uint+1;
}

uint8_t uint2ASCII(uint8_t num)
{
    return num + 0x30;
}
/**
 End of File
*/