package com.wanandroid.wanandroid;

import io.flutter.plugin.common.PluginRegistry;

public class MViewFlutterPlugin {
    public static void registerWith(PluginRegistry registry)
    {
        final  String key=MViewFlutterPlugin.class.getCanonicalName();
        if(registry.hasPlugin(key))
        {
            return;
        }
        PluginRegistry.Registrar registrar=registry.registrarFor(key);
        registrar.platformViewRegistry().registerViewFactory("mview",new MViewFactory(registrar.messenger()));

    }
}
