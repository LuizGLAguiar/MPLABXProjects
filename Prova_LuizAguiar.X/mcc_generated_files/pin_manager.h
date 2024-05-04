/**
  @Generated Pin Manager Header File

  @Company:
    Microchip Technology Inc.

  @File Name:
    pin_manager.h

  @Summary:
    This is the Pin Manager file generated using PIC10 / PIC12 / PIC16 / PIC18 MCUs

  @Description
    This header file provides APIs for driver for .
    Generation Information :
        Product Revision  :  PIC10 / PIC12 / PIC16 / PIC18 MCUs - 1.81.8
        Device            :  PIC16F1827
        Driver Version    :  2.11
    The generated drivers are tested against the following:
        Compiler          :  XC8 2.36 and above
        MPLAB 	          :  MPLAB X 6.00	
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

#ifndef PIN_MANAGER_H
#define PIN_MANAGER_H

/**
  Section: Included Files
*/

#include <xc.h>

#define INPUT   1
#define OUTPUT  0

#define HIGH    1
#define LOW     0

#define ANALOG      1
#define DIGITAL     0

#define PULL_UP_ENABLED      1
#define PULL_UP_DISABLED     0

// get/set A aliases
#define A_TRIS                 TRISAbits.TRISA0
#define A_LAT                  LATAbits.LATA0
#define A_PORT                 PORTAbits.RA0
#define A_ANS                  ANSELAbits.ANSA0
#define A_SetHigh()            do { LATAbits.LATA0 = 1; } while(0)
#define A_SetLow()             do { LATAbits.LATA0 = 0; } while(0)
#define A_Toggle()             do { LATAbits.LATA0 = ~LATAbits.LATA0; } while(0)
#define A_GetValue()           PORTAbits.RA0
#define A_SetDigitalInput()    do { TRISAbits.TRISA0 = 1; } while(0)
#define A_SetDigitalOutput()   do { TRISAbits.TRISA0 = 0; } while(0)
#define A_SetAnalogMode()      do { ANSELAbits.ANSA0 = 1; } while(0)
#define A_SetDigitalMode()     do { ANSELAbits.ANSA0 = 0; } while(0)

// get/set B aliases
#define B_TRIS                 TRISAbits.TRISA1
#define B_LAT                  LATAbits.LATA1
#define B_PORT                 PORTAbits.RA1
#define B_ANS                  ANSELAbits.ANSA1
#define B_SetHigh()            do { LATAbits.LATA1 = 1; } while(0)
#define B_SetLow()             do { LATAbits.LATA1 = 0; } while(0)
#define B_Toggle()             do { LATAbits.LATA1 = ~LATAbits.LATA1; } while(0)
#define B_GetValue()           PORTAbits.RA1
#define B_SetDigitalInput()    do { TRISAbits.TRISA1 = 1; } while(0)
#define B_SetDigitalOutput()   do { TRISAbits.TRISA1 = 0; } while(0)
#define B_SetAnalogMode()      do { ANSELAbits.ANSA1 = 1; } while(0)
#define B_SetDigitalMode()     do { ANSELAbits.ANSA1 = 0; } while(0)

// get/set C aliases
#define C_TRIS                 TRISAbits.TRISA2
#define C_LAT                  LATAbits.LATA2
#define C_PORT                 PORTAbits.RA2
#define C_ANS                  ANSELAbits.ANSA2
#define C_SetHigh()            do { LATAbits.LATA2 = 1; } while(0)
#define C_SetLow()             do { LATAbits.LATA2 = 0; } while(0)
#define C_Toggle()             do { LATAbits.LATA2 = ~LATAbits.LATA2; } while(0)
#define C_GetValue()           PORTAbits.RA2
#define C_SetDigitalInput()    do { TRISAbits.TRISA2 = 1; } while(0)
#define C_SetDigitalOutput()   do { TRISAbits.TRISA2 = 0; } while(0)
#define C_SetAnalogMode()      do { ANSELAbits.ANSA2 = 1; } while(0)
#define C_SetDigitalMode()     do { ANSELAbits.ANSA2 = 0; } while(0)

