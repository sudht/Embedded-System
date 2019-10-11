package com.example.sm9m2led;

import com.hbe.jnidriver.JNIDriver;

import android.os.Bundle;
import android.app.Activity;
import android.widget.CompoundButton;
import android.widget.Toast;
import android.widget.ToggleButton;

public class MainActivity extends Activity {

	JNIDriver mDriver = new JNIDriver();
	int[]btString={R.id.toggleButton0,R.id.toggleButton1,R.id.toggleButton2,R.id.toggleButton3,
			R.id.toggleButton4,R.id.toggleButton5,R.id.toggleButton6,R.id.toggleButton7,R.id.toggleButton8};
	ToggleButton[] mBtn= new ToggleButton[9];
	byte[] data = {0,0,0,0,0,0,0,0};
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		CompoundButton.OnCheckedChangeListener listener = new
				CompoundButton.OnCheckedChangeListener() {
			@Override
			public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
				switch(buttonView.getId()){
				case R.id.toggleButton0:
					if(mBtn[0].isChecked())
						data[0]=1;
					else data[0]=0;
					break;
				case R.id.toggleButton1:
					if(mBtn[1].isChecked())
						data[1]=1;
					else data[1]=0;
					break;
				case R.id.toggleButton2:
					if(mBtn[2].isChecked())
						data[2]=1;
					else data[2]=0;
					break;
				case R.id.toggleButton3:
					if(mBtn[3].isChecked())
						data[3]=1;
					else data[3]=0;
					break;
				case R.id.toggleButton4:
					if(mBtn[4].isChecked())
						data[4]=1;
					else data[4]=0;
					break;
				case R.id.toggleButton5:
					if(mBtn[5].isChecked())
						data[5]=1;
					else data[5]=0;
					break;
				case R.id.toggleButton6:
					if(mBtn[6].isChecked())
						data[6]=1;
					else data[6]=0;
					break;
				case R.id.toggleButton7:
					if(mBtn[7].isChecked())
						data[7]=1;
					else data[7]=0;
					break;
				case R.id.toggleButton8:
					
					if(mBtn[8].isChecked()) {
						for(int i =0; i<8; i++) {
							data[i] = 0;
						}
						mDriver.write(data);
						for(int i =0; i<8; i++) {
							data[i] = 1;
							mDriver.write(data);
							data[i] = 0;
							try {
								Thread.sleep(100);
							} catch (InterruptedException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						}
						for(int i =6; i>=0; i--) {
							data[i] = 1;
							mDriver.write(data);
							data[i] = 0;
							try {
								Thread.sleep(100);
							} catch (InterruptedException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						}
						mBtn[8]= (ToggleButton)findViewById(btString[8]);
						mBtn[8].setChecked(false); 
					}
					 
					else data[7]=0;
					break;
				}
				mDriver.write(data);
			}
		};
		for(int i=0; i<9;i++){
			mBtn[i]= (ToggleButton)findViewById(btString[i]);
			mBtn[i].setChecked(false);
			mBtn[i].setOnCheckedChangeListener(listener);
		}
	}
	@Override
	protected void onPause() {
		// TODO Auto-generated method stub
		mDriver.close();
		super.onPause();
	}
	protected void onResume() {
		// TODO Auto-generated method stub
		if(mDriver.open("/dev/sm9s5422_led")<0){
			Toast.makeText(MainActivity.this, "DriverOpen Failed",Toast.LENGTH_SHORT).show();
		}
		super.onResume();
	}
}