#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main(int argc, char * argv[]) {
	int dev;
	int iResult=0;
	float t, t_C;
	float fTemp, fHumi;
	int i = 0;

	dev = open("/dev/sm9s5422_sht20", O_WRONLY);

	while(i<10)
	{
		sleep(1);
		iResult = ioctl(dev, 0,NULL);
		t = (float)iResult;
		t_C = -46.85+175.72/65536 * t;
		fTemp = t_C;

		sleep(1);
		iResult = ioctl(dev, 1,NULL);
		t = (float)iResult;
		t_C = -6.0+125.0/65536 * t;
		fHumi = t_C;

		printf("*** TEMP/HUMI *** \n");
		printf("Main Temp : %.1f C\n", fTemp);
		printf("Main Humi : %.1f H\n", fHumi);
		printf("\n");
		i++;
	}
	close(dev);

	return 0;
}
