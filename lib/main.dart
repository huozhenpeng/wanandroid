import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid/config/route_map.dart';
import 'package:wanandroid/provider/globle_provider.dart';
import 'package:wanandroid/provider/theme_color.dart';
import 'package:wanandroid/provider/theme_mode.dart';
import 'package:wanandroid/splansh.dart';

import 'login/login.dart';

void main() {

  final ThemeColorProvider themeProvider=ThemeColorProvider();
  final ThemeModeProvider themeModeProvider=ThemeModeProvider();
  final GlobalProvider globalProvider=GlobalProvider();

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: themeProvider),
          ChangeNotifierProvider.value(value: themeModeProvider),
          ChangeNotifierProvider.value(value: globalProvider),
        ],
        child: MyApp(),
      ),

  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeColorProvider>(builder: (context,themeColorProvider,child){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'wanandroid',
        theme: ThemeData(
          primarySwatch: themeColorProvider.theme,
          primaryColor: themeColorProvider.theme,
          brightness: Brightness.light,
        ),
        home: MyHomePage(title: 'wanandroid'),
        routes: RouteMap.instance.getRouteMap(),
        //initialRoute:RouteName.splansh ,
      );
    });
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
      body: SplanshWidget(),
    );
  }
}
