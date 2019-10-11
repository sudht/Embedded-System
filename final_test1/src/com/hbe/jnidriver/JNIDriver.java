package com.hbe.jnidriver;

public class JNIDriver {

	private boolean mConnectFlag;
	private boolean mConnectFlagLED;
	private boolean mConnectFlagLCD;
//	private boolean mConnectFlagVibrator;
//	private boolean mConnectFlagPiezo;
	static {
		System.loadLibrary("JNIDriver");
	}

	private native static int openDriver(String path);
	private native static int openDriverLED(String path);
	private native static int openDriverLCD(String path);
//	private native static int openDriverVibrator(String path);
//	private native static int openDriverPiezo(String path);
	private native static void closeDriver();
//	private native void setVib(char led);
	private native static void writeDriver(byte[] data, int length);
	private native static void displayOn();
	private native static void displayOff();
	private native static void displayClear();
	private native static void cursorOn();
	private native static void cursorOff();
	private native static void cursorLeft();
	private native static void cursorRight();
	private native static void cursorHome();
	private native static void writeLine1(String str, int len);
	private native static void writeLine2(String str, int len);
	private native void setBuzzer(char led);

	public JNIDriver(){
		mConnectFlag = false;
//		mConnectFlagLED = false;
		mConnectFlagLCD = false;
//		mConnectFlagVibrator = false;
//		mConnectFlagPiezo = false;
	}
	public int open(String driver){
		if(mConnectFlag) return -1;

		if(openDriver(driver) > 0){
			mConnectFlag = true;
			return 1;
		} else {
			return -1;
		}

	}
	
	public int openLED(String driver){
		if(mConnectFlagLED) return -1;

		if(openDriverLED(driver) > 0){
			mConnectFlagLED = true;
			return 1;
		} else {
			return -1;
		}

	}
	
	public int openLCD(String driver){
		if(mConnectFlagLCD) return -1;

		if(openDriverLCD(driver) > 0){
			mConnectFlagLCD = true;
			return 1;
		} else {
			return -1;
		}

	}
	public void close(){
		mConnectFlag = false;
//		mConnectFlagLED = false;
		mConnectFlagLCD = false;
//		mConnectFlagVibrator = false;
//		mConnectFlagPiezo = false;
		closeDriver();
	}
	protected void finalize() throws Throwable{
		close();
		super.finalize();
	}
	public void setBuzzer(int val){
		if(!mConnectFlag) return;
		if(val<1) val = 1;
		if(val>22) val = 22;
		setBuzzer((char)val);
	}
	
	public void write(byte[] data){
		if(!mConnectFlagLED) return;

		writeDriver(data, data.length);
	}
	
	public void setDisplayVisible(boolean b){
		if(b) displayOn();
		else displayOff();
	}

	public void clearDisplay(){
		displayClear();
	}
	public void setCursorVisible(boolean b){
		if(b) cursorOn();
		else cursorOff();
	}

	public void setCursorLeft(){
		cursorLeft();
	}

	public void setCursorRight(){
		cursorRight();
	}

	public void setCursorHome(){
		cursorHome();
	}

	public void setText(int num, String str){
		if(num==1) writeLine1(str, str.length());
		else if(num==2) writeLine2(str, str.length());
	}

}