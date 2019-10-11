package com.example.sm9m2stepmotor;

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
	ReceiveThread mSegThread;
	StepThread mStpThread;
	boolean mThreadRun = true, mStart;
	JNIDriver mDriver = new JNIDriver();
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
				if (mSegThread == null) { 
					mSegThread = new ReceiveThread();
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
				if (mSegThread == null) {
					mSegThread = new ReceiveThread();
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
				if (mSegThread != null) {
					mSegThread = null;

				}
				mDriver.setMotor(0, 0);
			}
		});
	}
	private class ReceiveThread extends Thread {
		@Override
		public void run() {
			super.run();
			while (mThreadRun) {

				mDriver.setMotor(direction, sleepTime);

			}
		}
	}
	@Override
	protected void onPause() {
		// TODO Auto-generated method stub
		mDriver.close();
		super.onPause();
	}

	@Override
	protected void onResume() {
		// TODO Auto-generated method stub
		if(mDriver.open("/dev/sm9s5422_step")<0){
			Toast.makeText(MainActivity.this, "Driver Open Failed", Toast.LENGTH_SHORT).show();
		}
		mStpThread = new StepThread();
		mStpThread.start();
		super.onResume();
	}
	
	public Handler handler = new Handler() {

		public void handleMessage(Message msg) {
			tv.setText(""+msg.arg1);
		}
	};
	
	private class StepThread extends Thread {
		@Override
		public void run() {
			super.run();
			while (mThreadRun) {
				if (mStart == false) {
					;
				} else {
					Message text = Message.obtain();
					text.arg1 = 15 - sleepTime;
					handler.sendMessage(text);
				}
			}
		}
	}

}