// get/set D aliases
#define D_TRIS                 TRISAbits.TRISA3
#define D_LAT                  LATAbits.LATA3
#define D_PORT                 PORTAbits.RA3
#define D_ANS                  ANSELAbits.ANSA3
#define D_SetHigh()            do { LATAbits.LATA3 = 1; } while(0)
#define D_SetLow()             do { LATAbits.LATA3 = 0; } while(0)
#define D_Toggle()             do { LATAbits.LATA3 = ~LATAbits.LATA3; } while(0)
#define D_GetValue()           PORTAbits.RA3
#define D_SetDigitalInput()    do { TRISAbits.TRISA3 = 1; } while(0)
#define D_SetDigitalOutput()   do { TRISAbits.TRISA3 = 0; } while(0)
#define D_SetAnalogMode()      do { ANSELAbits.ANSA3 = 1; } while(0)
#define D_SetDigitalMode()     do { ANSELAbits.ANSA3 = 0; } while(0)

// get/set E aliases
#define E_TRIS                 TRISAbits.TRISA4
#define E_LAT                  LATAbits.LATA4
#define E_PORT                 PORTAbits.RA4
#define E_ANS                  ANSELAbits.ANSA4
#define E_SetHigh()            do { LATAbits.LATA4 = 1; } while(0)
#define E_SetLow()             do { LATAbits.LATA4 = 0; } while(0)
#define E_Toggle()             do { LATAbits.LATA4 = ~LATAbits.LATA4; } while(0)
#define E_GetValue()           PORTAbits.RA4
#define E_SetDigitalInput()    do { TRISAbits.TRISA4 = 1; } while(0)
#define E_SetDigitalOutput()   do { TRISAbits.TRISA4 = 0; } while(0)
#define E_SetAnalogMode()      do { ANSELAbits.ANSA4 = 1; } while(0)
#define E_SetDigitalMode()     do { ANSELAbits.ANSA4 = 0; } while(0)

// get/set F aliases
#define F_TRIS                 TRISAbits.TRISA6
#define F_LAT                  LATAbits.LATA6
#define F_PORT                 PORTAbits.RA6
#define F_SetHigh()            do { LATAbits.LATA6 = 1; } while(0)
#define F_SetLow()             do { LATAbits.LATA6 = 0; } while(0)
#define F_Toggle()             do { LATAbits.LATA6 = ~LATAbits.LATA6; } while(0)
#define F_GetValue()           PORTAbits.RA6
#define F_SetDigitalInput()    do { TRISAbits.TRISA6 = 1; } while(0)
#define F_SetDigitalOutput()   do { TRISAbits.TRISA6 = 0; } while(0)

// get/set G aliases
#define G_TRIS                 TRISAbits.TRISA7
#define G_LAT                  LATAbits.LATA7
#define G_PORT                 PORTAbits.RA7
#define G_SetHigh()            do { LATAbits.LATA7 = 1; } while(0)
#define G_SetLow()             do { LATAbits.LATA7 = 0; } while(0)
#define G_Toggle()             do { LATAbits.LATA7 = ~LATAbits.LATA7; } while(0)
#define G_GetValue()           PORTAbits.RA7
#define G_SetDigitalInput()    do { TRISAbits.TRISA7 = 1; } while(0)
#define G_SetDigitalOutput()   do { TRISAbits.TRISA7 = 0; } while(0)

// get/set SENS_IN aliases
#define SENS_IN_TRIS                 TRISBbits.TRISB0
#define SENS_IN_LAT                  LATBbits.LATB0
#define SENS_IN_PORT                 PORTBbits.RB0
#define SENS_IN_WPU                  WPUBbits.WPUB0
#define SENS_IN_SetHigh()            do { LATBbits.LATB0 = 1; } while(0)
#define SENS_IN_SetLow()             do { LATBbits.LATB0 = 0; } while(0)
#define SENS_IN_Toggle()             do { LATBbits.LATB0 = ~LATBbits.LATB0; } while(0)
#define SENS_IN_GetValue()           PORTBbits.RB0
#define SENS_IN_SetDigitalInput()    do { TRISBbits.TRISB0 = 1; } while(0)
#define SENS_IN_SetDigitalOutput()   do { TRISBbits.TRISB0 = 0; } while(0)
#define SENS_IN_SetPullup()          do { WPUBbits.WPUB0 = 1; } while(0)
#define SENS_IN_ResetPullup()        do { WPUBbits.WPUB0 = 0; } while(0)

