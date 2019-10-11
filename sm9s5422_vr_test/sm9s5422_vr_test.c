#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <time.h>

int main(int argc, char * argv[]) {
	FILE *fp;
	int data,i;
	for(i=0;i<20;i++)
	{
		fp = fopen("/sys/devices/12d10000.adc/iio:device0/in_voltage4_raw","r");
		fscanf(fp,"%d",&data);

		printf("VR - > %d\n",data);

		fclose(fp);
		usleep(200*1000);
	}
	exit(0);
}
