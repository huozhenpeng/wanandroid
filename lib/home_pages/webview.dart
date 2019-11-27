import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid/home_pages/webviewdemo.dart';
import 'package:wanandroid/provider/theme_color.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatelessWidget
{
  final String title;
  final String url;
  WebViewWidget(this.title,this.url);
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeColorProvider>(builder: (context,colorProvider,child){
      return Scaffold(
        appBar: AppBar(
          title: Text(title,style: TextStyle(color: colorProvider.theme.computeLuminance()<0.5?Colors.white:Colors.black),),
          centerTitle: true,
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              color: colorProvider.theme,
              child: InkWell(
                child:Text("官方示例",style: TextStyle(color: colorProvider.theme.computeLuminance()<0.5?Colors.white:Colors.black)) ,
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return WebViewExample();
                  }));
                },
              )

            )
          ],
        ),

        body: Container(
          color: Colors.white,
          child: WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      );
    });
  }

}