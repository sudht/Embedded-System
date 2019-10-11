package com.hbe.jnidriver;

public class JNIDriver {

	private boolean mConnectSegFlag;
	private boolean mConnectFlag;
	private TranseThread mTranseThread;
	private JNIListener mMainActivity;
	
	static {
		System.loadLibrary("JNIDriver");
	}

	private native static int openDriverSeg(String path);
	private native static int openDriverInter(String path);
	private native static void closeDriverSeg();
	private native static void closeDriver();
	private native char readDriver();
	private native int getInterrupt();
	private native static void writeDriver(byte[] data, int length);

	public JNIDriver(){
		mConnectSegFlag = false;
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
	public int openSeg(String driver){
		if(mConnectSegFlag) return -1;

		if(openDriverSeg(driver) > 0){
			mConnectSegFlag = true;
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
	public void closeSeg(){
		if(!mConnectSegFlag) return;
		mConnectSegFlag = false;
		closeDriverSeg();
	}
	public void closeInter(){
		if(!mConnectFlag) return;
		mConnectFlag = false;
		closeDriver();
	}
	protected void finalize() throws Throwable{
		closeSeg();
		closeInter();
		super.finalize();
	}
	
	public void write(byte[] data){
		if(!mConnectSegFlag) return;

		writeDriver(data, data.length);
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