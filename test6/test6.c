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
	char buff[100];
	char key;
	int devI, devS, i, j, fd;
	char temp_val[6] = { 0 };
	unsigned char t = 0;

	fd = open("/dev/sm9s5422_segment", O_RDWR | O_SYNC);
	devI = open("/dev/t_sm9s5422_interrupt",O_RDWR);


	while(1) {
		read(devI,buff,100);
		if(!strcmp(buff, "Up")) {
			temp_val[5] = temp_val[5] + 1;
			for(j=0; j<10; j++)
				write(fd,&temp_val,6);
		}
		else if (!strcmp(buff, "Down")) {
			temp_val[4] = temp_val[4] + 1;
			for(j=0; j<10; j++)
				write(fd,&temp_val,6);
		}
		else if (!strcmp(buff, "Left")) {
			temp_val[3] = temp_val[3] + 1;
			for(j=0; j<10; j++)
				write(fd,&temp_val,6);
		}
		else if (!strcmp(buff, "Right")) {
			temp_val[2] = temp_val[2] + 1;
			for(j=0; j<10; j++)
				write(fd,&temp_val,6);
		}
		else if (!strcmp(buff, "Center")) {
			for(j=0; j<6; j++) {
				temp_val[j] = 0;
			}
			for(j=0; j<10; j++)
				write(fd,&temp_val,6);
		}
	}

	close(fd);
	close(devI);
	return 0;
}