// get/set RB1 procedures
#define RB1_SetHigh()            do { LATBbits.LATB1 = 1; } while(0)
#define RB1_SetLow()             do { LATBbits.LATB1 = 0; } while(0)
#define RB1_Toggle()             do { LATBbits.LATB1 = ~LATBbits.LATB1; } while(0)
#define RB1_GetValue()              PORTBbits.RB1
#define RB1_SetDigitalInput()    do { TRISBbits.TRISB1 = 1; } while(0)
#define RB1_SetDigitalOutput()   do { TRISBbits.TRISB1 = 0; } while(0)
#define RB1_SetPullup()             do { WPUBbits.WPUB1 = 1; } while(0)
#define RB1_ResetPullup()           do { WPUBbits.WPUB1 = 0; } while(0)
#define RB1_SetAnalogMode()         do { ANSELBbits.ANSB1 = 1; } while(0)
#define RB1_SetDigitalMode()        do { ANSELBbits.ANSB1 = 0; } while(0)

// get/set RB2 procedures
#define RB2_SetHigh()            do { LATBbits.LATB2 = 1; } while(0)
#define RB2_SetLow()             do { LATBbits.LATB2 = 0; } while(0)
#define RB2_Toggle()             do { LATBbits.LATB2 = ~LATBbits.LATB2; } while(0)
#define RB2_GetValue()              PORTBbits.RB2
#define RB2_SetDigitalInput()    do { TRISBbits.TRISB2 = 1; } while(0)
#define RB2_SetDigitalOutput()   do { TRISBbits.TRISB2 = 0; } while(0)
#define RB2_SetPullup()             do { WPUBbits.WPUB2 = 1; } while(0)
#define RB2_ResetPullup()           do { WPUBbits.WPUB2 = 0; } while(0)
#define RB2_SetAnalogMode()         do { ANSELBbits.ANSB2 = 1; } while(0)
#define RB2_SetDigitalMode()        do { ANSELBbits.ANSB2 = 0; } while(0)

// get/set SENS_OUT aliases
#define SENS_OUT_TRIS                 TRISBbits.TRISB3
#define SENS_OUT_LAT                  LATBbits.LATB3
#define SENS_OUT_PORT                 PORTBbits.RB3
#define SENS_OUT_WPU                  WPUBbits.WPUB3
#define SENS_OUT_ANS                  ANSELBbits.ANSB3
#define SENS_OUT_SetHigh()            do { LATBbits.LATB3 = 1; } while(0)
#define SENS_OUT_SetLow()             do { LATBbits.LATB3 = 0; } while(0)
#define SENS_OUT_Toggle()             do { LATBbits.LATB3 = ~LATBbits.LATB3; } while(0)
#define SENS_OUT_GetValue()           PORTBbits.RB3
#define SENS_OUT_SetDigitalInput()    do { TRISBbits.TRISB3 = 1; } while(0)
#define SENS_OUT_SetDigitalOutput()   do { TRISBbits.TRISB3 = 0; } while(0)
#define SENS_OUT_SetPullup()          do { WPUBbits.WPUB3 = 1; } while(0)
#define SENS_OUT_ResetPullup()        do { WPUBbits.WPUB3 = 0; } while(0)
#define SENS_OUT_SetAnalogMode()      do { ANSELBbits.ANSB3 = 1; } while(0)
#define SENS_OUT_SetDigitalMode()     do { ANSELBbits.ANSB3 = 0; } while(0)

