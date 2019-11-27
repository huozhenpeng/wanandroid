import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wanandroid/home_pages/webviewdemo.dart';

class SquarePage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return SquarePageState();
  }

}

class SquarePageState extends State<SquarePage> with AutomaticKeepAliveClientMixin
{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            width: 300,
            height: 500,
            child:  AndroidView(
              viewType: "webview",
              creationParams: {
                "url":"https://www.wanandroid.com/blog/show/2030"
              },
              creationParamsCodec: StandardMessageCodec(),
          ),

          ),
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return WebViewExample();
              }));
            },
            child:  Text("flutter view"),
          ),

        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

}