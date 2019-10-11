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
