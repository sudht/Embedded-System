#include <jni.h>
#include <fcntl.h>

int fd = 0; // file descriptor

JNIEXPORT jint JNICALL Java_com_hbe_jnidriver_JNIDriver_openDriver(JNIEnv * env, jclass class, jstring path) {
	jboolean iscopy;
	const char *path_utf = (*env)->GetStringUTFChars(env, path, &iscopy);
	fd = open(path_utf, O_RDONLY);
	(*env)->ReleaseStringUTFChars(env, path, path_utf);

	if (fd < 0)
		return -1;
	else
		return 1;
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
