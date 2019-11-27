import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid/entitys/nav_result.dart';
import 'package:wanandroid/entitys/nav_result.dart';
import 'package:wanandroid/entitys/nav_result.dart';
import 'package:wanandroid/entitys/setup_result.dart';
import 'package:wanandroid/provider/system_provider.dart';
import 'package:wanandroid/provider/theme_color.dart';

class SystemUpWidget extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return SystemUpWidgetState();
  }

}

class SystemUpWidgetState extends State<SystemUpWidget> with SingleTickerProviderStateMixin
{
  TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController=TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeColorProvider>(builder: (context,colorProvider,child){

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: null,
          title: TabBar(
            indicatorColor: colorProvider.theme.computeLuminance()<0.5?Colors.white:Colors.black,
            tabs: <Widget>[
              Container(
                  padding: EdgeInsets.all(8),
                  child:Text("体系",style: TextStyle(color: colorProvider.theme.computeLuminance()<0.5?Colors.white:Colors.black),),
              ),
              Container(
                  padding: EdgeInsets.all(8),
                  child:Text("导航",style: TextStyle(color: colorProvider.theme.computeLuminance()<0.5?Colors.white:Colors.black),),
              ),
            ],
            controller: tabController,
          ),
        ),
        body: TabBarView(
            controller:tabController ,
            children: [
              SystemWidget(),
              NavWidget()
            ]
        ),
      );
    });

  }
}

class NavWidget extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return NavWidgetState();
  }

}

class NavWidgetState extends State<NavWidget>  with AutomaticKeepAliveClientMixin
{
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NavResult>(
      future: Provider.of<SystemProvider>(context).getNavData(),
      builder:(context,snap){
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
          return ListView.builder(
            //这儿必须要指定itemCount，要不然会越界
              itemCount: snap.data.data.length,
              itemBuilder: (context,index){
                return NavItemWidget(snap.data.data[index]);
              });
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

}

class NavItemWidget extends StatelessWidget
{
  final NavItem navItem;
  NavItemWidget(this.navItem);
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10,bottom: 10),
            child: Text(navItem.name),
          ),
          Wrap(
            children: navItem.articles.map((element){
              return Container(
                margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.black12
                ),
                child: Container(
                  child: Text(element.title),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

}













class SystemWidget extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return SystemWidgetState();
  }

}

class SystemWidgetState extends State<SystemWidget>  with AutomaticKeepAliveClientMixin
{
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SetupResult>(
      future: Provider.of<SystemProvider>(context).getSystemData(),
      builder:(context,snap){
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
          return ListView.builder(
            //这儿必须要指定itemCount，要不然会越界
              itemCount: snap.data.data.length,
              itemBuilder: (context,index){
                return SystemItem(snap.data.data[index]);
              });
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

}

class SystemItem extends StatelessWidget
{
  final SetupItem setupItem;
  SystemItem(this.setupItem);
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10,bottom: 10),
            child: Text(setupItem.name),
          ),
          Wrap(
            children: setupItem.children.map((element){
              return Container(
                margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.black12
                ),
                child: Container(
                  child: Text(element.name),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

}