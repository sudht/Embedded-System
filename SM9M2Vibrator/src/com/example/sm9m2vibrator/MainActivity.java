package com.example.sm9m2vibrator;

import com.hbe.jnidriver.JNIDriver;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;
import android.app.Activity;


public class MainActivity extends Activity {

	JNIDriver mDriver = new JNIDriver();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		Button On = (Button)findViewById(R.id.button1);
		Button Off = (Button)findViewById(R.id.button2);
		On.setOnClickListener(new Button.OnClickListener(){
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				mDriver.setVib(1);
			}
		}); Off.setOnClickListener(new Button.OnClickListener(){
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				mDriver.setVib(0);
			}
		});
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
		if(mDriver.open("/dev/sm9s5422_perivib")<0){
			Toast.makeText(MainActivity.this, "Driver Open Failed", Toast.LENGTH_SHORT).show();
		}
		super.onResume();
	}
}