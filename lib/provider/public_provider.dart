import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wanandroid/entitys/project_list.dart';
import 'package:wanandroid/entitys/project_types.dart';
import 'package:wanandroid/entitys/public_results.dart';
import 'package:wanandroid/entitys/public_types.dart';
import 'package:wanandroid/http/apis.dart';
import 'package:wanandroid/http/http_utils.dart';

class PublicProvider with ChangeNotifier
{


  List<PublicTypeItem> _data=[];
  List<PublicTypeItem> get data=>_data;

  void getTypes() async
  {
    String result =await HttpUtils().get(Api.public_url);
    PublicTypeResult projectTypeResult=PublicTypeResult.fromJson(json.decode(result));
    if(projectTypeResult!=null)
      {
        _data.clear();
        _data.addAll(projectTypeResult.data);
        notifyListeners();
      }
  }



  Future<List<PublicItem>> getListDatas (int page ,int cid) async
  {

    //project/list/1/json?cid=294
    String result =await HttpUtils().get("/wxarticle/list/$cid/$page/json");
    PublicResult projectListResult=PublicResult.fromJson(json.decode(result));
    return projectListResult.data.datas;
  }


}