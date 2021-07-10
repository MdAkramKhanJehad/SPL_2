import 'package:flutter/material.dart';
class NavbarItems extends StatefulWidget {
  @override
  _NavbarItemsState createState() => _NavbarItemsState();
}

class _NavbarItemsState extends State<NavbarItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Center(child: Text("Navigation Items")),
        ),
      ),
    );
  }
}
