import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid/config/route_map.dart';
import 'package:wanandroid/provider/theme_color.dart';
import 'package:wanandroid/provider/theme_mode.dart';

import 'login/login.dart';

void main() {

  final ThemeColorProvider themeProvider=ThemeColorProvider();
  final ThemeModeProvider themeModeProvider=ThemeModeProvider();

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: themeProvider),
          ChangeNotifierProvider.value(value: themeModeProvider),
        ],
        child: MyApp(),
      ),

  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'wanandroid',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      home: MyHomePage(title: 'wanandroid'),
      routes: RouteMap.instance.getRouteMap(),
      //initialRoute:RouteName.splansh ,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      body: SplanshWidget(),
        body:LoginWidget(),
    );
  }
}
