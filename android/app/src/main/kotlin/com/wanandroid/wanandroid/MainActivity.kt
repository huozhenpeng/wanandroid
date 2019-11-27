package com.wanandroid.wanandroid

import android.os.Bundle
import com.wanandroid.wanandroid.webview.WebViewFactory
import com.wanandroid.wanandroid.webview.WebViewFlutterPlugin

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    MViewFlutterPlugin.registerWith(this)
    WebViewFlutterPlugin.registerWith(this)
  }
}
