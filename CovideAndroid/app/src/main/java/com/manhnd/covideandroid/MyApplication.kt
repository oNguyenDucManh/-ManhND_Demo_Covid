package com.manhnd.covideandroid

import io.flutter.app.FlutterApplication
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class MyApplication : FlutterApplication() {
    var flutterEngineHalf: FlutterEngine? = null
    var flutterEngine: FlutterEngine? = null

    override fun onCreate() {
        super.onCreate()
        flutterEngineHalf = FlutterEngine(this)
        flutterEngineHalf!!.dartExecutor.executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault())

        FlutterEngineCache.getInstance().put(FLUTTER_ENGINE_HALF_ID, flutterEngineHalf)

        flutterEngine = FlutterEngine(this)
        flutterEngine!!.dartExecutor.executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault())

        FlutterEngineCache.getInstance().put(FLUTTER_ENGINE_ID, flutterEngine)
    }

    companion object {
        const val FLUTTER_ENGINE_ID = "FLUTTER_ENGINE_ID"
        const val FLUTTER_ENGINE_HALF_ID = "FLUTTER_ENGINE_HALF_ID"
    }
}