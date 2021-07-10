import 'package:flutter/cupertino.dart';

class CustomPageRout extends PageRouteBuilder{
  final Widget widget;
  CustomPageRout({required this.widget})
      :super(
      transitionDuration: Duration(milliseconds: 350),
      reverseTransitionDuration: Duration(milliseconds: 350),
      transitionsBuilder: (context,Animation<double>animation,Animation<double>secAnimation,Widget child){
        Animation<Offset> custom = Tween<Offset>(begin: Offset(1.0,0.0),end: Offset(0.0,0.0)).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic)
        );
        return SlideTransition(position: custom,child: child,);
      },
      pageBuilder: (context,Animation<double>animation,Animation<double>secAnimation){
        return widget ;
      });


}