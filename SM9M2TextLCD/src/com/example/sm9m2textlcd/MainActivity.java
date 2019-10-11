package com.example.sm9m2textlcd;

import com.hbe.jnidriver.JNIDriver;

import android.os.Bundle;
import android.app.Activity;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;
public class MainActivity extends Activity {

	JNIDriver mDriver = new JNIDriver();
	Button mBtnDisplayOn, mBtnDisplayOff, mBtnDisplayClear;
	Button mBtnCursorOn, mBtnCursorOff, mBtnCursorLeft, mBtnCursorRight, mBtnCursorHome;
	Button mBtnLine1, mBtnLine2;
	Button mBtnAd;
	String text = "the quick brown fox jumps over the lazy dog";

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		mBtnDisplayOn = (Button)findViewById(R.id.btnDisplayOn);
		mBtnDisplayOff = (Button)findViewById(R.id.btnDisplayOff);
		mBtnDisplayClear = (Button)findViewById(R.id.btnDisplayClear);
		mBtnCursorOn = (Button)findViewById(R.id.btnCursorOn);
		mBtnCursorOff = (Button)findViewById(R.id.btnCursorOff);
		mBtnCursorLeft = (Button)findViewById(R.id.btnCursorLeft);
		mBtnCursorRight = (Button)findViewById(R.id.btnCursorRight);
		mBtnCursorHome = (Button)findViewById(R.id.btnCursorHome);
		mBtnLine1 = (Button)findViewById(R.id.btnLine1);
		mBtnLine2 = (Button)findViewById(R.id.btnLine2);
		mBtnAd = (Button)findViewById(R.id.btnAd);

		Button.OnClickListener listener = new Button.OnClickListener(){
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				if(v==mBtnDisplayOn){
					mDriver.setDisplayVisible(true);
				}else if(v==mBtnDisplayOff){
					mDriver.setDisplayVisible(false);
				}else if(v==mBtnDisplayClear){
					mDriver.clearDisplay();
				}else if(v==mBtnCursorOn){
					mDriver.setCursorVisible(true);
				}else if(v==mBtnCursorOff){
					mDriver.setCursorVisible(false);
				}else if(v==mBtnCursorLeft){
					mDriver.setCursorLeft();
				}else if(v==mBtnCursorRight){
					mDriver.setCursorRight();
				}else if(v==mBtnCursorHome){
					mDriver.setCursorHome();
				}else if(v==mBtnLine1){
					String str1 = ((EditText)findViewById(R.id.txtLine1)).getText().toString();
					mDriver.setText(1, str1);
				}else if(v==mBtnLine2){
					String str2 = ((EditText)findViewById(R.id.txtLine2)).getText().toString();
					mDriver.setText(2, str2);
				}
				else if(v==mBtnAd){
					String temp = text.substring(16);
					mDriver.setText(1, text);
					mDriver.setText(2, temp);

					for(int i=0; i<16; i++) {
						try {
							Thread.sleep(1000);
						} catch (InterruptedException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						mDriver.setCursorLeft();
					}
				}
			}
		};
		mBtnDisplayOn.setOnClickListener(listener);
		mBtnDisplayOff.setOnClickListener(listener);
		mBtnDisplayClear.setOnClickListener(listener);
		mBtnCursorOn.setOnClickListener(listener);
		mBtnCursorOff.setOnClickListener(listener);
		mBtnCursorLeft.setOnClickListener(listener);
		mBtnCursorRight.setOnClickListener(listener);
		mBtnCursorHome.setOnClickListener(listener);
		mBtnLine1.setOnClickListener(listener);
		mBtnLine2.setOnClickListener(listener);
		mBtnAd.setOnClickListener(listener);

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
		if(mDriver.open("/dev/sm9s5422_textlcd")<0){
			Toast.makeText(MainActivity.this, "Driver Open Failed", Toast.LENGTH_SHORT).show();
		}
		super.onResume();
	}
}
