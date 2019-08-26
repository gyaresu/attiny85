#define F_CPU 1000000L
#include <avr/io.h>
#include <util/twi.h>
#include <util/delay.h>
#include "i2cmaster.S"

#define address 0x50

int main (void)
{	

 	i2c_init();
// 	i2c_start_wait(address+I2C_WRITE);
// 	i2c_write(0x00);
// 	i2c_write(0x00);
// 	i2c_write(0x42);
// 	i2c_stop();

	return 1;
}
