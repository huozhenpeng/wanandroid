import 'package:flutter/material.dart';

class LoadingUtils
{
  static BuildContext context;

  static LoadingUtils _instance;
  static LoadingUtils _getInstance()
  {
    if(_instance==null)
    {
      return LoadingUtils._internal();
    }
    else
    {
      return _instance;
    }
  }
  static LoadingUtils get instance=>_getInstance();
  LoadingUtils._internal();

  void showLoadingDialog() {
    if(context==null)
      {
        print("请先设置全局context");
        return;
      }
    showDialog(
      context: context,
      barrierDismissible: true, //点击遮罩不关闭对话框
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 26.0),
                child: Text("正在加载，请稍后..."),
              )
            ],
          ),
        );
      },
    );
  }

  void closeLoadingDialog() {
    if(context==null)
    {
      print("请先设置全局context");
      return;
    }
    Navigator.of(context).pop();
  }
}