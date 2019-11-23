import 'package:flutter/material.dart';

class ThemeModeProvider with ChangeNotifier
{
  Brightness _themeMode=Brightness.light;
  Color _color=Colors.black;

  Brightness get themeMode=>_themeMode;

  Color get color=>_color;

  setThemeMode(Brightness brightness)
  {
    if(brightness!=_themeMode)
    {
      _themeMode=brightness;
      if(_themeMode==Brightness.light)
        {
          _color=Colors.black;
        }
      else
        {
          _color=Colors.white;
        }
      notifyListeners();
    }
  }
}