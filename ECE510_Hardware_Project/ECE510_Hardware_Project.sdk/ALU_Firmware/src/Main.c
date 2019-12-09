/*
 * Main.c
 *
 *  Created on: Dec 8, 2019
 *      Author: natha
 */
#include "xparameters.h"
#include "xbasic_types.h"
#include "xgpio.h"
#include "xstatus.h"



XGpio GpioDevice;

Xuint32 Parse(Xuint32 port, int iStart, int iEnd);
Xuint32 bitAt(Xuint32 val, int pos);
unsigned bitSpec(int start, int len);

int main(void)
{
	//Variables
	Xuint32 statusCode;
	Xuint32 DataRead;
	Xuint32 numA,numB,operation;
	Xuint32 numOut;
	Xuint32 oldData;
	char operator;
	statusCode = XGpio_Initialize(&GpioDevice,XPAR_GPIO_0_DEVICE_ID);
	if (statusCode != XST_SUCCESS)
		return XST_FAILURE;

	XGpio_SetDataDirection(&GpioDevice,1,0x00000000);
	XGpio_SetDataDirection(&GpioDevice,2,0xFFFFFFFF);
	oldData = 0xFFFFFFFF;
	xil_printf("ECE510 Hardware Project\r\nJacob Berdichevsky, Nathan Schimpf\r\n");
	for(;;)
	{
		DataRead = XGpio_DiscreteRead(&GpioDevice,2);
		numA = Parse(DataRead,0,9);
		numB = Parse(DataRead,12,21);
		operation = Parse(DataRead,10,11);

		if(DataRead != oldData)
		{
			switch(operation){
				case 0x00000000:
					numOut = numA + numB;
					operator='+';
					break;
				case 0x00000001:
					numOut = numA - numB;
					operator='-';
					break;
				case 0x00000002:
					numOut = numA * numB;
					operator='*';
					break;
				case 0x00000003:
					numOut = numA / numB;
					operator='/';
					break;

			}

			xil_printf("Num A %c Num B => %d %c %d = %d\r\n",operator,numA,operator,numB,numOut);
			oldData = DataRead;
		}
	}
}

Xuint32 Parse(Xuint32 port, int iStart, int iEnd)
{
	Xuint32 total=0;
	Xuint32 mask = bitSpec(iStart,iEnd-iStart+1);
	total = (port & mask)>>iStart;

	return total;
}

//Xuint32 getBitMask(int highbit, int lowbit) {
//	//https://stackoverflow.com/a/35109809
//	Xuint32 i = ~0U;
//    return ~(i << highbit << 1) & (i << lowbit);
//}

unsigned bitSpec(int start, int len) {
    return (~0U >> (32 - len)) << start;
}

Xuint32 bitAt(Xuint32 val, int pos)
{
	return val&(1<<pos);
}


