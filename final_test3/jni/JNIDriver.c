#include <jni.h>
#include <fcntl.h>

int fdStp = 0;
int fd = 0;

JNIEXPORT jint JNICALL Java_com_hbe_jnidriver_JNIDriver_openDriverStp(JNIEnv * env, jclass class, jstring path) {
	jboolean iscopy;
	const char *path_utf = (*env)->GetStringUTFChars(env, path, &iscopy);
	fdStp = open(path_utf, O_WRONLY);
	(*env)->ReleaseStringUTFChars(env, path, path_utf);

	if (fdStp < 0)
		return -1;
	else
		return 1;
}

JNIEXPORT jint JNICALL Java_com_hbe_jnidriver_JNIDriver_openDriverInter (JNIEnv * env, jclass class, jstring path) {
	jboolean iscopy;
	const char *path_utf = (*env)->GetStringUTFChars(env, path, &iscopy);
	fd = open(path_utf, O_RDONLY);
	(*env)->ReleaseStringUTFChars(env, path, path_utf);

	if (fd < 0)
		return -1;
	else
		return 1;
}

JNIEXPORT void JNICALL Java_com_hbe_jnidriver_JNIDriver_closeDriverStp(JNIEnv * env, jobject obj) {
	if(fdStp>0) close(fdStp);
}

JNIEXPORT void JNICALL Java_com_hbe_jnidriver_JNIDriver_closeDriver(JNIEnv * env, jobject obj) {
	if(fd>0) close(fd);
}

JNIEXPORT jchar JNICALL Java_com_hbe_jnidriver_JNIDriver_readDriver(
		JNIEnv * env, jobject obj) {
	char ch = 0;

	if (fd > 0) {
		read(fd, &ch, 1);
	}

	return ch;
}

JNIEXPORT jint JNICALL Java_com_hbe_jnidriver_JNIDriver_getInterrupt(JNIEnv * env, jobject o) {

	int ret = 0;
	char value[100];
	char* ch1 = "Up";
	char* ch2 = "Down";
	char* ch3 = "Left";
	char* ch4 = "Right";
	char* ch5 = "Center";
	ret = read(fd, &value, 100);
	if (ret < 0)
		return -1;
	else {
		if(strcmp(ch1, value) ==0)
			return 1;
		else if(strcmp(ch2, value) ==0)
			return 2;
		else if(strcmp(ch3, value) ==0)
			return 3;
		else if(strcmp(ch4, value) ==0)
			return 4;
		else if(strcmp(ch5, value) ==0)
			return 5;
	}
}

JNIEXPORT void JNICALL Java_com_hbe_jnidriver_JNIDriver_setMotor(JNIEnv *env, jobject o, jchar c, jchar s) {
	int i=(int)c;
	int sleepT = (int)s;
	sleepT = sleepT * 1000;

	//write(fd, &i, sizeof(i));
	char temp[4]= {1,1,1,1};
	if(i==0)
		write(fdStp,temp,4);
	else if(i==1)
	{
		temp[0] = 0;
		write(fdStp,temp,4);
		usleep(sleepT);
		temp[0] = 1;
		temp[1] = 0;
		write(fdStp,temp,4);
		usleep(sleepT);
		temp[1] = 1;
		temp[2] = 0;
		write(fdStp,temp,4);
		usleep(sleepT);
		temp[2] =1;
		temp[3] = 0;
		write(fdStp,temp,4);
		usleep(sleepT);
		temp[3] = 1;
	}
	else if(i==2){
		temp[3] = 0;
		write(fdStp,temp,4);
		usleep(sleepT);
		temp[3] = 1;
		temp[2] = 0;
		write(fdStp,temp,4);
		usleep(sleepT);
		temp[2] = 1;
		temp[1] = 0;
		write(fdStp,temp,4);
		usleep(sleepT);
		temp[1] = 1;
		temp[0] = 0;
		write(fdStp,temp,4);
		usleep(sleepT);
		temp[0] = 1;

	}
}

