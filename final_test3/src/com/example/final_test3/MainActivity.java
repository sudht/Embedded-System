package com.example.final_test3;

import com.hbe.jnidriver.JNIDriver;
import com.hbe.jnidriver.JNIListener;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;
import android.app.Activity;

public class MainActivity extends Activity implements JNIListener {
	StpThread mStpThread;
	boolean mStart = true, flag = true;
	JNIDriver mStpDriver = new JNIDriver();
	TextView tv;
	int direction=0;
	int sleepTime = 15;
	int num = 1;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		Button btn1 = (Button)findViewById(R.id.button1);
		// Button btn2 = (Button)findViewById(R.id.button2);
		Button btn3 = (Button)findViewById(R.id.button3);
		tv = (TextView) findViewById(R.id.textView1);
		mStpDriver.setListener(this);
		tv.setText("" + num);
		btn1.setOnClickListener(new Button.OnClickListener(){
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				direction=1;
				mStart = true;
				sleepTime = 15;
				sleepTime = sleepTime - num;
				// if(sleepTime>5) sleepTime--;
				if (mStpThread == null) { 
					flag = true;
					mStpThread = new StpThread();
					mStpThread.start();
				}

			}
		});
		btn3.setOnClickListener(new Button.OnClickListener(){
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				direction=0;
				// sleepTime = 10;
				num = 1;
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
		mStpDriver.closeInter();
		super.onPause();
	}

	@Override
	protected void onResume() {
		// TODO Auto-generated method stub

		if(mStpDriver.openStp("/dev/sm9s5422_step") < 0){
			Toast.makeText(MainActivity.this, "Driver Open Faileda", Toast.LENGTH_SHORT).show();
		}
		if(mStpDriver.openInter("/dev/sm9s5422_interrupt") < 0) {
			Toast.makeText(MainActivity.this, "Driver Open Failed",
					Toast.LENGTH_SHORT).show();
		}
		mStpThread = new StpThread();
		mStpThread.start();
		super.onResume();
	}

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

	public Handler handler = new Handler() {


		public void handleMessage(Message msg) {
			switch (msg.arg1) {

			case 1:		// Up
				num++;
				break;
			}
			tv.setText("" + num);
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
