#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>

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


int DisplayControls(int idev)
{
	int value;

	printf("*** Display Controls ***\n");
	printf("1. Display On\n");
	printf("2. Display Off\n");
	printf("3. Cursor On\n");
	printf("4. Curosr Off\n");

	scanf("%d",&value);

	if (value == 1)
		ioctl(idev, M2_TEXTLCD_DISPLAY_ON,NULL);
	else if(value == 2)
		ioctl(idev, M2_TEXTLCD_DISPLAY_OFF,NULL);
	else if(value == 3)
		ioctl(idev, M2_TEXTLCD_DISPLAY_CURSOR_ON,NULL);
	else if(value == 4)
		ioctl(idev, M2_TEXTLCD_DISPLAY_CURSOR_OFF,NULL);

	return 1;

}
int DisplayClear(int idev)
{
	int value;
	ioctl(idev, M2_TEXTLCD_CLEAR, NULL);

	return 1;
}
int Cursor_Shift(int idev)
{
	int value;

	printf("*** Cursor Shift ***\n");
	printf("1. Cursor Right\n");
	printf("2. Cursor Left\n");
	printf("3. Return Home\n");

	scanf("%d",&value);

	if (value == 1)
		ioctl(idev,
				M2_TEXTLCD_CURSOR_SHIFT_RIGHT, NULL);
	else if(value == 2)
		ioctl(idev, M2_TEXTLCD_CURSOR_SHIFT_LEFT, NULL);
	else if(value == 3)
		ioctl(idev, M2_TEXTLCD_RETURN_HOME, NULL);

	return 1;
}
int DisplayWrite(int idev)
{

	int value, iSize=0, i, j;
	char charData2[1000]="the quick brown fox jumps over the lazy dog";

	ioctl(idev, M2_TEXTLCD_DD_ADDRESS_1, NULL);
	ioctl(idev, M2_TEXTLCD_DD_ADDRESS_2, NULL);

	for(j=0; j<count(charData2)-15; j++) {
		ioctl(idev, M2_TEXTLCD_DD_ADDRESS_2, NULL);
		for(i=0; i<16; i++) {
			ioctl(idev, M2_TEXTLCD_WRITE_BYTE,charData2[(j+i)]);
		}
		sleep(1);
	}

}

int count(char cNum[])
{
	int i=0;
	while(cNum[i] != '\0') i++;
	return i;
}
int main(int argc, char * argv[]) {
	int dev,iexit = 1, value=0;
	char temp,buf[8]={0};
	unsigned char t = 0;

	dev = open("/dev/sm9s5422_textlcd", O_WRONLY);

	while(iexit)
	{
		printf("*** Text LCD ***\n");
		printf("1. Display Controls\n");
		printf("2. Display Clear\n");
		printf("3. Cursor Shift\n");
		printf("4. Display Write\n");
		printf("5. Exit\n");

		scanf("%d",&value);

		switch(value)
		{
		case 1:
			DisplayControls(dev);
			break;
		case 2:
			DisplayClear(dev);
			break;
		case 3:
			Cursor_Shift(dev);
			break;
		case 4:
			DisplayWrite(dev);
			break;
		case 5:
			iexit = 0;
			break;
		}
	}

	close(dev);
	return 0;
}