// get/set SENS_LUM aliases
#define SENS_LUM_TRIS                 TRISBbits.TRISB4
#define SENS_LUM_LAT                  LATBbits.LATB4
#define SENS_LUM_PORT                 PORTBbits.RB4
#define SENS_LUM_WPU                  WPUBbits.WPUB4
#define SENS_LUM_ANS                  ANSELBbits.ANSB4
#define SENS_LUM_SetHigh()            do { LATBbits.LATB4 = 1; } while(0)
#define SENS_LUM_SetLow()             do { LATBbits.LATB4 = 0; } while(0)
#define SENS_LUM_Toggle()             do { LATBbits.LATB4 = ~LATBbits.LATB4; } while(0)
#define SENS_LUM_GetValue()           PORTBbits.RB4
#define SENS_LUM_SetDigitalInput()    do { TRISBbits.TRISB4 = 1; } while(0)
#define SENS_LUM_SetDigitalOutput()   do { TRISBbits.TRISB4 = 0; } while(0)
#define SENS_LUM_SetPullup()          do { WPUBbits.WPUB4 = 1; } while(0)
#define SENS_LUM_ResetPullup()        do { WPUBbits.WPUB4 = 0; } while(0)
#define SENS_LUM_SetAnalogMode()      do { ANSELBbits.ANSB4 = 1; } while(0)
#define SENS_LUM_SetDigitalMode()     do { ANSELBbits.ANSB4 = 0; } while(0)

// get/set RB5 procedures
#define RB5_SetHigh()            do { LATBbits.LATB5 = 1; } while(0)
#define RB5_SetLow()             do { LATBbits.LATB5 = 0; } while(0)
#define RB5_Toggle()             do { LATBbits.LATB5 = ~LATBbits.LATB5; } while(0)
#define RB5_GetValue()              PORTBbits.RB5
#define RB5_SetDigitalInput()    do { TRISBbits.TRISB5 = 1; } while(0)
#define RB5_SetDigitalOutput()   do { TRISBbits.TRISB5 = 0; } while(0)
#define RB5_SetPullup()             do { WPUBbits.WPUB5 = 1; } while(0)
#define RB5_ResetPullup()           do { WPUBbits.WPUB5 = 0; } while(0)
#define RB5_SetAnalogMode()         do { ANSELBbits.ANSB5 = 1; } while(0)
#define RB5_SetDigitalMode()        do { ANSELBbits.ANSB5 = 0; } while(0)

// get/set RB6 procedures
#define RB6_SetHigh()            do { LATBbits.LATB6 = 1; } while(0)
#define RB6_SetLow()             do { LATBbits.LATB6 = 0; } while(0)
#define RB6_Toggle()             do { LATBbits.LATB6 = ~LATBbits.LATB6; } while(0)
#define RB6_GetValue()              PORTBbits.RB6
#define RB6_SetDigitalInput()    do { TRISBbits.TRISB6 = 1; } while(0)
#define RB6_SetDigitalOutput()   do { TRISBbits.TRISB6 = 0; } while(0)
#define RB6_SetPullup()             do { WPUBbits.WPUB6 = 1; } while(0)
#define RB6_ResetPullup()           do { WPUBbits.WPUB6 = 0; } while(0)
#define RB6_SetAnalogMode()         do { ANSELBbits.ANSB6 = 1; } while(0)
#define RB6_SetDigitalMode()        do { ANSELBbits.ANSB6 = 0; } while(0)

// get/set RB7 procedures
#define RB7_SetHigh()            do { LATBbits.LATB7 = 1; } while(0)
#define RB7_SetLow()             do { LATBbits.LATB7 = 0; } while(0)
#define RB7_Toggle()             do { LATBbits.LATB7 = ~LATBbits.LATB7; } while(0)
#define RB7_GetValue()              PORTBbits.RB7
#define RB7_SetDigitalInput()    do { TRISBbits.TRISB7 = 1; } while(0)
#define RB7_SetDigitalOutput()   do { TRISBbits.TRISB7 = 0; } while(0)
#define RB7_SetPullup()             do { WPUBbits.WPUB7 = 1; } while(0)
#define RB7_ResetPullup()           do { WPUBbits.WPUB7 = 0; } while(0)
#define RB7_SetAnalogMode()         do { ANSELBbits.ANSB7 = 1; } while(0)
#define RB7_SetDigitalMode()        do { ANSELBbits.ANSB7 = 0; } while(0)

/**
   @Param
    none
   @Returns
    none
   @Description
    GPIO and peripheral I/O initialization
   @Example
    PIN_MANAGER_Initialize();
 */
void PIN_MANAGER_Initialize (void);

