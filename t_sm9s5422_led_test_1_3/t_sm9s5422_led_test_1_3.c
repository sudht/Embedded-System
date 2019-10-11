#include <stdio.h>
#include <termios.h>
#include <unistd.h>
#include <fcntl.h>

char getKey();
int kbhit(void);

int main(void)
{
	char key;
	while(1)
	{
		key = getKey();
		if(key == '+') // 입력값을 읽었다면 읽은 값을 출력
			printf("%c", key);
		else if(key == '-')
			;
	}
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
