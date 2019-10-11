package com.example.final_test1;

import com.hbe.jnidriver.JNIDriver;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.Toast;
import android.app.Activity;
import android.graphics.Color;

public class MainActivity extends Activity {

	JNIDriver mDriver = new JNIDriver();
	boolean mThreadRun, mStart;
	int btnIndex;
	PiezoThread mPiezoThread;
	Button mBtnAirplane, mBtnLCD, mBtnLED;
	int airplane[] = {9, 7, 5, 7, 9, 9, 9, 7, 7, 7, 9, 9, 
			9, 9, 7, 5, 7, 9, 9, 9, 7, 7, 9, 7, 5};
	int value =0;
	byte[] data = {0,0,0,0,0,0,0,0};
	String text = "2019 Happy New Year !!!";

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		mBtnAirplane = (Button)findViewById(R.id.button4);
		mBtnLCD = (Button)findViewById(R.id.button2);
		mBtnLED = (Button)findViewById(R.id.button1);

		Button.OnClickListener listener= new OnClickListener() {
			@Override
			public void onClick(View v) {
				if(v==mBtnAirplane){
					btnIndex = 1;
					mStart = true;
				}
				else if(v==mBtnLCD){
					mDriver.setText(1, text);
					mDriver.setDisplayVisible(true);
				}
				else if(v==mBtnLED){
					for(int i=0; i<10; i++) {
						for(int j=0; j<10; j = j+2) {
							data[j] = (byte) (data[j] + (i%2)) ;
						}
						mDriver.write(data);
						try {
							Thread.sleep(100);
						} catch (InterruptedException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}
			}
		};

		mPiezoThread = new PiezoThread();
		mPiezoThread.start();
		mBtnAirplane.setOnClickListener(listener);
		mBtnLCD.setOnClickListener(listener);
		mBtnLED.setOnClickListener(listener);
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
		if(mDriver.open("/dev/sm9s5422_piezo")<0){
			Toast.makeText(MainActivity.this, "Driver Open Failed",
					Toast.LENGTH_SHORT).show();
		}
		if(mDriver.openLCD("/dev/sm9s5422_textlcd")<0){
			Toast.makeText(MainActivity.this, "Driver Open Failed", Toast.LENGTH_SHORT).show();
		}
		if(mDriver.openLED("/dev/sm9s5422_led")<0){
			Toast.makeText(MainActivity.this, "Driver Open Failed", Toast.LENGTH_SHORT).show();
		}
		mThreadRun = true;
		mPiezoThread = new PiezoThread();
		mPiezoThread.start();
		super.onResume();
	}

	private class PiezoThread extends Thread {
		@Override
		public void run() {
			super.run();
			while (mThreadRun) {

				if (mStart == false) {
					;
				} else {
					if(btnIndex == 1) {
						for(int i=0; i<25; i++) {
							if(btnIndex != 1) break;
							mDriver.setBuzzer(airplane[i]);
						}
						mStart = false;

					}
				}
			}
		}
	}
}