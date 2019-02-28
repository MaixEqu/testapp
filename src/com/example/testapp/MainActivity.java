package com.example.testapp;

import android.app.Activity;
import android.app.AlertDialog;
import android.os.Bundle;
import android.widget.Button;
import android.widget.Toast;

public class MainActivity extends Activity {

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Button button = new Button(this);
        button.setText("Big button (v.3, mint-w, J2S, test-1)");

        button.setOnClickListener(v -> {
            new AlertDialog.Builder(MainActivity.this)
                    .setTitle("From lambda")
                    .setMessage(getString(R.string.hello))
                    .show();
        });
        
        setContentView(button);
    }
}