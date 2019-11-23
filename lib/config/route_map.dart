import 'package:flutter/cupertino.dart';
import 'package:wanandroid/config/route_name.dart';

import '../splansh.dart';

///我希望它是一个单例，看下flutter中单例是如何实现的
class RouteMap
{

  static RouteMap _instance;
  static RouteMap _getInstance()
  {
    if(_instance==null)
      {
        return RouteMap._internal();
      }
    else
      {
        return _instance;
      }
  }
  static RouteMap get instance=>_getInstance();
  RouteMap._internal();

  Map<String,WidgetBuilder> getRouteMap()
  {
    return {
      RouteName.splansh:(context)=>SplanshWidget(),//spansh页面
    };
  }

}