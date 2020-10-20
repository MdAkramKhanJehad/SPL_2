import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter/material.dart';


PreferredSize header(BuildContext context, String title){
  return PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: ClipShadow(
      clipper: CustomAppBar(),
      boxShadow: [BoxShadow(
        color: Colors.blueGrey, blurRadius:10, spreadRadius: 5, offset:Offset(0.0,0.8)
      )],
      child: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: "Fenix",
                    fontWeight: FontWeight.bold,
                    fontSize: 31
                  ),
                ),

              ],
            ),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.teal.shade200,
                Colors.teal.shade400,
              ]
            ),
          ),
//        child: ,
        ),
      ),
    ),
  );
}


AppBar appBar(BuildContext context, String title){
  return AppBar(
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
        fontSize: 31,
        fontFamily: 'Kreon',
        color: Colors.black87,
        fontWeight: FontWeight.bold
      ),
    ),
    backgroundColor: Colors.teal.shade400,
    elevation: 1,
  );
}

class CustomAppBar extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

}