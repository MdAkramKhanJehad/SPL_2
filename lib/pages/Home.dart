import 'package:agridictionaryoffline/pages/AboutUs.dart';
import 'package:agridictionaryoffline/pages/Favourite.dart';
import 'package:agridictionaryoffline/pages/SearchPage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController;
  int pageIndex = 0;
  int counter = 1;

  onPageChanged(int index){
     FocusScope.of(context).unfocus();
     if(this.mounted){
       setState(() {
         pageIndex = index;
       });
     }
  }

  onTap(int index){
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.linearToEaseOut
    );
  }

  Widget _getNavBar(){
    return CurvedNavigationBar(
      index: pageIndex,
      animationCurve: Curves.linearToEaseOut,
      animationDuration: Duration(milliseconds: 400),
      height: 50,
      color: Colors.teal,
      buttonBackgroundColor: Colors.teal.shade700,
      backgroundColor: Colors.black12,
      items: <Widget>[
        Icon(Icons.search, size: 25, color: Colors.black,),
        Icon(Icons.favorite_border, size: 25,color: Colors.black,),
        Icon(Icons.info, size: 25, color: Colors.black,)
      ],
      onTap: onTap,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: PageView(
        children: <Widget>[
          SearchPage(),
          Favourite(),
          AboutUs(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: _getNavBar(),
    );
  }
}
