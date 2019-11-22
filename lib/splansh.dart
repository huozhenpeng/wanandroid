import 'dart:async';

import 'package:flutter/material.dart';

class SplanshWidget extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return SplanshWidgetState();
  }

}


class SplanshWidgetState extends State<SplanshWidget> with TickerProviderStateMixin
{
  AnimationController _logoController;
  //控制加速度
  CurvedAnimation _curve;

  Animation<double> _animation;
  //Tween可以定义动画的起始结束值

  Size size;
  @override
  void initState() {
    super.initState();
    _logoController=AnimationController(vsync: this,duration: Duration(seconds: 1));
    _curve=CurvedAnimation(parent: _logoController, curve: Curves.easeInOutBack);
    _animation=Tween(begin: 0.0,end: 1.0).animate(_curve);

    _animation.addStatusListener((state){
      if(state==AnimationStatus.dismissed)
        {
          //反向结束
          _logoController.forward();
        }
      else if(state==AnimationStatus.completed)
        {
          //正向结束
          _logoController.reverse();
        }
    });

    //开启动画
    _logoController.forward();

  }
  @override
  void dispose() {
    _logoController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;
    return Container(
      child: Stack(
        children: <Widget>[
          Image.asset("images/launch_image.png",fit: BoxFit.fill,width: size.width,height: size.height,),
          AnimatedFlutterLogo(
          child:Image.asset("images/splash_flutter.png",fit: BoxFit.fill,width: 280,height: 120,),
          animation: _animation),
          Align(
            alignment: Alignment(0, 0.7),
            child: AnimatedAndroidLogo(animation: _animation,),
          ),
          Align(
            alignment: Alignment(0.9, 0.9),
            child: CountDownWidget(),
          )

        ],
      ),
    );
  }

}

///flutter字符动画：向下平移，触底抖动（像小球落地效果）
class AnimatedFlutterLogo extends AnimatedWidget
{
  final Widget child;
  final Animation<double> animation;
  AnimatedFlutterLogo({Key key,this.child,this.animation}):super(key:key,listenable:animation);

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
        alignment: Alignment(0, animation.value*0.4),
        duration: Duration(milliseconds: 10),
        //curve: Curves.bounceOut,
        child: child,
    );
  }
}

class AnimatedAndroidLogo extends AnimatedWidget {
  AnimatedAndroidLogo({
    Key key,
    Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'images/splash_fun.png',
          width: 140 * animation.value,
          height: 80 * animation.value,
        ),
        Image.asset(
          'images/splash_android.png',
          width: 200 * (1 - animation.value),
          height: 80 * (1 - animation.value),
        ),
      ],
    );
  }
}

///倒计时
class CountDownWidget extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {

    return CountDownWidgetState();
  }

}

class CountDownWidgetState extends State<CountDownWidget>
{
  Timer _timer;
  int _time=3;
  @override
  void initState() {
    super.initState();
    startCountdownTimer();
  }
  @override
  Widget build(BuildContext context) {

    return DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius:BorderRadius.all(Radius.circular(12)),
    ),
      child: Container(
        padding: EdgeInsets.fromLTRB(14, 3, 14, 3),
        child: InkWell(
           child: Text("$_time | 跳过",style: TextStyle(color: Colors.white),),
          onTap: (){

          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startCountdownTimer()
  {
    _timer=Timer.periodic(Duration(seconds: 1), (timer){
      if(_time<1)
        {
          timer.cancel();
        }
      else
        {
          _time=_time-1;
          setState(() {

          });
        }

    });
  }

}