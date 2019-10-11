#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <time.h>
#include <termios.h>

static struct termios initial_settings, new_settings;
static int peek_character = -1;

void init_keyboard() {
	tcgetattr(0, &initial_settings);
	new_settings = initial_settings;
	new_settings.c_lflag &= ~ICANON;
	new_settings.c_lflag &= ~ECHO;
	new_settings.c_lflag &= ~ISIG;
	new_settings.c_cc[VTIME] = 1;

	new_settings.c_cc[VTIME] = 0;
	tcsetattr(0, TCSANOW, &new_settings);
}

void close_keyboard() {
	tcsetattr(0, TCSANOW, &initial_settings);
}

int kbhit() {
	char ch;
	int nread;

	if (peek_character != -1) return 1;


	new_settings.c_cc[VTIME] = 0;
	tcsetattr(0, TCSANOW, &new_settings);
	nread = read(0, &ch, 1);
	new_settings.c_cc[VTIME] = 1;
	tcsetattr(0, TCSANOW, &new_settings);

	if (nread == 1) {
		peek_character = ch;
		return 1;
	}

	return 0;
}

int readch() {
	char ch;

	if (peek_character != -1) {

		ch = peek_character;
		peek_character = -1;
		return ch;
	}
	read(0, &ch, 1);
	return ch;
}


int main(int argc, char * argv[]) {
	int fd, value1 = 1,value2 = 1, i, count, temp, ch;
	unsigned short input, dir = 0;
	char temp_val[6] = { 0 };
	char opr;

	if ((fd = open("/dev/sm9s5422_segment", O_RDWR | O_SYNC)) < 0) {
		printf("FND open fail\n");
		exit(1);
	}

	init_keyboard();


	printf("Input value : ");
	close_keyboard();
	scanf("%d", &value1);
	init_keyboard();

	while(count < value1){
		count++;
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

		for(i=0; i<2; i++)
		write(fd,&temp_val,6);
	}
	for(i=0; i<50; i++)
			write(fd,&temp_val,6);

	close_keyboard();
	close(fd);
	return 0;

}
