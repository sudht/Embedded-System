package com.hbe.jnidriver;

public class JNIDriver {

	private boolean mConnectStpFlag;
	private boolean mConnectFlag;
	private TranseThread mTranseThread;
	private JNIListener mMainActivity;

	static {
		System.loadLibrary("JNIDriver");
	}

	private native static int openDriverStp(String path);
	private native static int openDriverInter(String path);
	private native static void closeDriverStp();
	private native static void closeDriverInter();
	private native char readDriver();
	private native int getInterrupt();
	private native static void setMotor(char led, char slp);

	public JNIDriver(){
		mConnectStpFlag = false;
		mConnectFlag = false;
	}
	public void onReceive(int val) {

		if(mMainActivity!=null){
			mMainActivity.onReceive(val);
		}
	}
	public void setListener(JNIListener a){
		mMainActivity = a;
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
	public int openInter(String driver){
		if(mConnectFlag) return -1;

		if(openDriverInter(driver)>0){
			mConnectFlag = true;
			mTranseThread = new TranseThread();
			mTranseThread.start();
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
	public void closeInter(){
		if(!mConnectFlag) return;
		mConnectFlag = false;
		closeDriverInter();
	}

	protected void finalize() throws Throwable{
		closeStp();
		closeInter();
		super.finalize();
	}

	public void setMotor(int val, int sleep){
		if(!mConnectStpFlag) return;

		setMotor((char)val, (char)sleep);
	}
	public char read(){
		return readDriver();
	}
	private class TranseThread extends Thread {

		@Override
		public void run() {
			super.run();
			try {
				while(mConnectFlag){
					try {
						onReceive(getInterrupt());
						Thread.sleep(100);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}catch(Exception e){

			}
		}
	}

}