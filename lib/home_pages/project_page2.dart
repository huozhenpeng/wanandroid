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
    return Scaffold(
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
//      body: TabVarViewWidget(),
    );
  }

}


class TabVarViewWidget extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Consumer3<ThemeColorProvider,ProjectProvider,ProjectControllerProvider>(builder: (context,colorProvider,projectProvider,controller,child){
      return TabBarView(
          controller: controller.tabController,
          children: projectProvider.data.map((projectItem){
            return CusListView(projectItem);
          }).toList());

    });
  }

}

class CusListView extends StatelessWidget
{
  CusListView(this.projectItem);
  final ProjectItem projectItem;
  int page=0;

  @override
  Widget build(BuildContext context) {
    print("listvie build.......");

    return FutureBuilder<List<ItemData>>(
        future: Provider.of<ProjectProvider>(context).getListDatas(page, projectItem.id),
        builder: (context,snapshot)
            {
              if(snapshot.hasData)
                {
                  return Center(
                    child: Text("加载中"),
                  );
                }
              else
                {
                  return ListView(
                    children: snapshot.data.map((element){
                      return Text(element.title);
                    }).toList(),
                  );
                }
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
  TabController tabController;
  ProjectControllerProvider projectControllerProvider;

  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    print("TabBarWidget build.............");
    projectControllerProvider=Provider.of<ProjectControllerProvider>(context,listen: false);
    return Consumer2<ThemeColorProvider, ProjectProvider>(
          builder: (context, colorProvider, projectProvider,child) {
            print("Consumer2 build.............");
            ///我需要监听的是projectProvider.data的改变，变化了，我就得重新构建tabController
            tabController=TabController(length: projectProvider.data.length, vsync: this);
            projectControllerProvider.tabController=tabController;
            return Container(
              margin: EdgeInsets.only(right: 25),
              //这个应该是设置完全不透明，用于遮挡上面的控件
              color: colorProvider.theme.withOpacity(1),
              child:TabBar(
                indicatorColor: colorProvider.theme.computeLuminance()<0.5?Colors.white:Colors.black,
                //必需加上这个属性
                isScrollable: true,
                controller: tabController,
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

    return Consumer2<ThemeColorProvider,ProjectProvider>(builder: (context,colorProvider,projectProvider,child){
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
                      child: Text(element.name),
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
    );

  }

}

