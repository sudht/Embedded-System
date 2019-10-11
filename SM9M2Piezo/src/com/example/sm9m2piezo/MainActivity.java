package com.example.sm9m2piezo;

import com.hbe.jnidriver.JNIDriver;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.RadioButton;
import android.widget.Toast;
import android.app.Activity;
import android.graphics.Color;

public class MainActivity extends Activity {

	JNIDriver mDriver = new JNIDriver();
	boolean mThreadRun, mStart;
	int btnIndex;
	PiezoThread mPiezoThread;
	Button mBtnAirplane, mBtnRabbit, mBtnLittleStar, mBtnSchool;
	Button[] mBtnList  = new Button[13];

	int airplane[] = {9, 7, 5, 7, 9, 9, 9, 7, 7, 7, 9, 9, 
			9, 9, 7, 5, 7, 9, 9, 9, 7, 7, 9, 7, 5};
	int rabbit[] = {7, 4, 4, 7, 4, 0, 2, 4, 2, 0, 4, 7, 
			12, 7, 12, 7, 12, 7, 4, 7, 2, 5, 4, 2, 0};
	int littlestar[] = {0, 0, 7, 7, 9, 9, 7, 5, 5, 4, 4, 
			2, 2, 0, 7, 7, 5, 5, 4, 4, 2, 7, 7, 5, 5, 4, 4, 2, 
			0, 0, 7, 7, 9, 9, 7, 5, 5, 4, 4, 2, 2, 0};
	int school[] = {7, 7, 9, 9, 7, 7, 4, 7, 7, 4, 4, 2, 
			7, 7, 9, 9, 7, 7, 4, 7, 4, 2, 4, 0};
	
	int value =0;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		mBtnAirplane = (Button)findViewById(R.id.button1);
		mBtnRabbit = (Button)findViewById(R.id.button2);
		mBtnLittleStar = (Button)findViewById(R.id.button3);
		mBtnSchool = (Button)findViewById(R.id.button4);
		mBtnList[0] = (Button)findViewById(R.id.button00);
		mBtnList[2] = (Button)findViewById(R.id.button02);
		mBtnList[4] = (Button)findViewById(R.id.button04);
		mBtnList[5] = (Button)findViewById(R.id.button05);
		mBtnList[7] = (Button)findViewById(R.id.button07);
		mBtnList[9] = (Button)findViewById(R.id.button09);
		mBtnList[11] = (Button)findViewById(R.id.button11);
		mBtnList[12] = (Button)findViewById(R.id.button12);

		Button.OnClickListener listener= new OnClickListener() {
			@Override
			public void onClick(View v) {
				if(v==mBtnAirplane){
					btnIndex = 1;
					mStart = true;
				}
				else if (v==mBtnRabbit){
					btnIndex = 2;
					mStart = true;
				}
				else if (v==mBtnLittleStar){
					btnIndex = 3;
					mStart = true;
				}
				else if (v==mBtnSchool){
					btnIndex = 4;
					mStart = true;
				}
			}
		};

		mPiezoThread = new PiezoThread();
		mPiezoThread.start();
		mBtnAirplane.setOnClickListener(listener);
		mBtnRabbit.setOnClickListener(listener);
		mBtnLittleStar.setOnClickListener(listener);
		mBtnSchool.setOnClickListener(listener);
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
		mThreadRun = true;
		mPiezoThread = new PiezoThread();
		mPiezoThread.start();
		super.onResume();
	}

	public Handler handler = new Handler() {

		public void handleMessage(Message msg) {
			
			for(int i=0; i<13; i++) {
				if(mBtnList[i] != null)
					mBtnList[i].setBackgroundColor(Color.WHITE);
			}
			
			mBtnList[msg.arg1].setBackgroundColor(Color.GREEN);
		}
	};

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
							Message text = Message.obtain();
							text.arg1 = airplane[i];
							handler.sendMessage(text);
							mDriver.setBuzzer(text.arg1);
						}
						mStart = false;
					}
					else if (btnIndex == 2){
						for(int i=0; i<25; i++) {
							if(btnIndex != 2) break;
							Message text = Message.obtain();
							text.arg1 = rabbit[i];
							handler.sendMessage(text);
							mDriver.setBuzzer(text.arg1);
						}
						mStart = false;
					}
					else if (btnIndex == 3){
						for(int i=0; i<42; i++) {
							if(btnIndex != 3) break;
							Message text = Message.obtain();
							text.arg1 = littlestar[i];
							handler.sendMessage(text);
							mDriver.setBuzzer(text.arg1);
						}
						mStart = false;
					}
					else if (btnIndex == 4){
						for(int i=0; i<24; i++) {
							if(btnIndex != 4) break;
							Message text = Message.obtain();
							text.arg1 = school[i];
							handler.sendMessage(text);
							mDriver.setBuzzer(text.arg1);
						}
						mStart = false;
					}
				}
			}
		}
	}
}