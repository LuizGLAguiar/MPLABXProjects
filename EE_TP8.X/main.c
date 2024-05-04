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

void main(void)
{
    // initialize the device
    SYSTEM_Initialize();
    TMR1_SetInterruptHandler(transmitTx);
    count = 0;
    temp_gain = 1;
    lum_gain = 1;
    measure = false;

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
        if (EUSART_is_rx_ready())
        {   
            reg8Bits rxChar;
            rxChar.fullReg = EUSART_Read();
            
            if (rxChar.b7)
            {
                rx.command.fullReg = rxChar.fullReg;
                count++;
            }
            else if (count == 1)
            {
                rx.dataRx.valueH.fullReg = rxChar.fullReg;
                count++;
            }
            else if (count == 2)
            {
                rx.dataRx.valueL.fullReg = rxChar.fullReg;
                count = 0;
                analyzeRx();

            }
            else 
                count = 0;
        }
    }
}

void analyzeRx()
{
    rx.command.b7 = 0;
    rx.dataRx.valueL.b7 = rx.dataRx.valueH.b0;
    rx.dataRx.valueH.fullReg = rx.dataRx.valueH.fullReg >> 1;
    
    switch (rx.command.fullReg)
    {
        case 0:
            measure = rx.dataRx.valueL.b0? true : false;
            break;
        case 1:
            EPWM2_LoadDutyValue(rx.dataRx.fullReg);
            break;
        case 2:
            temp_gain = (float)rx.dataRx.fullReg/1000;
            break;
        default:
            lum_gain = (float)rx.dataRx.fullReg/1000;
            break;
    }
}

void transmitTx()
{
    if (measure)
    {
        FVRCON = 0x83;      // FVR = 4;
        tx.lum.fullReg = (uint16_t)((float)ADC_GetConversion(Lum)*lum_gain*lum_const);
        tx.lum.fullReg = tx.lum.fullReg << 1;
        tx.lum.valueL.fullReg = tx.lum.valueL.fullReg >> 1;
        tx.lum.valueL.b7 = 0;
        FVRCON = 0x82;      // FVR = 2;
        tx.temp.fullReg = (uint16_t)((float)ADC_GetConversion(Temp)*temp_gain*temp_const);
        tx.temp.fullReg = tx.temp.fullReg << 1;
        tx.temp.valueL.fullReg = tx.temp.valueL.fullReg >> 1;
        tx.temp.valueL.b7 = 0;
        tx.command.fullReg = 0x80;
        EUSART_Write(tx.command.fullReg);
        EUSART_Write(tx.temp.valueH.fullReg);
        EUSART_Write(tx.temp.valueL.fullReg);
        EUSART_Write(tx.lum.valueH.fullReg);
        EUSART_Write(tx.lum.valueL.fullReg);
    }

}

/**
 End of File
*/