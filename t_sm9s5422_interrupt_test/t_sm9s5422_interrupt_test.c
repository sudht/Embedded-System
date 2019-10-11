#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <termios.h>

static int dev;
char getKey();
int kbhit(void);

int main(int argc, char * argv[]) {
	char buff[100];
	char key;
	int devI, i, j;
	char temp;
	unsigned char t = 0;

	devI = open("/dev/sm9s5422_interrupt",O_RDWR);

	if(devI < 0) {
		printf("Device Open ERROR!\n");
		return -1;
	}

	for(i = 0; i<5; i++) {
		printf("Please push the button !\n");
		read(devI,buff,100);
		if(!strcmp(buff, "Up")) {
			printf("스위치 1번이 켜졌습니다\n\n",buff);
		}
		else if (!strcmp(buff, "Down")) {
			printf("스위치 2번이 켜졌습니다\n\n",buff);
		}
		else if (!strcmp(buff, "Left")) {
			printf("스위치 3번이 켜졌습니다\n\n",buff);
		}
		else if (!strcmp(buff, "Right")) {
			printf("스위치 4번이 켜졌습니다\n\n",buff);
		}
		else if (!strcmp(buff, "Center")) {
			printf("스위치 5번이 켜졌습니다\n\n",buff);
		}
	}

	close(devI);
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
