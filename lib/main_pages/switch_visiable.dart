import 'package:flutter/material.dart';

class SwitchVisible extends StatelessWidget
{
  final Widget child;
  final bool isShow;
  SwitchVisible(this.child,this.isShow);
  @override
  Widget build(BuildContext context) {
    return ScaleAnimatedSwitch(isShow?child:SizedBox.shrink());
  }

}

///他的原理就是在新widget和旧widget变化之间运用这个动画
///比如说开始是child 后来是SizeBox.shrink()
class ScaleAnimatedSwitch extends StatelessWidget
{
  final Widget child;
  ScaleAnimatedSwitch(this.child);
  
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 100),
      child: child,
      transitionBuilder: (widget,animation){
        return ScaleTransition(scale: animation,child: widget,);
      },
    );
  }
  
}