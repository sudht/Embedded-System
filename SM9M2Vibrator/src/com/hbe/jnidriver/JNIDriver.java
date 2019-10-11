package com.hbe.jnidriver;

public class JNIDriver {

	private boolean mConnectFlag;
	static {
		System.loadLibrary("JNIDriver");
	}

	private native static int openDriver(String path);
	private native static void closeDriver();
	private native void setVib(char led);

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
	public void setVib(int val){
		if(!mConnectFlag) return;

		setVib((char)val);
	}

}