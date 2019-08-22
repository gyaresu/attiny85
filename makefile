MCU=attiny85
AVRDUDEMCU=t85
CC=/usr/bin/avr-gcc
CFLAGS=-g -Os -Wall -mcall-prologues -mmcu=$(MCU)
OBJ2HEX=/usr/bin/avr-objcopy
AVRDUDE=/usr/bin/avrdude
TARGET=blink
# target = name of your file you want upload on the attiny
GPIOPIN=25

all : 
# no need this part if you have the .hex :D
	$(CC) $(CFLAGS) $(TARGET).c -o $(TARGET)
	$(OBJ2HEX) -R .eeprom -O ihex $(TARGET) $(TARGET).hex
	rm -f $(TARGET)

install : all
	sudo gpio -g mode $(GPIOPIN) out
	sudo gpio -g write $(GPIOPIN) 0
	sudo $(AVRDUDE) -p $(AVRDUDEMCU) -P /dev/spidev0.0 -c linuxspi -b 14400 -U flash:w:$(TARGET).hex
	sudo gpio -g write $(GPIOPIN) 1

noreset : all
	sudo $(AVRDUDE) -p $(AVRDUDEMCU) -P /dev/spidev0.0 -c linuxspi -b 14400 -U flash:w:$(TARGET).hex

fuse :
	sudo gpio -g mode $(GPIOPIN) out
	sudo gpio -g write $(GPIOPIN) 0
	sudo $(AVRDUDE) -p $(AVRDUDEMCU) -P /dev/spidev0.0 -c linuxspi -b 14400 -U lfuse:w:0x62:m -U hfuse:w:0xdf:m -U efuse:w:0xff:m 
	sudo gpio -g write $(GPIOPIN) 1

clean :
	rm -f *.hex *.obj *.o
