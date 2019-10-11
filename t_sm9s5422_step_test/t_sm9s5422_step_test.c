#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <termios.h>

char getKey();
int kbhit(void);

int main(int argc, char * argv[])
{
	char key;
	int dev,i, j;
	char temp[4]={1,1,1,1};
	int sleepTime = 10000;

	dev = open("/dev/t_sm9s5422_step", O_WRONLY);
	for(i=0;i<100;i++)
	{

		for(j=0; j<100; j++) {
			key = getKey();
			if(key == '+') {
				sleepTime -= 1000;
			}
			else if(key == '-') {
				if(sleepTime > 1000)
					sleepTime += 1000;
			}
			else if(key == 'x') {
				close(dev);
				return 0;
			}
			temp[0] = 0;
			write(dev,temp,4);
			usleep(sleepTime);
			temp[0] = 1;
			temp[1] = 0;
			write(dev,temp,4);
			usleep(sleepTime);
			temp[1] = 1;
			temp[2] = 0;
			write(dev,temp,4);
			usleep(sleepTime);
			temp[2] = 1;
			temp[3] = 0;
			write(dev,temp,4);
			usleep(sleepTime);
			temp[3] = 1;
		}

	}
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
