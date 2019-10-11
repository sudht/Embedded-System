package com.example.final_test2;

import com.hbe.jnidriver.JNIDriver;
import com.hbe.jnidriver.JNIListener;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.widget.TextView;
import android.widget.Toast;
import android.app.Activity;


public class MainActivity extends Activity implements JNIListener {

	boolean mStart, mThreadRun, countFlag = false;
	SegmentThread mSegThread;
	TimerThread mTimeThread;
	int countToZero = 0;
	JNIDriver mStpDriver = new JNIDriver();
	TextView tv;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		tv = (TextView) findViewById(R.id.textView1);
		mStpDriver.setListener(this);

		mTimeThread = new TimerThread();
		mTimeThread.start();
		mSegThread = new SegmentThread();
		mSegThread.start();
	}
	@Override
	protected void onPause() {
		// TODO Auto-generated method stub
		mStpDriver.closeSeg();
		mStpDriver.closeInter();
		super.onPause();
	}

	@Override
	protected void onResume() {
		// TODO Auto-generated method stub

		if (mStpDriver.openSeg("/dev/sm9s5422_segment") < 0) {
			Toast.makeText(MainActivity.this, "Driver Open Faileda", Toast.LENGTH_SHORT).show();
		}
		if(mStpDriver.openInter("/dev/sm9s5422_interrupt") < 0) {
			Toast.makeText(MainActivity.this, "Driver Open Failed",
					Toast.LENGTH_SHORT).show();
		}
		mThreadRun = true;
		mTimeThread = new TimerThread();
		mTimeThread.start();
		mSegThread = new SegmentThread();
		mSegThread.start();
		super.onResume();
	}

	private class TimerThread extends Thread {
		@Override
		public void run() {
			super.run();
			while (mThreadRun) {
				if(countFlag) {
					try {
						countToZero++;
						Thread.sleep(1000);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
	private class SegmentThread extends Thread {
		@Override
		public void run() {
			super.run();
			byte[] n = { 0, 0, 0, 0, 0, 0, 0 };
			while (mThreadRun) {
				n[0] = (byte) (countToZero % 1000000 / 100000);
				n[1] = (byte) (countToZero % 100000 / 10000);
				n[2] = (byte) (countToZero % 10000 / 1000);
				n[3] = (byte) (countToZero % 1000 / 100);
				n[4] = (byte) (countToZero % 100 / 10);
				n[5] = (byte) (countToZero % 10);
				mStpDriver.write(n);
				Message text = Message.obtain();
				text.arg1 = 100;
				handler.sendMessage(text);
				
			}
		}
	}

	public Handler handler = new Handler() {


		public void handleMessage(Message msg) {
			switch (msg.arg1) {

			case 1:		// Up
				countFlag = true;
				break;
			case 2:		// Down
				countFlag = false;
				break;
			case 100:
				tv.setText(""+countToZero);
				break;
			}
		}
	};
	
	@Override
	public void onReceive(int val) {
		// TODO Auto-generated method stub
		Message text = Message.obtain();
		text.arg1 = val;
		handler.sendMessage(text);
	}
	
}
