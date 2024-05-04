#include "functions.h"
#include "mcc_generated_files/eusart.h"

void analyze(void)
{
    switch(command)
    {
        case 'L':
            temp = listAvailability();
            EEPROMTobuffer(0);
            if (client_buffer.status == '\0')
                writeMsg(msg2);
            else
            {
                writeMsg(msg1);
                writeList();
            }
            break;
        case 'A':
            temp = listAvailability();
            if (temp == 10)
                writeMsg(msg7);
            else
            {
                writeMsg(msg4);
                getName(temp);
                if(validName(client_buffer.name))
                {
                    writeMsg(msg8);
                    bufferToEEPROM(temp);
                    
                }
                else
                {
                    writeMsg(msg5);
                } 
            }
            break;
        case 'P':
            temp = listBooked();
            if (temp == 10)
                writeMsg(msg6);
            else
            {
                client[temp].status = 'X';
                EEPROMTobuffer(temp);
                writeMsg(msg3);
                writeMsg2(client_buffer.name);
            }
            break;
        case 'R':
            erase_list();
            writeMsg(msg2);
            break;
        default:
            writeMsg(msg0);
            break;
    }
}

void writeMsg(const char *msg)
{
    int i = 0;
    while(msg[i] > 0)
    {
        EUSART_Write(msg[i]);
        i++;
    }
    EUSART_Write(0x0D);
}

void writeMsg2(char *msg)
{
    int i = 0;
    while(msg[i] > 0)
    {
        EUSART_Write(msg[i]);
        i++;
    }
    EUSART_Write(0x0D);
}

void getName(uint8_t i)
{
    uint8_t rxChar = 0;
    int j = 0;
    client_buffer.status = ' ';

    while(1)
    {
        if (EUSART_is_rx_ready())
        {
            rxChar = EUSART_Read();
            client_buffer.name[j] = rxChar;
            j++;
        }
        if (rxChar == 0x0D)
        {
            client_buffer.name[j--] = '\0';
            break;
        }
        else if (j == 21)
        {
            client_buffer.name[j] = '\0';
            break;
        }
    } 
}

void erase_list(void)
{
    for(int i = 0; i <= 10; i++)
    {
        client[i].status = '\0';
    }
}

uint8_t listAvailability(void)
{
    for(uint8_t i = 0; i < 10; i++)
    {
        if(client[i].status == '\0')
            return i;
    }
    return 10;
}

uint8_t listBooked(void)
{
    for(uint8_t i = 0; i < 10; i++)
    {
        if(client[i].status == ' ')
            return i;
    }
    return 10;
}

void writeList(void)
{
    for(uint8_t i = 0; i < 10; i++)
    {
        if(client[i].status != '\0')
        {
            EEPROMTobuffer(i);
            EUSART_Write(client_buffer.status);
            EUSART_Write(' ');
            writeMsg2(client_buffer.name);
        }
    }
}

void bufferToEEPROM (uint8_t i)
{
    uint8_t z = 0;
    while(1)
    {
        if(client_buffer.name[z] == '\0')
        {
            client[i].name[z] = '\0';
            break;
        }
        else
        {
            client[i].name[z] = client_buffer.name[z];
            z++;
        }
    }
    client[i].status = client_buffer.status;
}

void EEPROMTobuffer (uint8_t i)
{
    uint8_t z = 0;
    while(1)
    {
        if(client[i].name[z] == '\0')
        {
            client_buffer.name[z] = '\0';
            break;
        }
        else
        {
            client_buffer.name[z] = client[i].name[z];
            z++;
        }
    }
    
    client_buffer.status = client[i].status;
}

uint8_t validName(char *msg)
{
    if(msg[0] == 0x0D || msg[0] == '\0')
        return 0;
    return 1;
}
