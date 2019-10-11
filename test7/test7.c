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

int DisplayWrite(int idev, int n)
{
	int value, iSize=0, i = 0, j;
	char charData2[1000]= {0, };

	while(n) {
		charData2[i] = (n%10) + '0';
		n = n/10;
		i++;
	}

	ioctl(idev, M2_TEXTLCD_DD_ADDRESS_1, NULL);
	ioctl(idev, M2_TEXTLCD_DD_ADDRESS_2, NULL);

	for(i=count(charData2)-1; i>=0; i--)
		ioctl(idev, M2_TEXTLCD_WRITE_BYTE,charData2[i]);

	return 0;
}

int count(char cNum[])
{
	int i=0;
	while(cNum[i] != '\0') i++;
	return i;
}

int main(int argc, char * argv[]) {
	char buff[100];
	int devI, devS;
	char temp[4]={1,1,1,1};
	int sleepTime = 10000;
	int dev;

	devI = open("/dev/t_sm9s5422_interrupt",O_RDWR);
	devS = open("/dev/t_sm9s5422_step", O_WRONLY);

	while(1) {
		read(devI,buff,100);
		if(!strcmp(buff, "Up")) {
			sleepTime = sleepTime * 2;
		}
		else if (!strcmp(buff, "Down")) {
			sleepTime = sleepTime / 2;
		}
		else if (!strcmp(buff, "Center")) {
			break;
		}

		temp[0] = 0;
		write(devS,temp,4); usleep(sleepTime);
		temp[0] = 1; temp[1] = 0;
		write(devS,temp,4); usleep(sleepTime);
		temp[1] = 1; temp[2] = 0;
		write(devS,temp,4); usleep(sleepTime);
		temp[2] = 1; temp[3] = 0;
		write(devS,temp,4); usleep(sleepTime);
		temp[3] = 1;
	}

	dev = open("/dev/sm9s5422_textlcd", O_WRONLY);

	DisplayWrite(dev, sleepTime);

	close(dev);
	close(devS);
	close(devI);
	return 0;
}
