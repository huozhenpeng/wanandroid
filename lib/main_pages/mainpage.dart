import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid/config/route_name.dart';
import 'package:wanandroid/home_pages/homepage.dart';
import 'package:wanandroid/home_pages/project_page.dart';
import 'package:wanandroid/home_pages/public_page.dart';
import 'package:wanandroid/home_pages/square_page.dart';
import 'package:wanandroid/home_pages/systemup_page.dart';
import 'package:wanandroid/login/login.dart';
import 'package:wanandroid/main_pages/customdraw.dart';
import 'package:wanandroid/provider/theme_color.dart';
import 'package:wanandroid/provider/theme_mode.dart';
import 'package:oktoast/oktoast.dart';

class MainPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {

    return MainPageState();
  }

}

class MainPageState extends State<MainPage> with AutomaticKeepAliveClientMixin
{
  int _currentIndex=0;
  List<Widget> widgets =[
    HomePage(),
    SquarePage(),
    PublicPage(),
    SystemUpWidget(),
    ProjectPage(),

  ];
  @override
  void initState() {
    super.initState();
  }
  //上次点击的时间
  DateTime _lastPressedTime;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          drawer: CustomDrawer(),
          bottomNavigationBar: Builder(
              builder: (context)
              {
                return Consumer2<ThemeModeProvider,ThemeColorProvider>(
                  builder: (context,modeProvider,colorProvider,child){

                    return BottomNavigationBar(
                      items:[
                        BottomNavigationBarItem( icon: Icon(Icons.home),title: Text("首页")),
                        BottomNavigationBarItem( icon: Icon(Icons.group_work),title: Text("广场")),
                        BottomNavigationBarItem( icon: Icon(Icons.format_list_bulleted),title: Text("公众号")),
                        BottomNavigationBarItem( icon: Icon(Icons.call_split),title: Text("体系")),
                        BottomNavigationBarItem( icon: Icon(Icons.account_balance),title: Text("项目")),
                      ],
                      fixedColor: colorProvider.theme,

                      type: BottomNavigationBarType.fixed,

                      currentIndex: _currentIndex,

                      onTap: (index){
                        setState(() {
                          _currentIndex=index;
                        });
                      },
                    );

                  },
                );
              }
          ),

          //这种切换方式才可以保持状态
          body:IndexedStack(
            children: widgets,
            index: _currentIndex,
          ),
          // body: widgets[_currentIndex],

        ),
        onWillPop: ()async{
          //返回false不出栈
          if(_lastPressedTime==null||DateTime.now().difference(_lastPressedTime)>Duration(seconds: 1))
            {
              _lastPressedTime=DateTime.now();
              showToast(
                  "再按一次返回",
                radius: 6,
                backgroundColor: Theme.of(context).primaryColor,
                position: ToastPosition.bottom,
              );
              return false;
            }
          else
            {
              return true;
            }
        }
    );

  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}

