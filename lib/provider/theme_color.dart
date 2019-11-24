import 'package:flutter/material.dart';

class ThemeColorProvider with ChangeNotifier
{
  Color _theme=Colors.deepPurple;

  Color get theme=>_theme;

  setTheme(Color color)
  {
    if(color!=_theme)
      {
       _theme=color;
       notifyListeners();
      }
  }

}