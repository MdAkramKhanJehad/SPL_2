import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity").add(Duration(milliseconds: 300), Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(
        Duration(milliseconds: 300), Tween(begin: -30.0, end: 0.0),
        curve: Curves.easeOut)
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (300 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
          offset: Offset(0, animation["translateY"]),
          child: child
        ),
      ),
    );
  }
}









//import 'package:flutter/material.dart';
//import 'package:simple_animations/simple_animations.dart';
//import 'package:supercharged/supercharged.dart';
//
//enum MyAniPropsEnum{
//   opacity, translateY
//}
//
//class FadeAnimation extends StatelessWidget {
//  final double delay;
//  final Widget child;
//
//  FadeAnimation(this.delay, this.child);
//
//  @override
//  Widget build(BuildContext context) {
////    final tween = MultiTrackTween([
////      Track("opacity").add(Duration(milliseconds: 300), Tween(begin: 0.0, end: 1.0)),
////      Track("translateY").add(
////        Duration(milliseconds: 300), Tween(begin: -30.0, end: 0.0),
////        curve: Curves.easeOut)
////    ]);
//
//    final tween = MultiTween<MyAniPropsEnum>()
//      ..add(MyAniPropsEnum.opacity, 0.0.tweenTo(1.0), 300.milliseconds)
//      ..add(MyAniPropsEnum.translateY, (-30.0).tweenTo(0.0), 300.milliseconds
//      );
//
//    return PlayAnimation(
//      delay: Duration(milliseconds: (300 * delay).round()),
//      duration: tween.duration,
//      tween: tween,
//      child: child,
//      builder: (context, child, animation) => Opacity(
//        opacity: MyAniPropsEnum.opacity,
//        child: Transform.translate(
//          offset: Offset(0, animation["translateY"]),
//          child: child
//        ),
//      ),
//    );
//  }
//}