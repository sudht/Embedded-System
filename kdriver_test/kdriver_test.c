#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

#include <fcntl.h>

#define NODE_NAME "/dev/kdriver"

int main(int argc, char * argv[]) {
	int fd;	//to do

	fd = open(NODE_NAME, O_WRONLY);
	if(fd < 0) {
		printf("%s open error...\n", NODE_NAME);
		return -1;
	}

	write(fd, NULL, 0);
	ioctl(fd, 0, 0);

	close(fd);

	exit(0);
}
