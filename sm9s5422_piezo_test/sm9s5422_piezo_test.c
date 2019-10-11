#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>


int main(int argc, char * argv[]) {
	int dev,i,flag=1, j;
	int airplane[] = {5, 3, 1, 3, 5, 5, 5, 3, 3, 3, 5,
			5, 5, 5, 3, 1 ,3 ,5 ,5 ,5 ,3 ,3 ,5 ,3 ,1};
	int rabbit[] = {7, 4, 4, 7, 4, 0, 2, 4, 2, 0, 4, 7,
			12, 7, 12, 7, 12, 7, 4, 7, 2, 5, 4, 2, 0};
	int littlestar[] = {0, 0, 7, 7, 9, 9, 7, 5, 5, 4, 4, 2, 2,
			0, 7, 7, 5, 5, 4, 4, 2, 7, 7, 5, 5, 4, 4, 2,
			0, 0, 7, 7, 9, 9, 7, 5, 5, 4, 4, 2, 2, 0};
	int school[] = {7, 7, 9, 9, 7, 7, 4, 7, 7, 4, 4, 2,
			7, 7, 9, 9, 7, 7, 4, 7, 4, 2, 4, 0};

	dev = open("/dev/sm9s5422_piezo", O_WRONLY);

	while(flag)
	{

		printf("input number(1~4, exit=100): ");
		scanf("%d",&i);

		/*
		if(i==1) {
			for(j=0; j<25; j++) {
				write(dev,&airplane[j],sizeof(i));
			}
		}
		else if(i==2) {
			for(j=0; j<25; j++) {
				write(dev,&rabbit[j],sizeof(i));
			}
		}
		else if(i==3) {
			for(j=0; j<42; j++) {
				write(dev,&littlestar[j],sizeof(i));
			}
		}
		else if(i==4) {
			for(j=0; j<24; j++) {
				write(dev,&school[j],sizeof(i));
			}
		}
		*/

		if(i>=0 && i<23)
			write(dev,&i,sizeof(i));
		else if(i==100)
			flag=0;
		 /*
		else
			printf("wrong number\n");*/
	}

	close(dev);

	return 0;
}
