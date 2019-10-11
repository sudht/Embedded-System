package com.example.sm9m2stepmotor_test;

import com.hbe.jnidriver.JNIDriver;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;
import android.app.Activity;

public class MainActivity extends Activity {
	SegThread mSegThread;
	StpThread mStpThread;
	boolean mStart = true, flag = true;
	JNIDriver mStpDriver = new JNIDriver();
	TextView tv;
	int direction=0;
	int sleepTime = 10;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		Button btn1 = (Button)findViewById(R.id.button1);
		Button btn2 = (Button)findViewById(R.id.button2);
		Button btn3 = (Button)findViewById(R.id.button3);
		tv = (TextView) findViewById(R.id.textView1);

		btn1.setOnClickListener(new Button.OnClickListener(){
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				direction=1;
				mStart = true;
				if(sleepTime>5) sleepTime--;
				if (mStpThread == null) { 
					flag = true;
					mStpThread = new StpThread();
					mStpThread.start();
				}
				if(mSegThread == null) {
					mSegThread = new SegThread();
					mSegThread.start();
				}

			}
		});
		btn2.setOnClickListener(new Button.OnClickListener(){
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				direction=1;
				mStart = true;
				if(sleepTime<15) sleepTime++;
				if (mStpThread == null) { 
					flag = true;
					mStpThread = new StpThread();
					mStpThread.start();
				}
				if(mSegThread == null) {
					mSegThread = new SegThread();
					mSegThread.start();
				}
			}
		});
		btn3.setOnClickListener(new Button.OnClickListener(){
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				direction=0;
				sleepTime = 10;
				if (mStpThread != null) { 
					flag = false;
					mStpThread = null;
				}
			}
		});
	}
	@Override
	protected void onPause() {
		// TODO Auto-generated method stub
		mStpDriver.closeStp();
		mStpDriver.closeSeg();
		super.onPause();
	}

	@Override
	protected void onResume() {
		// TODO Auto-generated method stub

		if(mStpDriver.openSeg("/dev/sm9s5422_segment") < 0) {
			Toast.makeText(MainActivity.this, "Driver Open Failedb", Toast.LENGTH_SHORT).show();
		}
		if(mStpDriver.openStp("/dev/sm9s5422_step") < 0){
			Toast.makeText(MainActivity.this, "Driver Open Faileda", Toast.LENGTH_SHORT).show();
		}
		mSegThread = new SegThread();
		mSegThread.start();
		mStpThread = new StpThread();
		mStpThread.start();
		super.onResume();
	}

	public Handler handler = new Handler() {

		public void handleMessage(Message msg) {
			tv.setText(""+msg.arg1);
		}
	};

	private class StpThread extends Thread {
		@Override
		public void run() {
			super.run();
			while (mStart) {
				if(flag)
					mStpDriver.setMotor(direction, sleepTime);
			}
		}
	}


	private class SegThread extends Thread {
		@Override
		public void run() {
			super.run();
			byte[] n = { 0, 0, 0, 0, 0, 0 };
			while (mStart) {
				Message text = Message.obtain();
				text.arg1 = 15 - sleepTime;
				int count = text.arg1;
				n[0] = (byte) (count % 1000000 / 100000);
				n[1] = (byte) (count % 100000 / 10000);
				n[2] = (byte) (count % 10000 / 1000);
				n[3] = (byte) (count % 1000 / 100);
				n[4] = (byte) (count % 100 / 10);
				n[5] = (byte) (count % 10);
				handler.sendMessage(text);
				mStpDriver.write(n);
			}
		}
	}
}