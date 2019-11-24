import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid/provider/theme_color.dart';
import 'package:wanandroid/provider/theme_mode.dart';

class LoginWidget extends StatelessWidget
{
  Size size;
  ThemeData theme;
  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;
    theme=Theme.of(context);
    //这儿最好不要再嵌套MaterialApp了，要不然下面寻找theme的时候，就是从这儿取值了，而不是入口处
      return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              BottomLayerWidget(size),

              Container(
                margin: EdgeInsets.only(top: 80),
                alignment: Alignment.topCenter,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      "images/login_logo.png",
                      width: 130,
                      height: 100,
                      colorBlendMode: BlendMode.srcIn,
                      color: theme.brightness == Brightness.dark
                          ? theme.accentColor
                          : Colors.white,
                    ),
                    LoginBoxWidget(),
                    OtherLoginWidget()
                  ],
                ),
              )

            ],
          ),
        ),
      );
  }
}
class OtherLoginWidget extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(top: 30),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.black26,
                height: 0.6,
                width: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("第三方登陆",
                    style: TextStyle(color: Colors.black45)),
              ),
              Container(
                color: Colors.black26,
                height: 0.6,
                width: 60,
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset("images/logo_wechat.png",width: 40,height: 40,),
                Image.asset("images/logo_weibo.png",width: 40,height: 40,),
              ],
            ),
          )
          
        ],

      ),
    );
  }

}

///Form的子孙元素必须是TextFormField
class CustomEditWidget extends StatefulWidget
{
  Function  validator;
  Function onSaved;
  Icon prefixIcon;
  String hintText;

  bool clearShow=true;//true显示
  bool passwordShow=true;
  CustomEditWidget(this.validator,this.onSaved,this.prefixIcon,this.hintText,this.passwordShow);


  @override
  State<StatefulWidget> createState() {
    return CustomEditWidgetState();
  }

}

class CustomEditWidgetState extends State<CustomEditWidget>
{
  TextEditingController textEditingController;

  bool passwordStatus=false;//控制是否密码显示
  @override
  void initState() {
    super.initState();
    //为什么要controller，因为要针对单个输入框做清除操作
    textEditingController=TextEditingController();
  }
  @override
  Widget build(BuildContext context) {

    return TextFormField(
      obscureText: widget.passwordShow?false:(passwordStatus),
      controller: textEditingController,
      validator: widget.validator,//验证回调
      onSaved: widget.onSaved,//保存回调
      onChanged: (content)
      {
        if(content.isEmpty)
          {
            if(!widget.clearShow)
              {
                widget.clearShow=true;
                setState(() {});
              }
          }
        else
          {
            if(widget.clearShow)
              {
                widget.clearShow=false;
                setState(() {});
              }

          }

      },//内容改变回调
      textInputAction: TextInputAction.next,
      autofocus: true,
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue,width: 1),
          ),
          // 未获得焦点下划线设为灰色
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey,width: 1),
          ),
          prefixIcon: widget.prefixIcon,
          hintText: widget.hintText,
          suffixIcon: Row(
            //一定要加这行代码
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Offstage(
                offstage: widget.passwordShow,
                child: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: passwordStatus?Colors.blue:Colors.black26,
                  ),
                  onPressed: (){
                    setState(() {
                      passwordStatus=!passwordStatus;
                    });
                  },
                ),
              ),
              Offstage(
                offstage: widget.clearShow,
                child: IconButton(
                  icon: Icon(Icons.clear,color:Colors.black26,),
                  onPressed: (){
                    //textEditingController.clear();为什么不直接调用呢，因为虽然也可以删除，但是有异常抛出
                    WidgetsBinding.instance.addPostFrameCallback((_) => textEditingController.clear());
                    widget.clearShow=true;
                    setState(() {});
                  },
                ),
              )
              //Icon(Icons.clear),
            ],
          )
        //suffixIcon: Icon(Icons.clear)
      ),
    );
  }

}

class LoginBoxWidget extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return LoginBoxWidgetState();
  }

}
///在from表单中使用key，必须是在有状态的控件中才行，要不然键盘不停的弹出消失
class LoginBoxWidgetState extends State<LoginBoxWidget>
{
  GlobalKey _formKey= new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeColorProvider,ThemeModeProvider>(builder: (context,colorProvider,modeProvider,child){
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: DecoratedBox(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: colorProvider.theme..withAlpha(200),//价格透明度，太亮了
                    offset: Offset(1.0, 1.0),
                    blurRadius: 10.0,
                    spreadRadius: 3.0
                )
              ],
              color: Colors.white
          ),

          child: Container(
            height: 260,
            width: 300,
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      CustomEditWidget(
                              (v){
                            return v
                                .trim()
                                .length > 0 ? null : "用户名不能为空";
                          },
                              (v){

                          },
                          Icon(Icons.person),
                          "用户名",true),
                      CustomEditWidget(
                              (v){

                          },
                              (v){

                          },
                          Icon(Icons.lock),
                          "密码",false),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(10,45,10,0),
                    width: double.infinity,
                    height: 35,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: colorProvider.theme,
                        borderRadius:BorderRadius.all(Radius.circular(17)),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(14, 3, 14, 3),
                        child: InkWell(
                          child: Text("登陆",style: TextStyle(color: modeProvider.themeMode== Brightness.dark
                              ? modeProvider.color
                              : Colors.white,),),
                          onTap: (){
                          if((_formKey.currentState as FormState).validate()){
                            //验证通过提交数据
                          }
                          },
                        ),
                      ),
                    )
                ),

                Container(
                  margin: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: Text.rich(
                      TextSpan(
                          children: [
                            TextSpan(
                                text: "还没账号？"
                            ),
                            TextSpan(
                              text: "去注册",
                              style: TextStyle(
                                  color: colorProvider.theme
                              ),
                              recognizer: TapGestureRecognizer()..onTap = (){
                                print("去注册");
                              },
                            )

                          ]
                      )
                  ),
                )

              ],
            ),
          ),

        ),
      );
    });
  }

}

//这儿如果没有加这个Path泛型，赋值会报错
class MyCustomerClip extends CustomClipper<Path>
{

  //注意这个size是谁的size
  //就是上面的child的width
  @override
  getClip(Size size) {
    print("width:${size.width},height:${size.height}");
    Path path=Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height-50);
    path.quadraticBezierTo(size.width/2, size.height, size.width, size.height-50);
    //path.lineTo(size.width, size.height-50);这句不用写
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }

}

///最底层的布局
class BottomLayerWidget extends StatelessWidget
{
  Size size;
  BottomLayerWidget(this.size);
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeColorProvider>(builder: (context,themeColor,child) {
      return ClipPath(
        clipper: MyCustomerClip(),
        child: Container(
          color: themeColor.theme,
          height: 300,
          width: size.width,
          //注意这个值
          alignment: Alignment.center,
        ),
      );
    });
  }

}