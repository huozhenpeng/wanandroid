import 'package:flutter/material.dart' ;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroid/entitys/project_list.dart';
import 'package:wanandroid/entitys/project_types.dart';
import 'package:wanandroid/provider/project_controller_provider.dart';
import 'package:wanandroid/provider/project_provider.dart';
import 'package:wanandroid/provider/theme_color.dart';

class ProjectPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return ProjectPageState();
  }

}

class ProjectPageState extends State<ProjectPage>
{
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<ProjectProvider>(context,listen: false).getTypes();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeColorProvider,ProjectProvider>(builder: (context,colorProvider,projectProvider,child){
      if(projectProvider.data.length==0)
      {
        return Text("");
      }
      else
      {
        return DefaultTabController(
          length: projectProvider.data.length,
          child: Scaffold(
            appBar: AppBar(
              //隐藏返回按钮
              automaticallyImplyLeading: false,
              leading: null,
              //title是一个Widget，放什么都可以
              title: Stack(
                children: <Widget>[
                  DropDownWidget(),
                  TabBarWidget(),
                ],
              ),
            ),
            body: TabVarViewWidget(),
          ),
        );
      }
    });

  }

}


class TabVarViewWidget extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeColorProvider,ProjectProvider>(builder: (context,colorProvider,projectProvider,child){
      return TabBarView(
          children: projectProvider.data.map((projectItem){
            print("element:${projectItem==null?"空":"非空"}");
            return CusListView(projectItem);
          }).toList());

    });
  }

}

class CusListView extends StatefulWidget
{
  CusListView(this.projectItem);
  final ProjectItem projectItem;

  @override
  State<StatefulWidget> createState() {
    return CusListViewState();
  }
}

class CusListViewState extends State<CusListView>  with AutomaticKeepAliveClientMixin
{

  int page=0;

  @override
  Widget build(BuildContext context) {
    print("listvie build.......");

    return FutureBuilder<List<ItemData>>(
        future: Provider.of<ProjectProvider>(context).getListDatas(page, widget.projectItem.id),
        builder: (context,snapshot)
        {
          if(!snapshot.hasData)
          {
            return Center(
              child: Text("加载中"),
            );
          }
          else
          {
            return ListView(
              children: _getListView(snapshot.data),
            );
          }
        }
    );
  }

  List<Widget>_getListView(List<ItemData> datas)
  {
    return datas.map((element){
      return ArticleItem(element);
    }).toList();
  }

  @override
  bool get wantKeepAlive => true;

}

class ArticleItem extends StatelessWidget
{
  final ItemData topAritcleItem;
  ArticleItem(this.topAritcleItem);
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeColorProvider>(builder:(context,colorProvider,child){

      return Container(
        padding: EdgeInsets.only(left: 10,top: 0,right: 10,bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(child:Text(topAritcleItem.title,maxLines:1,style: TextStyle(fontSize: 16,fontStyle: FontStyle.normal),)),
                      Container(margin:EdgeInsets.only(top: 10),child:Text(topAritcleItem.desc,maxLines: 2,)),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(10),

                  child: Image.network(topAritcleItem.envelopePic,width: 70,height: 100,),
                ),

              ],
            ),

            Row(
              children: <Widget>[
                Text(topAritcleItem.author,style: TextStyle(color: Colors.black45,fontSize: 12),),
                Text(topAritcleItem.niceDate,style: TextStyle(color: Colors.black45,fontSize: 12),),

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

}



class TabBarWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TabBarWidgetState();
  }

}

class TabBarWidgetState extends State<TabBarWidget> with TickerProviderStateMixin
{

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      /// 接口请求

    });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    print("TabBarWidget build.............");
    return Consumer2<ThemeColorProvider, ProjectProvider>(
        builder: (context, colorProvider, projectProvider,child) {
          print("Consumer2 build.............");
          return Container(
            margin: EdgeInsets.only(right: 25),
            //这个应该是设置完全不透明，用于遮挡上面的控件
            color: colorProvider.theme.withOpacity(1),
            child:TabBar(
              indicatorColor: colorProvider.theme.computeLuminance()<0.5?Colors.white:Colors.black,
              //必需加上这个属性
              isScrollable: true,
              tabs: projectProvider.data.map((element){
                return Tab(
                  child: Container(
                    padding: EdgeInsets.all(6),
                    child: Text(element.name,style: TextStyle(color: colorProvider.theme.computeLuminance()<0.5?Colors.white:Colors.black),),
                  ),
                );
              }).toList(),

            ) ,
          );
        }
    );
  }

}



class DropDownWidget extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer2<ThemeColorProvider,ProjectProvider>(builder: (context,colorProvider,projectProvider,child){
        return Align(

          //这里嵌套一个主题，要不然DropdownButton的背景色是白色，改不掉
          child: Theme(
            data:  Theme.of(context).copyWith(
              canvasColor: Theme.of(context).primaryColor,
            ),
            child: DropdownButtonHideUnderline(

              child: DropdownButton(
                  elevation: 0,
                  //会裁剪展示在最上面的高度
                  //isDense: true,
                  //这个效果和自己写颜色判断的效果是一致的
                  style: Theme.of(context).primaryTextTheme.subhead,
                  //会增大DropdownButton宽度范围
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down,color: colorProvider.theme.computeLuminance()<0.5?Colors.white:Colors.black,),
                  items: projectProvider.data.map((element){
                    return DropdownMenuItem(
                      child: Container(
                        padding: EdgeInsets.all(6),
                        child: Text(element.name,style: TextStyle(color: colorProvider.theme.computeLuminance()<0.5?Colors.white:Colors.black),),
                      ),
                    );
                  }).toList(),
                  onChanged: (index){

                  }
              ),
            ),
          ),

          alignment: Alignment(1.1,-1),
        );
      },
      ),

    );
  }

}
