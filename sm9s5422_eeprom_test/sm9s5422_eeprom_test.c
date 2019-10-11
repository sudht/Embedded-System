#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <sys/ioctl.h>
#include <linux/ioctl.h>

#define EEPROM_WREN 	0x6
#define EEPROM_WRDI 	0x4
#define EEPROM_RDSR 	0x5
#define EEPROM_WRSR 	0x1
#define EEPROM_READ 	0x3
#define EEPROM_WRITE 	0x2

void eeprom_write(void);
void eeprom_read(void);
int dev;

int main(int argc, char * argv[]) {

	int flag=1, menu=0;

	dev = open("/dev/sm9_eeprom", O_RDWR);
	if (dev < 0) {
		printf("/dev/sm9_eeprom open error ! \n");
		return -1;
	}

	while(flag)
	{
		printf("*********** eeprom test ***********\n");
		printf(" 1. DATA WRITE\n");
		printf(" 2. DATA READ\n");
		printf(" 3. END\n");
		printf("************************************\n\n");
		scanf("%d",&menu);

		switch(menu)
		{
		case 1:
			eeprom_write();
			break;
		case 2:
			eeprom_read();
			break;
		case 3:
			flag = 0;
			break;
		default:
			printf("plz Enter a number 1-3\n");
			break;
		}
	}

	close(dev);
	return 0;
}

void eeprom_write(void)
{
	int addr, data;

	uint8_t tx_packet_write[] = {
			EEPROM_WRITE, 0x00, 0x00, 0x00,
	};
	uint8_t tx_packet_wren[] = {
			EEPROM_WREN,
	};
	uint8_t tx_packet_wrdi[] = {
			EEPROM_WRDI,
	};

	printf("plz input address (0 ~ 2047) :");
	scanf("%d",&addr);
	printf("plz input write data (0 ~ 255) :");
	scanf("%d",&data);

	tx_packet_write[1] = (addr >> 8);
	tx_packet_write[2] = (addr & 0xff);
	tx_packet_write[3] = data&0xff;

	write(dev, tx_packet_wren, 1);
	usleep(1*1000);

	write(dev, tx_packet_write, 4);
	usleep(2*1000);

	write(dev, tx_packet_wrdi, 1);
}

void eeprom_read(void)
{
	uint8_t tx_packet[] = {
			EEPROM_READ, 0x00, 0x00,
	};
	int data,addr;

	printf("plz input address (0 ~ 2047) :");
	scanf("%d",&addr);

	tx_packet[1] = (addr >> 8);
	tx_packet[2] = (addr & 0xff);

	data=read(dev, tx_packet, 3);
	if (data < 0)
		printf("can't send spi message\n");

	printf("\n\t recive data = %d\n\n", data);
}
