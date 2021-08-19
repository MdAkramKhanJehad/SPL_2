import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spl_two_agri_pro/main.dart';
import 'package:spl_two_agri_pro/navbar_items/home_page/home_page.dart';
import 'package:spl_two_agri_pro/navbar_items/profile_page/profile_page.dart';
import 'package:spl_two_agri_pro/navbar_items/q_a_page/q_a_page.dart';
import 'package:spl_two_agri_pro/services/app_exit_dialog.dart';
class NavbarItems extends StatefulWidget {
  @override
  _NavbarItemsState createState() => _NavbarItemsState();
}

class _NavbarItemsState extends State<NavbarItems> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  int _pageIndex=0;
  PageController  pageController=PageController();
  onPageChange(int pageIndex){
    setState(() {
      this._pageIndex=pageIndex;
    });
  }
  onTap(int pageIndex){
    pageController.animateToPage(pageIndex,
      duration: Duration(microseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<bool> _onWillPop() async {

    return await showDialog(context: context,
        builder: (context)=>AppExitDialog()
    )?? false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        body: PageView(
          children: <Widget>[
            HomePage(),
            QAPage(),
            ProfilePage(),
          ],
          controller: pageController,
          onPageChanged: onPageChange,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: CupertinoTabBar(
          // backgroundColor: Theme.of(context).accentColor,
          currentIndex: _pageIndex,
          backgroundColor: Colors.white,
          onTap: onTap,
          activeColor: sharedObjectsGlobal.educationGreen,
          inactiveColor: Color(0xffACADAC),
          items: [
            BottomNavigationBarItem( icon:Icon(FontAwesomeIcons.home) ),
            BottomNavigationBarItem( icon:Icon(FontAwesomeIcons.quora), ),
            BottomNavigationBarItem( icon:Icon(FontAwesomeIcons.user), ),
          ],
        ),
      ),
    );
  }
}
