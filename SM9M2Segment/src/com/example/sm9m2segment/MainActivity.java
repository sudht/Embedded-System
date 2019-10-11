package com.example.sm9m2segment;

import com.hbe.jnidriver.JNIDriver;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.app.Activity;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;

public class MainActivity extends Activity {

	JNIDriver mDriver = new JNIDriver();
	ToggleButton mBtn1, mBtn2, mBtn3, mBtn4;
	TextView tv;
	boolean mStart, mThreadRun;
	SegmentThread mSegThread;
	TimerThread mTimeThread;
	// TextThread mTxtThread;

	int mCurCount, countToZero;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		Button btn = (Button) findViewById(R.id.button1);
		Button btn2 = (Button) findViewById(R.id.button2);
		tv = (TextView) findViewById(R.id.textView1);

		btn.setOnClickListener(new Button.OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				String str = ((EditText) findViewById(R.id.editText1))
						.getText().toString();
				try {
					countToZero = 0;
					mCurCount = Integer.parseInt(str);
					mStart = true;

				} catch (NumberFormatException e) {
					Toast.makeText(MainActivity.this, "Input Error",
							Toast.LENGTH_SHORT).show();
				}
			}

		});

		btn2.setOnClickListener(new Button.OnClickListener() {

			@Override
			public void onClick(View v) {
				mStart = false;
				//tv.setText(Integer.toString(countToZero));
			}

		});
		mTimeThread = new TimerThread();
		mTimeThread.start();
		mSegThread = new SegmentThread();
		mSegThread.start();
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
		if (mDriver.open("/dev/sm9s5422_segment") < 0) {
			Toast.makeText(MainActivity.this, "Driver Open Failed",
					Toast.LENGTH_SHORT).show();
		}
		mThreadRun = true;
		mTimeThread = new TimerThread();
		mTimeThread.start();
		mSegThread = new SegmentThread();
		mSegThread.start();
		// mTxtThread = new TextThread();
		// mTxtThread.start();
		super.onResume();
	}

	public Handler handler = new Handler() {

		public void handleMessage(Message msg) {
			tv.setText(""+msg.arg1);
		}
	};

	private class TimerThread extends Thread {
		@Override
		public void run() {
			super.run();
			while (mThreadRun) {
				try {
					if (mStart == false)
						continue;
					if (countToZero >= mCurCount) {
						mStart = false;
						mCurCount = 0;
					}
					else {
						countToZero++;
					}
					Thread.sleep(1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
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

				if (mStart == false) {
					mDriver.write(n);
				} else {
					n[0] = (byte) (countToZero % 1000000 / 100000);
					n[1] = (byte) (countToZero % 100000 / 10000);
					n[2] = (byte) (countToZero % 10000 / 1000);
					n[3] = (byte) (countToZero % 1000 / 100);
					n[4] = (byte) (countToZero % 100 / 10);
					n[5] = (byte) (countToZero % 10);
					mDriver.write(n);
					Message text = Message.obtain();
					text.arg1 = countToZero;
					handler.sendMessage(text);
				}
			}
		}
	}
	/*
	private class TextThread extends Thread {
		@Override
		public void run() {
			super.run();
			while (mThreadRun) {
				if(countToZero != 0) {
					tv.setText(""+countToZero);
				}
			}
		}
	}
	*/
}