#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <termios.h>

char getKey();
int kbhit(void);

int main(int argc, char * argv[]) {
	char key;
	int devV, devI;
	char temp;
	char buff[100];

	devV = open("/dev/two_sm9s5422_perivib", O_WRONLY);
	devI = open("/dev/t_sm9s5422_interrupt",O_RDWR);
	temp = atoi(argv[1]);

	if(argc <=1) {
			printf("please input the parameter! ex)./test 1 or 0\n");
			return -1;
		}

	while(1)  {
		read(devI,buff,100);
		if(!strcmp(buff, "Up")) {
			write(devV, &temp ,1);
		}
		else if (!strcmp(buff, "Down")) {
			write(devV, 0 ,1);
		}
	}
	close(devV);

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
