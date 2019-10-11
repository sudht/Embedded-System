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
			printf("����ġ 1���� �������ϴ�\n\n",buff);
		}
		else if (!strcmp(buff, "Down")) {
			printf("����ġ 2���� �������ϴ�\n\n",buff);
		}
		else if (!strcmp(buff, "Left")) {
			printf("����ġ 3���� �������ϴ�\n\n",buff);
		}
		else if (!strcmp(buff, "Right")) {
			printf("����ġ 4���� �������ϴ�\n\n",buff);
		}
		else if (!strcmp(buff, "Center")) {
			printf("����ġ 5���� �������ϴ�\n\n",buff);
		}
	}

	close(devI);
	return 0;
}


char getKey()
{
	if(kbhit()) // kbhit()�̿��� �Է°��� �ִ��� Ȯ��
	{
		return getchar();    // �Է°��� getch()�� char�� ��������
	}
	return '\0'; // �Է°��� ������ �� ���� ����
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
