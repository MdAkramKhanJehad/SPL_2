import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  Widget build(BuildContext context) {
    return PlayAnimation<double>(
      tween: 0.0.tweenTo(100.0),
      duration: (0.3*delay).seconds,
      curve: Curves.easeOut,
      builder: (context, child, value) {
        return Container(
          width: value,
          height: value,
          // color: Colors.pink,
        );
      },
    );
  }

  //
  // @override
  // Widget build(BuildContext context) {
  //   final tween = MultiTrackTween([
  //     Track("opacity").add(Duration(milliseconds: 300), Tween(begin: 0.0, end: 1.0)),
  //     Track("translateY").add(
  //       Duration(milliseconds: 300), Tween(begin: -30.0, end: 0.0),
  //       curve: Curves.easeOut)
  //   ]);
  //
  //   return ControlledAnimation(
  //     delay: Duration(milliseconds: (300 * delay).round()),
  //     duration: tween.duration,
  //     tween: tween,
  //     child: child,
  //     builderWithChild: (context, child, animation) => Opacity(
  //       opacity: animation["opacity"],
  //       child: Transform.translate(
  //         offset: Offset(0, animation["translateY"]),
  //         child: child
  //       ),
  //     ),
  //   );
  // }
}