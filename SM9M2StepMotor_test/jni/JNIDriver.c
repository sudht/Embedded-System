#include <jni.h>
#include <fcntl.h>

int fdStp = 0;
int fdSeg = 0;

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

JNIEXPORT jint JNICALL Java_com_hbe_jnidriver_JNIDriver_openDriverSeg (JNIEnv * env, jclass class, jstring path) {
	jboolean iscopy;
		const char *path_utf = (*env)->GetStringUTFChars(env, path, &iscopy);
		fdSeg = open(path_utf, O_WRONLY);
		(*env)->ReleaseStringUTFChars(env, path, path_utf);

		if (fdSeg < 0)
			return -1;
		else
			return 1;
}

JNIEXPORT void JNICALL Java_com_hbe_jnidriver_JNIDriver_closeDriverStp(JNIEnv * env, jobject obj) {
	if(fdStp>0) close(fdStp);
}

JNIEXPORT void JNICALL Java_com_hbe_jnidriver_JNIDriver_closeDriverSeg(JNIEnv * env, jobject obj) {
	if(fdSeg>0) close(fdSeg);
}

JNIEXPORT void JNICALL Java_com_hbe_jnidriver_JNIDriver_writeDriver(JNIEnv * env, jobject obj, jbyteArray arr, jint count){
	jbyte* chars = (*env)->GetByteArrayElements(env, arr, 0);
	if(fdSeg>0) write(fdSeg, (unsigned char*)chars, count);
	(*env)->ReleaseByteArrayElements(env, arr, chars, 0);
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

