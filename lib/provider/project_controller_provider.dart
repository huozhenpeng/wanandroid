import 'package:flutter/material.dart';

class ProjectControllerProvider with ChangeNotifier
{
  TabController _tabController;
  TabController get tabController=>_tabController;

  set tabController(TabController tabController)
  {
    _tabController=tabController;
    notifyListeners();
  }
}