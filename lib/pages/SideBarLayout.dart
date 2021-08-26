import 'package:agridictionaryoffline/pages/Home.dart';
import 'package:flutter/material.dart';
import 'SideBar.dart';

class SideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Home(),
          SideBar(),
        ],
      ),
    );
  }
}
