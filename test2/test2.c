#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main(int argc, char * argv[]) {
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
