import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wanandroid/entitys/project_list.dart';
import 'package:wanandroid/entitys/project_types.dart';
import 'package:wanandroid/http/apis.dart';
import 'package:wanandroid/http/http_utils.dart';

class ProjectProvider with ChangeNotifier
{


  List<ProjectItem> _data=[];
  List<ProjectItem> get data=>_data;

  void getTypes() async
  {
    String result =await HttpUtils().get(Api.projec_type_url);
    ProjectTypeResult projectTypeResult=ProjectTypeResult.fromJson(json.decode(result));
    if(projectTypeResult!=null)
      {
        _data.clear();
        _data.addAll(projectTypeResult.data);
        notifyListeners();
      }
  }


  Future<List<ItemData>> getListDatas (int page ,int cid) async
  {
    //project/list/1/json?cid=294
    String result =await HttpUtils().get("/project/list/$page/json?cid=$cid");
    ProjectListResult projectListResult=ProjectListResult.fromJson(json.decode(result));
    return projectListResult.data.datas;
  }


}