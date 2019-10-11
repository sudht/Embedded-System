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

int main(int argc, char * argv[]) {
	FILE *fp;
	int data,i, j, count, fd, temp;
	char temp_val[6] = { 0 };

	if ((fd = open("/dev/sm9s5422_segment", O_RDWR | O_SYNC)) < 0) {
		printf("FND open fail\n");
		exit(1);
	}

	for(i=0;i<20;i++)
	{
		fp = fopen("/sys/devices/12d10000.adc/iio:device0/in_voltage4_raw","r");
		fscanf(fp,"%d",&data);

		count = data;

		if(data>=2000) {
			for(j=0; j<6; j++)
				temp_val[j] = 8;
		}
		else {
			temp_val[0] = count/100000;
			temp = count % 100000;
			temp_val[1] = temp/10000;
			temp = temp % 10000;
			temp_val[2] = temp/1000;
			temp = temp % 1000;
			temp_val[3] = temp/100;
			temp = temp % 100;
			temp_val[4] = temp/10;
			temp_val[5] = temp%10;
		}

		for(j=0; j<10; j++)
			write(fd,&temp_val,6);

		fclose(fp);
		usleep(200*1000);
	}
	close(fd);
	exit(0);
}
