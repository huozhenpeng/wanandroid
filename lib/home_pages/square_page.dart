import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroid/entitys/square_result.dart';
import 'package:wanandroid/home_pages/webview.dart';
import 'package:wanandroid/home_pages/webviewdemo.dart';
import 'package:wanandroid/provider/squeare_provider.dart';
import 'package:wanandroid/provider/theme_color.dart';

class SquarePage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return SquarePageState();
  }

}

class SquarePageState extends State<SquarePage> with AutomaticKeepAliveClientMixin
{
  int page=1;

  final List<Article> datas=[];
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {

    return Consumer<ThemeColorProvider>(builder: (context,colorProvider,child){
      return  Scaffold(
          appBar: AppBar(
            leading: null,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text("广场",style: TextStyle(color: colorProvider.theme.computeLuminance()<0.5?Colors.white:Colors.black
            ),),
          ),
          body: FutureBuilder<SquareResult>(
              future: Provider.of<SquareProvider>(context).getSquareResult(page),
              builder: (context,snap)
              {
                if(!snap.hasData)
                {
                  return Center(
                    child: SpinKitFadingCircle(
                      color: Theme.of(context).primaryColor,
                      size: 50.0,
                    ),
                  );
                }
                else
                {
                  datas.addAll(snap.data.data.shareArticles.datas);

                  return ListViewPage(datas);

                }
              }
          )
        );
    },);
  }

}

class ListViewPage extends StatefulWidget
{
  final List<Article> datas;
  ListViewPage(this.datas);
  @override
  State<StatefulWidget> createState() {
    return ListViewPageState();
  }

}

class ListViewPageState extends State<ListViewPage>
{
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  int page=1;
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      enablePullDown: true,
      enablePullUp: true,
      header: MaterialClassicHeader(),
      child: ListView.builder(
          itemCount: widget.datas.length,
          itemBuilder: (context,index)
          {
            return ArticleItem(widget.datas[index]);
          }
      ),
    );
  }

  void _onRefresh() async{
    // monitor network fetch
    page=1;
    SquareResult result=await Provider.of<SquareProvider>(context,listen: false).getSquareResult(page);
    // if failed,use refreshFailed()
    if(result==null)
    {
      _refreshController.refreshFailed();
    }
    else
    {
      widget.datas.clear();
      widget.datas.addAll(result.data.shareArticles.datas);
      setState(() {

      });
      _refreshController.refreshCompleted();
    }
  }

  void _onLoading() async{
    page++;
    // monitor network fetch
    SquareResult result=await Provider.of<SquareProvider>(context,listen: false).getSquareResult(page);
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if(result==null)
    {
      _refreshController.loadFailed();
    }
    else if(page>=result.data.shareArticles.pageCount)
    {
      _refreshController.loadNoData();
    }
    else
    {
      _refreshController.loadComplete();
      widget.datas.addAll(result.data.shareArticles.datas);
      setState(() {

      });
    }

  }

}

class ArticleItem extends StatelessWidget
{
  final Article topAritcleItem;
  ArticleItem(this.topAritcleItem);
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeColorProvider>(builder:(context,colorProvider,child){

      return InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return WebViewWidget(topAritcleItem.title,topAritcleItem.link);
          }));
        },
        child: Container(
          padding: EdgeInsets.only(left: 10,top: 10,right: 10,bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(child:Text(topAritcleItem.author.isEmpty?topAritcleItem.shareUser:topAritcleItem.author)),
                  Expanded(
                    child: Text("${topAritcleItem.niceDate}",textAlign: TextAlign.right,),
                  )

                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(topAritcleItem.title, maxLines: 2, overflow: TextOverflow.ellipsis,),
              ),

              Row(
                children: <Widget>[
                  Text("${topAritcleItem.superChapterName}/${topAritcleItem.chapterName}",style: TextStyle(color: Colors.black45,fontSize: 12),),

                  Expanded(
                      child: Container(

                        alignment: Alignment.centerRight,
                        child: Icon(Icons.favorite_border,color: colorProvider.theme,),
                      )
                  )
                ],
              ),
              Divider()
            ],
          ),

        ),
      );
    }
    );
  }


}
