import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wanandroid/entitys/home_banner.dart';
import 'package:wanandroid/entitys/top_articles.dart';
import 'package:wanandroid/http/apis.dart';
import 'package:wanandroid/http/http_utils.dart';

class HomeProvider with ChangeNotifier
{
  HomeBannerResult _homeBannerResult;
  HomeBannerResult get homeBannerResult=>_homeBannerResult;
  ///请求banner数据
  void getBannerResult() async
  {
    print("首页banner开始请求。。。");
    String result=await HttpUtils().get(Api.banner_url);
    print("首页banner获取到结果。。。");
    _homeBannerResult=HomeBannerResult.fromJson(json.decode(result));
    notifyListeners();
  }


  TopArticleResult _topArticleResult;
  TopArticleResult get topArticleResult=>_topArticleResult;
  ///首页置顶数据
  void getTopArticles() async
  {
    print("首页置顶文章开始请求。。。");
    String result =await HttpUtils().get(Api.top_url);
    _topArticleResult=TopArticleResult.fromJson(json.decode(result));
    print("首页置顶文章结束请求。。。");
    notifyListeners();
  }
}