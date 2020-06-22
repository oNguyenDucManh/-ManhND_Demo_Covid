package com.manhnd.covideandroid

import android.content.Context
import android.content.Intent
import com.manhnd.covideandroid.MyApplication.Companion.FLUTTER_ENGINE_ID
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel

class MyFlutterActivity : FlutterActivity() {
    override fun onResume() {
        super.onResume()
        MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, "com.manhnd.covid")
            .invokeMethod("gotoPage", intent.getStringExtra("screen"))
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.manhnd.covid")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "exitFlutter" -> {
                        finish()
                    }
                    "getParamCountry" -> {
                        val country = intent.getStringExtra("country")
                        result.success(country)
                    }
                    "GotoSecondPageNative" -> {
                        val intent = Intent(this, SecondActivity::class.java)
                        call.argument<Int>("confirmed")?.let {
                            intent.putExtra("confirmed", it)
                        }
                        call.argument<Int>("recovered")?.let {
                            intent.putExtra("recovered", it)
                        }
                        call.argument<Int>("deaths")?.let {
                            intent.putExtra("deaths", it)
                        }
                        startActivity(intent)
                    }
                }
            }
    }

    override fun provideFlutterEngine(context: Context): FlutterEngine? {
        return FlutterEngineCache.getInstance().get(FLUTTER_ENGINE_ID)
    }
}