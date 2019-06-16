package alfianyusufabdullah.meals_catalogue

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
    }

    override fun onBackPressed() {
        if (flutterView != null){
            flutterView.popRoute()
            return
        }
        super.onBackPressed()
    }
}
