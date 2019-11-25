import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid/entitys/top_articles.dart';
import 'package:wanandroid/login/loading_utils.dart';
import 'package:wanandroid/provider/home_provider.dart';
import 'package:wanandroid/provider/theme_color.dart';
import 'package:wanandroid/utils/toast_utils.dart';

class HomePage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

}

class HomePageState extends State<HomePage>
{
  @override
  void initState() {
    super.initState();

  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //请求banner数据
    print("--------获取页面总数据--------");
    //记住这儿传递false，如果不加的话会循环请求接口
    Provider.of<HomeProvider>(context,listen: false).getBannerResult();


    Provider.of<HomeProvider>(context,listen: false).getTopArticles();

  }
  @override
  Widget build(BuildContext context) {

    return Consumer<ThemeColorProvider>(builder: (context,colorProvider,child){

      return Scaffold(

        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: _getBanner(),
            ),
            _getTopList(),

          ],
        ),
      );
    });
  }

  Widget _getBanner()
  {
    return Consumer2<ThemeColorProvider,HomeProvider>(builder: (context,colorProvider,homeProvider,child){

      if(homeProvider.homeBannerResult==null||homeProvider.homeBannerResult.data==null)
        {
          return Container(
            height: 250,
          );
        }
      else
        {
          return Container(
            width: double.infinity,
            height: 250,
            child: Swiper(
              itemBuilder: (BuildContext context,int index){
                return new Image.network(homeProvider.homeBannerResult.data[index].imagePath,fit: BoxFit.fill,);
              },
              itemCount: 3,
              pagination:  SwiperPagination(),
              autoplay: true,
              //control:  SwiperControl(),
            ),
          );
        }
    },
    );

  }

  Widget _getTopList()
  {
    return Consumer<HomeProvider>(builder: (context,homeProvider,child) {
      return SliverList(delegate: SliverChildListDelegate(
          (homeProvider.topArticleResult == null||homeProvider.topArticleResult.data==null) ? [] : homeProvider
              .topArticleResult.data.map((topArticleItem) {
            return ArticleItem(topArticleItem);
          }).toList()
      ),
      );
    }
    );
  }
}

class ArticleItem extends StatelessWidget
{
  final TopAritcleItem topAritcleItem;
  ArticleItem(this.topAritcleItem);
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeColorProvider>(builder:(context,colorProvider,child){

      return Container(
        padding: EdgeInsets.only(left: 10,top: 10,right: 10,bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
               children: <Widget>[
                 _getTags(topAritcleItem),
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

      );
    }
    );
  }

  //tag
 Widget _getTags(TopAritcleItem topAritcleItem)
 {
   if(topAritcleItem!=null&&topAritcleItem.tags!=null&&topAritcleItem.tags.length>0)
     {
       return Container(margin:EdgeInsets.only(right: 10),child: Row(
         children: topAritcleItem.tags.map((tags){
           return Tag(tags.name);
         }).toList(),
       ),);
     }
   else
     {
       //这儿需要widget的时候还必须返回一个，但是这样写是不占间距的
       return Container();
     }
 }

}

class Tag extends StatelessWidget
{
  final String text;
  Tag(this.text);
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeColorProvider>(builder:(context,colorProvider,child){
      return Container(
        padding: EdgeInsets.symmetric(vertical: 0,horizontal: 3),
        decoration: BoxDecoration(
          border: Border.all(color: colorProvider.theme),
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
        child: Text(text,style: TextStyle(color: colorProvider.theme,fontSize: 12),),
      );
    });
  }

}