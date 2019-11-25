import 'package:wanandroid/entitys/top_articles.dart';

class HomeArticleResult {
  HomeData data;
  int errorCode;
  String errorMsg;

  HomeArticleResult({this.data, this.errorCode, this.errorMsg});

  HomeArticleResult.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new HomeData.fromJson(json['data']) : null;
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }
}

class HomeData {
  int curPage;
  List<TopAritcleItem> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  HomeData(
      {this.curPage,
        this.datas,
        this.offset,
        this.over,
        this.pageCount,
        this.size,
        this.total});

  HomeData.fromJson(Map<String, dynamic> json) {
    curPage = json['curPage'];
    if (json['datas'] != null) {
      datas = new List<TopAritcleItem>();
      json['datas'].forEach((v) {
        datas.add(new TopAritcleItem.fromJson(v));
      });
    }
    offset = json['offset'];
    over = json['over'];
    pageCount = json['pageCount'];
    size = json['size'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['curPage'] = this.curPage;
    if (this.datas != null) {
      data['datas'] = this.datas.map((v) => v.toJson()).toList();
    }
    data['offset'] = this.offset;
    data['over'] = this.over;
    data['pageCount'] = this.pageCount;
    data['size'] = this.size;
    data['total'] = this.total;
    return data;
  }
}


class Tags {
  String name;
  String url;

  Tags({this.name, this.url});

  Tags.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