/**
 * @Param
    none
 * @Returns
    none
 * @Description
    Interrupt on Change Handling routine
 * @Example
    PIN_MANAGER_IOC();
 */
void PIN_MANAGER_IOC(void);


/**
 * @Param
    none
 * @Returns
    none
 * @Description
    Interrupt on Change Handler for the IOCBF0 pin functionality
 * @Example
    IOCBF0_ISR();
 */
void IOCBF0_ISR(void);

/**
  @Summary
    Interrupt Handler Setter for IOCBF0 pin interrupt-on-change functionality

  @Description
    Allows selecting an interrupt handler for IOCBF0 at application runtime
    
  @Preconditions
    Pin Manager intializer called

  @Returns
    None.

  @Param
    InterruptHandler function pointer.

  @Example
    PIN_MANAGER_Initialize();
    IOCBF0_SetInterruptHandler(MyInterruptHandler);

*/
void IOCBF0_SetInterruptHandler(void (* InterruptHandler)(void));

/**
  @Summary
    Dynamic Interrupt Handler for IOCBF0 pin

  @Description
    This is a dynamic interrupt handler to be used together with the IOCBF0_SetInterruptHandler() method.
    This handler is called every time the IOCBF0 ISR is executed and allows any function to be registered at runtime.
    
  @Preconditions
    Pin Manager intializer called

  @Returns
    None.

  @Param
    None.

  @Example
    PIN_MANAGER_Initialize();
    IOCBF0_SetInterruptHandler(IOCBF0_InterruptHandler);

*/
extern void (*IOCBF0_InterruptHandler)(void);

/**
  @Summary
    Default Interrupt Handler for IOCBF0 pin

  @Description
    This is a predefined interrupt handler to be used together with the IOCBF0_SetInterruptHandler() method.
    This handler is called every time the IOCBF0 ISR is executed. 
    
  @Preconditions
    Pin Manager intializer called

  @Returns
    None.

  @Param
    None.

  @Example
    PIN_MANAGER_Initialize();
    IOCBF0_SetInterruptHandler(IOCBF0_DefaultInterruptHandler);

*/
void IOCBF0_DefaultInterruptHandler(void);


/**
 * @Param
    none
 * @Returns
    none
 * @Description
    Interrupt on Change Handler for the IOCBF3 pin functionality
 * @Example
    IOCBF3_ISR();
 */
void IOCBF3_ISR(void);

/**
  @Summary
    Interrupt Handler Setter for IOCBF3 pin interrupt-on-change functionality

  @Description
    Allows selecting an interrupt handler for IOCBF3 at application runtime
    
  @Preconditions
    Pin Manager intializer called

  @Returns
    None.

  @Param
    InterruptHandler function pointer.

  @Example
    PIN_MANAGER_Initialize();
    IOCBF3_SetInterruptHandler(MyInterruptHandler);

*/
void IOCBF3_SetInterruptHandler(void (* InterruptHandler)(void));

/**
  @Summary
    Dynamic Interrupt Handler for IOCBF3 pin

  @Description
    This is a dynamic interrupt handler to be used together with the IOCBF3_SetInterruptHandler() method.
    This handler is called every time the IOCBF3 ISR is executed and allows any function to be registered at runtime.
    
  @Preconditions
    Pin Manager intializer called

  @Returns
    None.

  @Param
    None.

  @Example
    PIN_MANAGER_Initialize();
    IOCBF3_SetInterruptHandler(IOCBF3_InterruptHandler);

*/
extern void (*IOCBF3_InterruptHandler)(void);

/**
  @Summary
    Default Interrupt Handler for IOCBF3 pin

  @Description
    This is a predefined interrupt handler to be used together with the IOCBF3_SetInterruptHandler() method.
    This handler is called every time the IOCBF3 ISR is executed. 
    
  @Preconditions
    Pin Manager intializer called

  @Returns
    None.

  @Param
    None.

  @Example
    PIN_MANAGER_Initialize();
    IOCBF3_SetInterruptHandler(IOCBF3_DefaultInterruptHandler);

*/
void IOCBF3_DefaultInterruptHandler(void);



#endif // PIN_MANAGER_H
/**
 End of File
*/