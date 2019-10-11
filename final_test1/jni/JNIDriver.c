#include <jni.h>
#include <fcntl.h>
#include <sys/ioctl.h>

#define TEXTLCD_BASE 0x56
#define TEXTLCD_FUNCTION_SET _IO(TEXTLCD_BASE,0x31)

#define TEXTLCD_DISPLAY_ON _IO(TEXTLCD_BASE,0x32)
#define TEXTLCD_DISPLAY_OFF _IO(TEXTLCD_BASE,0x33)
#define TEXTLCD_DISPLAY_CURSOR_ON _IO(TEXTLCD_BASE,0x34)
#define TEXTLCD_DISPLAY_CURSOR_OFF _IO(TEXTLCD_BASE,0x35)

#define TEXTLCD_CURSOR_SHIFT_RIGHT _IO(TEXTLCD_BASE,0x36)
#define TEXTLCD_CURSOR_SHIFT_LEFT _IO(TEXTLCD_BASE,0x37)

#define TEXTLCD_ENTRY_MODE_SET _IO(TEXTLCD_BASE,0x38)
#define TEXTLCD_RETURN_HOME _IO(TEXTLCD_BASE,0x39)
#define TEXTLCD_CLEAR _IO(TEXTLCD_BASE,0x3a)

#define TEXTLCD_DD_ADDRESS_1 _IO(TEXTLCD_BASE,0x3b)
#define TEXTLCD_DD_ADDRESS_2 _IO(TEXTLCD_BASE,0x3c)
#define TEXTLCD_WRITE_BYTE _IO(TEXTLCD_BASE,0x3d)

int fd = 0;
int fdLCD = 0;
int fdLED = 0;

JNIEXPORT jint JNICALL Java_com_hbe_jnidriver_JNIDriver_openDriver(JNIEnv * env, jclass class, jstring path){
	jboolean iscopy;
	const char *path_utf = (*env)->GetStringUTFChars(env, path, &iscopy);
	fd = open(path_utf,O_WRONLY);
	(*env)->ReleaseStringUTFChars(env, path, path_utf);

	if(fd < 0) return -1;
	else return 1;
}

JNIEXPORT jint JNICALL Java_com_hbe_jnidriver_JNIDriver_openDriverLCD(JNIEnv * env, jclass class, jstring path){
	jboolean iscopy;
	const char *path_utf = (*env)->GetStringUTFChars(env, path, &iscopy);
	fdLCD = open(path_utf,O_WRONLY);
	(*env)->ReleaseStringUTFChars(env, path, path_utf);

	if(fdLCD < 0) return -1;
	else return 1;
}

JNIEXPORT jint JNICALL Java_com_hbe_jnidriver_JNIDriver_openDriverLED(JNIEnv * env, jclass class, jstring path){
	jboolean iscopy;
	const char *path_utf = (*env)->GetStringUTFChars(env, path, &iscopy);
	fdLED = open(path_utf,O_WRONLY);
	(*env)->ReleaseStringUTFChars(env, path, path_utf);

	if(fdLED < 0) return -1;
	else return 1;
}

JNIEXPORT void JNICALL Java_com_hbe_jnidriver_JNIDriver_closeDriver(JNIEnv * env, jobject obj){
	if(fd>0) close(fd);
}

JNIEXPORT void JNICALL Java_com_hbe_jnidriver_JNIDriver_writeDriver(JNIEnv * env, jobject obj, jbyteArray arr, jint count){
	jbyte* chars = (*env)->GetByteArrayElements(env, arr, 0);
	if(fdLED>0) write(fdLED, (unsigned char*)chars, count);
	(*env)->ReleaseByteArrayElements(env, arr, chars, 0);
}

JNIEXPORT void JNICALL Java_com_hbe_jnidriver_JNIDriver_setBuzzer(JNIEnv *env, jobject o, jchar c){
	int i=(int)c;
	write(fd, &i, sizeof(i));
}

JNIEXPORT void JNICALL Java_com_hbe_jnidriver_JNIDriver_displayOn(JNIEnv * env, jclass class){
	ioctl(fdLCD, TEXTLCD_DISPLAY_ON,NULL);
}
JNIEXPORT void JNICALL Java_com_hbe_jnidriver_JNIDriver_displayOff(JNIEnv * env, jclass class){
	ioctl(fdLCD, TEXTLCD_DISPLAY_OFF,NULL);
}

JNIEXPORT void JNICALL Java_com_hbe_jnidriver_JNIDriver_displayClear(JNIEnv * env, jclass class){
	ioctl(fdLCD, TEXTLCD_CLEAR, NULL);
}
JNIEXPORT void JNICALL Java_com_hbe_jnidriver_JNIDriver_cursorOn(JNIEnv * env, jclass class){
	ioctl(fdLCD, TEXTLCD_DISPLAY_CURSOR_ON,NULL);
}

JNIEXPORT void JNICALL Java_com_hbe_jnidriver_JNIDriver_cursorOff(JNIEnv * env, jclass class){
	ioctl(fdLCD, TEXTLCD_DISPLAY_CURSOR_OFF,NULL);
}

JNIEXPORT void JNICALL Java_com_hbe_jnidriver_JNIDriver_cursorLeft(JNIEnv * env, jclass class){
	ioctl(fdLCD, TEXTLCD_CURSOR_SHIFT_LEFT, NULL);
}

JNIEXPORT void JNICALL Java_com_hbe_jnidriver_JNIDriver_cursorRight(JNIEnv * env, jclass class){
	ioctl(fdLCD, TEXTLCD_CURSOR_SHIFT_RIGHT, NULL);
}

JNIEXPORT void JNICALL Java_com_hbe_jnidriver_JNIDriver_cursorHome(JNIEnv * env, jclass class){
	ioctl(fdLCD, TEXTLCD_RETURN_HOME, NULL);
}

JNIEXPORT void JNICALL Java_com_hbe_jnidriver_JNIDriver_writeLine1(JNIEnv * env, jclass class, jstring str, jint len){
	jboolean iscopy;
	int i=0;
	const char *str_utf = (*env)->GetStringUTFChars(env, str, &iscopy);

	ioctl(fdLCD, TEXTLCD_DD_ADDRESS_1, NULL);
	for(i=0; i<len; i++)
		ioctl(fdLCD, TEXTLCD_WRITE_BYTE,str_utf[i]);

	(*env)->ReleaseStringUTFChars(env, str, str_utf);
}

JNIEXPORT void JNICALL Java_com_hbe_jnidriver_JNIDriver_writeLine2(JNIEnv * env, jclass class, jstring str, jint len){
	jboolean iscopy;
	int i=0;
	const char *str_utf = (*env)->GetStringUTFChars(env, str, &iscopy);

	ioctl(fdLCD, TEXTLCD_DD_ADDRESS_2, NULL);
	for(i=0; i<len; i++)
		ioctl(fdLCD, TEXTLCD_WRITE_BYTE,str_utf[i]);

	(*env)->ReleaseStringUTFChars(env, str, str_utf);
}
