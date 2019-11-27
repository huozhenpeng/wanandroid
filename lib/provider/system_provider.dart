import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wanandroid/entitys/nav_result.dart';
import 'package:wanandroid/entitys/setup_result.dart';
import 'package:wanandroid/http/apis.dart';
import 'package:wanandroid/http/http_utils.dart';

class SystemProvider extends ChangeNotifier
{

  ///获取体系数据
  Future<SetupResult> getSystemData() async
  {
    String result= await HttpUtils().get(Api.system_url);;
    SetupResult setupResult=SetupResult.fromJson(json.decode(result));
    return setupResult;
  }

  ///获取导航数据
  Future<NavResult> getNavData() async
  {
    String result= await HttpUtils().get(Api.nav_url);
    NavResult setupResult=NavResult.fromJson(json.decode(result));
    return setupResult;
  }
  
}
