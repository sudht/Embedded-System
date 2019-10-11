#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <termios.h>

char getKey();
int kbhit(void);

int main(int argc, char * argv[]) {
	char key;
	int dev, i, j;
	char temp,buf[8]={0};
	unsigned char t = 0;
	int sleepTime = 10000;

	if(argc <= 1) {
		printf("please input the parameter! ex)./test 0xff\n");
		return -1;
	}

	dev = open("/dev/t_sm9s5422_led", O_WRONLY);

	if (dev != -1) {
		if(argv[1][0] == '0' && (argv[1][1] == 'x' || argv[1][1] == 'X'))
		{
			temp = (unsigned short)strtol(&argv[1][2], NULL, 16);
		}
		else
		{
			temp = atoi(argv[1]);
		}
		for(j=0; j<100; j++) {
			key = getKey();
			if(key == '+') {
				sleepTime += 1000;
			}
			else if(key == '-') {
				if(sleepTime > 1000)
					sleepTime -= 1000;
			}
			for(i=0; i<8; i++)
			{
				t<<=1;
				buf[i] = 1;
				write(dev, buf, 8);
				usleep(sleepTime);
				buf[i] = 0;
				write(dev, buf, 8);
				usleep(sleepTime);
			}

			for(i=7; i>=0; i--)
			{
				t<<=1;
				buf[i] = 1;
				write(dev, buf, 8);
				usleep(sleepTime);
				buf[i] = 0;
				write(dev, buf, 8);
				usleep(sleepTime);
			}
		}
	}
	else {
		printf("Device Open ERROR!\n");
		return -1;
	}

	write(dev, buf, 8);
	close(dev);

	return 0;
}

char getKey()
{
	if(kbhit()) // kbhit()이용해 입력값이 있는지 확인
	{
		return getchar();    // 입력값이 getch()로 char를 리턴해줌
	}
	return '\0'; // 입력값이 없으면 널 문자 리턴
}

int kbhit(void)
{
	struct termios oldt, newt;
	int ch;
	int oldf;

	tcgetattr(STDIN_FILENO, &oldt);
	newt = oldt;
	newt.c_lflag &= ~(ICANON | ECHO);
	tcsetattr(STDIN_FILENO, TCSANOW, &newt);
	oldf = fcntl(STDIN_FILENO, F_GETFL, 0);
	fcntl(STDIN_FILENO, F_SETFL, oldf | O_NONBLOCK);

	ch = getchar();

	tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
	fcntl(STDIN_FILENO, F_SETFL, oldf);

	if(ch != EOF)
	{
		ungetc(ch, stdin);
		return 1;
	}

	return 0;
}
