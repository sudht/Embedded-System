#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <termios.h>
#include <time.h>
#include <sys/ioctl.h>
#include <linux/ioctl.h>

#define M2_TEXTLCD_BASE	0x56
#define M2_TEXTLCD_FUNCTION_SET	_IO(M2_TEXTLCD_BASE,0x31)
#define M2_TEXTLCD_DISPLAY_ON	_IO(M2_TEXTLCD_BASE,0x32)
#define M2_TEXTLCD_DISPLAY_OFF	_IO(M2_TEXTLCD_BASE,0x33)
#define M2_TEXTLCD_DISPLAY_CURSOR_ON	_IO(M2_TEXTLCD_BASE,0x34)
#define M2_TEXTLCD_DISPLAY_CURSOR_OFF	_IO(M2_TEXTLCD_BASE,0x35)
#define M2_TEXTLCD_CURSOR_SHIFT_RIGHT	_IO(M2_TEXTLCD_BASE,0x36)
#define M2_TEXTLCD_CURSOR_SHIFT_LEFT	_IO(M2_TEXTLCD_BASE,0x37)
#define M2_TEXTLCD_ENTRY_MODE_SET	_IO(M2_TEXTLCD_BASE,0x38)
#define M2_TEXTLCD_RETURN_HOME	_IO(M2_TEXTLCD_BASE,0x39)
#define M2_TEXTLCD_CLEAR	_IO(M2_TEXTLCD_BASE,0x3a)
#define M2_TEXTLCD_DD_ADDRESS_1		_IO(M2_TEXTLCD_BASE,0x3b)
#define M2_TEXTLCD_DD_ADDRESS_2		_IO(M2_TEXTLCD_BASE,0x3c)
#define M2_TEXTLCD_WRITE_BYTE	_IO(M2_TEXTLCD_BASE,0x3d)

void LED() {
	int dev, i, j;
	int sleepTime = 500000;
	char buf[8]={0};
	char tempbuf[8]={0};

	dev = open("/dev/t_sm9s5422_led", O_WRONLY);
	if (dev != -1) {
		while(1) {
			for(i=0; i<8; i++) {
				buf[i] = 1;

				for(j=0; j<5; j++) {
					write(dev, buf, 8);
					usleep(sleepTime);
					write(dev, tempbuf, 8);
					usleep(sleepTime);
				}
			}
			write(dev, buf, 8);
			for(i=0; i<8; i++) {
				buf[i] = 0;
			}
			usleep(sleepTime*20);
		}
	}
	close(dev);
}

void piezo() {
	int dev,i,flag=1, j;
	int jing[] = {0, 9, 7, 5, 0, 0, 9, 7, 5, 2, 2,
			10, 9, 7, 4, 12, 12, 10, 7, 9, 5, 0, 9,
			7, 5, 0, 0, 9, 7, 5, 2, 2, 10, 9, 7, 12,
			12, 12, 12, 14, 12, 10, 7, 5};

	dev = open("/dev/sm9s5422_piezo", O_WRONLY);

	for(j=0; j<44; j++) {
		write(dev,&jing[j],sizeof(i));
	}

	close(dev);
}

int count(char cNum[])
{
	int i=0;
	while(cNum[i] != '\0') i++;
	return i;
}

int DisplayWrite(int idev)
{

	int value, iSize=0, i, j;
	char charData2[1000]="Dashing throught the snow In a one-horse open sleigh 0'er the fields we go Laughing all the way Bells on bobtail ring Making spirits bright What the it is to ride and sing";

	ioctl(idev, M2_TEXTLCD_DD_ADDRESS_1, NULL);
	ioctl(idev, M2_TEXTLCD_DD_ADDRESS_2, NULL);

	for(j=0; j<count(charData2)-15; j++) {
		ioctl(idev, M2_TEXTLCD_DD_ADDRESS_1, NULL);
		for(i=0; i<16; i++) {
			ioctl(idev, M2_TEXTLCD_WRITE_BYTE,charData2[(j+i)]);
		}
		sleep(1);
	}
	return 0;

}

void LCD() {
	int dev,iexit = 1, value=0;
	char temp,buf[8]={0};
	unsigned char t = 0;
	int jing[] = {0, 9, 7, 5, 0, 0, 9, 7, 5, 2, 2,
				10, 9, 7, 4, 12, 12, 10, 7, 9, 5, 0, 9,
				7, 5, 0, 0, 9, 7, 5, 2, 2, 10, 9, 7, 12,
				12, 12, 12, 14, 12, 10, 7, 5};

	dev = open("/dev/sm9s5422_textlcd", O_WRONLY);

	DisplayWrite(dev);

	close(dev);
}

int main(int argc, char * argv[]) {
	int devPiezo, devLcd, devLed;
	int value, iSize=0, i, j;
	char charData2[1000]="Dashing throught the snow In a one-horse open sleigh 0'er the fields we go Laughing all the way Bells on bobtail ring Making spirits bright What the it is to ride and sing";

	devPiezo = open("/dev/sm9s5422_piezo", O_WRONLY);
	devLcd = open("/dev/sm9s5422_textlcd", O_WRONLY);
	devLed = open("/dev/t_sm9s5422_led", O_WRONLY);

	ioctl(devLcd, M2_TEXTLCD_DD_ADDRESS_1, NULL);
	ioctl(devLcd, M2_TEXTLCD_DD_ADDRESS_2, NULL);

	for(j=0; j<count(charData2)-15; j++) {
		ioctl(devLcd, M2_TEXTLCD_DD_ADDRESS_1, NULL);
		for(i=0; i<16; i++) {
			ioctl(devLcd, M2_TEXTLCD_WRITE_BYTE,charData2[(j+i)]);
		}
		write(dev,&jing[jing],sizeof(i));
		sleep(1);
	}
	return 0;

	LED();
	piezo();
	LCD();

	return 0;
}
