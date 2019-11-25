import 'package:flutter/material.dart';

class HomeScrollerProvider with ChangeNotifier
{

  ScrollController _scrollController;

  ScrollController get scrollController=>_scrollController;

  bool _showTitle=false;
  bool get showTitle=>_showTitle;

  int _height=160;


  init()
  {
    _scrollController=ScrollController();
    _scrollController.addListener((){
      print("滑动距离:${_scrollController.offset}");
      if(_scrollController.offset>_height&&!_showTitle)
        {
          _showTitle=true;
          notifyListeners();
        }
      else if(_scrollController.offset<=_height&&_showTitle)
        {
          _showTitle=false;
          notifyListeners();
        }
    });
  }

  scrollToTop()
  {
    _scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeInOutCubic);
  }




}