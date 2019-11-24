import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid/config/route_name.dart';
import 'package:wanandroid/login/login.dart';
import 'package:wanandroid/provider/globle_provider.dart';
import 'package:wanandroid/provider/theme_color.dart';

class CustomDrawer extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    return Consumer2<ThemeColorProvider,GlobalProvider>(
        builder: (context,colorProvider,globalProvider,child)
            {
              return Drawer(
                child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,//移除顶部默认留白
                    child: Stack(
                      children: <Widget>[
                        ClipPath(
                          clipper: MyCustomerClip(),
                          child: Container(
                            color: colorProvider.theme,
                            height: 300,
                            //width: size.width,
                            //注意这个值
                            alignment: Alignment.center,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 100),
                          width: double.infinity,
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                radius: 45,
                                backgroundImage: AssetImage("images/user_avatar.png",),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: InkWell(
                                  child: Text(
                                    globalProvider.loginStatus?"已登录":"点击登录",
                                    style: TextStyle(
                                      color: colorProvider.theme.computeLuminance()<0.5?Colors.white:Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  onTap: (){
                                    if(!globalProvider.loginStatus)
                                      {
                                        //关闭抽屉
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pushNamed(RouteName.login);
                                      }
                                  },
                                ),
                              )
                            ],
                          ) ,
                        )
                      ],
                    )
                ),
              );
            }
    );
  }

}