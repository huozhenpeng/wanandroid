import 'package:flutter/material.dart';

class GlobalProvider with ChangeNotifier
{
  bool _isLogin=false;
  bool get loginStatus=>_isLogin;

  setLoginStatus(bool login)
  {
    if(login!=_isLogin)
      {
        _isLogin=login;
        notifyListeners();
      }
  }
}