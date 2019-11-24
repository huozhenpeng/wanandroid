import 'package:flutter/cupertino.dart';

class ScreenUtils
{

  static ScreenUtils _instance;
  static ScreenUtils _getInstance()
  {
    if(_instance==null)
    {
      return ScreenUtils._internal();
    }
    else
    {
      return _instance;
    }
  }
  static ScreenUtils get instance=>_getInstance();
  ScreenUtils._internal();

}