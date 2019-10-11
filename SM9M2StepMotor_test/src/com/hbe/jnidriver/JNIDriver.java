package com.hbe.jnidriver;

public class JNIDriver {

	private boolean mConnectStpFlag, mConnectSegFlag;

	static {
		System.loadLibrary("JNIDriver");
	}

	private native static int openDriverStp(String path);
	private native static int openDriverSeg(String path);
	private native static void closeDriverStp();
	private native static void closeDriverSeg();
	private native static void writeDriver(byte[] data, int length);
	private native static void setMotor(char led, char slp);

	public JNIDriver(){
		mConnectStpFlag = false;
		mConnectSegFlag = false;
	}
	public int openStp(String driver){
		if(mConnectStpFlag) return -1;

		if(openDriverStp(driver)>0){
			mConnectStpFlag = true;
			return 1;
		} else {
			return -1;
		}
	}
	public int openSeg(String driver){
		if(mConnectSegFlag) return -1;

		if(openDriverSeg(driver)>0){
			mConnectSegFlag = true;
			return 1;
		} else {
			return -1;
		}
	}
	public void closeStp(){
		if(!mConnectStpFlag) return;
		mConnectStpFlag = false;
		closeDriverStp();
	}
	public void closeSeg(){
		if(!mConnectSegFlag) return;
		mConnectSegFlag = false;
		closeDriverSeg();
	}

	protected void finalize() throws Throwable{
		closeStp();
		closeSeg();
		super.finalize();
	}

	public void write(byte[] data){
		if(!mConnectSegFlag) return;

		writeDriver(data, data.length);
	}

	public void setMotor(int val, int sleep){
		if(!mConnectStpFlag) return;

		setMotor((char)val, (char)sleep);
	}

}