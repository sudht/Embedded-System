#include <jni.h>
#include <fcntl.h>

int fd = 0;

JNIEXPORT jint JNICALL Java_com_hbe_jnidriver_JNIDriver_openDriver(JNIEnv * env, jclass class, jstring path){
	jboolean iscopy;
	const char *path_utf = (*env)->GetStringUTFChars(env, path, &iscopy);
	fd = open(path_utf,O_WRONLY);
	(*env)->ReleaseStringUTFChars(env, path, path_utf);

	if(fd < 0) return -1;
	else return 1;
}

JNIEXPORT void JNICALL Java_com_hbe_jnidriver_JNIDriver_closeDriver(JNIEnv * env, jobject obj){
	if(fd>0) close(fd);
}

JNIEXPORT void JNICALL Java_com_hbe_jnidriver_JNIDriver_setBuzzer(JNIEnv *env, jobject o, jchar c){
	int i=(int)c;
	write(fd, &i, sizeof(i));
}
