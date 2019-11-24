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
                              ),
                              ///收藏
                              ListTile(
                                leading: Icon(Icons.favorite_border,color: colorProvider.theme,),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                title: Text("收藏"),
                                contentPadding: EdgeInsets.fromLTRB(15, 50, 10, 0),
                              ),
                              ExpansionTile(
                                leading: Icon(Icons.color_lens,color: colorProvider.theme,),
                                trailing: Icon(Icons.keyboard_arrow_down),
                                title: Text("色彩"),
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Wrap(
                                      children: Colors.primaries.map((color){
                                        return InkWell(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: color,
                                                borderRadius: BorderRadius.all(Radius.circular(15))
                                            ),
                                            margin: EdgeInsets.all(5),
                                            width: 30,
                                            height: 30,

                                          ),
                                          onTap: (){
                                            colorProvider.setTheme(color);
                                          },
                                        );
                                      }
                                      ).toList(),
                                    ),
                                  )
                                ],
                              ),
                              ListTile(
                                leading: Icon(Icons.brightness_5,color: colorProvider.theme,),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                title: Text("设置"),
                                contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                              ),
                              ListTile(
                                leading: Icon(Icons.info_outline,color: colorProvider.theme,),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                title: Text("关于"),
                                contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                              ),
                              
                              
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

class ColorSelectWidget extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}