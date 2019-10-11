package com.hbe.jnidriver;

public class JNIDriver {

	private boolean mConnectFlag;

	static {
		System.loadLibrary("JNIDriver");
	}

	private native static int openDriver(String path);
	private native static void closeDriver();
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
	public JNIDriver(){
		mConnectFlag = false;
	}
	public int open(String driver){
		if(mConnectFlag) return -1;

		if(openDriver(driver)>0){
			mConnectFlag = true;
			return 1;
		} else {
			return -1;
		}

	}
	public void close(){
		if(!mConnectFlag) return;
		mConnectFlag = false;
		closeDriver();
	}

	protected void finalize() throws Throwable{
		close();
		super.finalize();
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