package com.example.sm9m2switch;

import com.hbe.jnidriver.JNIDriver;
import com.hbe.jnidriver.JNIListener;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.app.Activity;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;


public class MainActivity extends Activity implements JNIListener {

	JNIDriver mDriver;
	
	int[]btString={R.id.toggleButton0,R.id.toggleButton1,R.id.toggleButton2,R.id.toggleButton3,
			R.id.toggleButton4};
	ToggleButton[] mBtn= new ToggleButton[5];
	
	TextView tv;
	String str = "";
	// ReceiveThread mSegThread;
	boolean mThreadRun = true;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		tv = (TextView) findViewById(R.id.textView1);

		mDriver = new JNIDriver();
		mDriver.setListener(this);
		if (mDriver.open("/dev/sm9s5422_interrupt") < 0) {
			Toast.makeText(MainActivity.this, "Driver Open Failed",
					Toast.LENGTH_SHORT).show();
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

		super.onResume();
	}
	public Handler handler = new Handler() {
		

		public void handleMessage(Message msg) {
			
			for(int i=0; i<5;i++){
				mBtn[i]= (ToggleButton)findViewById(btString[i]);
				mBtn[i].setChecked(false);
			}

			switch (msg.arg1) {

			case 1:
				if(mBtn[0].isChecked())
					mBtn[0].setChecked(false);
				else
					mBtn[0].setChecked(true);
				break;
			case 2:
				if(mBtn[1].isChecked())
					mBtn[1].setChecked(false);
				else
					mBtn[1].setChecked(true);
				break;
			case 3:
				if(mBtn[2].isChecked())
					mBtn[2].setChecked(false);
				else
					mBtn[2].setChecked(true);
				break;
			case 4:
				if(mBtn[3].isChecked())
					mBtn[3].setChecked(false);
				else
					mBtn[3].setChecked(true);
				break;
			case 5:
				if(mBtn[4].isChecked())
					mBtn[4].setChecked(false);
				else
					mBtn[4].setChecked(true);
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

