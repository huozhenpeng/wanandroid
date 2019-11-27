package com.wanandroid.wanandroid.webview;

import com.wanandroid.wanandroid.MViewFactory;

import io.flutter.plugin.common.PluginRegistry;

public class WebViewFlutterPlugin {
    public static void registerWith(PluginRegistry registry)
    {
        final  String key= WebViewFlutterPlugin.class.getCanonicalName();
        if(registry.hasPlugin(key))
        {
            return;
        }
        PluginRegistry.Registrar registrar=registry.registrarFor(key);
        registrar.platformViewRegistry().registerViewFactory("webview",new WebViewFactory(registrar.messenger()));

    }
}
