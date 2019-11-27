import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wanandroid/entitys/square_result.dart';
import 'package:wanandroid/http/http_utils.dart';

class SquareProvider extends ChangeNotifier
{

  Future<SquareResult> getSquareResult(int page) async
  {
    String result=await HttpUtils().get("/user/2/share_articles/$page/json");
    SquareResult squareResult=SquareResult.fromJson(json.decode(result));
    return squareResult;
  }

}