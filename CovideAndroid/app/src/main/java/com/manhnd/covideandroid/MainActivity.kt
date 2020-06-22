package com.manhnd.covideandroid

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.manhnd.covideandroid.MyApplication.Companion.FLUTTER_ENGINE_HALF_ID
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {
    private var flutterEngineHalf: FlutterEngine? = null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        configFlutterView()
        listener()
    }


    private fun listener() {
        gotoCovid.setOnClickListener {
//            val intent = Intent(this, FlutterActivity::class.java);
//            startActivity(intent)
            startActivity(
                FlutterActivity.createDefaultIntent(this)
            );
        }
        gotoCovid2.setOnClickListener {
//            val intent = Intent(this, MyFlutterActivity::class.java);
//            startActivity(intent)
//            startActivity(
//                FlutterActivity.createDefaultIntent(this)
//            );
            val intent = Intent(this, MyFlutterActivity::class.java)
            startActivity(intent)
        }
        gotoVNCovid.setOnClickListener {
            val intent = Intent(this, MyFlutterActivity::class.java)
            intent.putExtra("screen", "DetailPage")
            intent.putExtra("country", "Vietnam")
            startActivity(intent)
        }
    }

    private fun configFlutterView() {

        if (FlutterEngineCache.getInstance().get(FLUTTER_ENGINE_HALF_ID) != null) {
            flutterEngineHalf = FlutterEngineCache.getInstance().get(FLUTTER_ENGINE_HALF_ID)
        } else {
            flutterEngineHalf = FlutterEngine(this)
            flutterEngineHalf!!.dartExecutor.executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault())
            FlutterEngineCache.getInstance().put(FLUTTER_ENGINE_HALF_ID, flutterEngineHalf);
        }
        flutterEngineHalf?.let { flutterView.attachToFlutterEngine(it) }
    }

    override fun onResume() {
        super.onResume()
        flutterEngineHalf?.lifecycleChannel?.appIsResumed()
    }

    override fun onPause() {
        super.onPause()
        flutterEngineHalf?.lifecycleChannel?.appIsInactive()
    }

    override fun onStop() {
        super.onStop()
        flutterEngineHalf?.lifecycleChannel?.appIsPaused()
    }

    override fun onDestroy() {
        flutterView!!.detachFromFlutterEngine()
        super.onDestroy()
    }
}