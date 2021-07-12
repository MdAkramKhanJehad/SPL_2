
/*import 'package:agri_pro/home_section/home_page.dart';
import 'package:agri_pro/splash_screen.dart';
import 'package:flutter/material.dart';

class QuestionUploadedSuccessfulDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 7.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      insetAnimationCurve: Curves.bounceInOut,
      child: Stack(
        alignment: Alignment.topCenter,
        overflow: Overflow.visible,
        children: [
          Container(
            height: 250,
            width: 300,
            decoration: new BoxDecoration(
              color: constant.appbarBackgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Your Question Successfully Uploaded!!!",style: TextStyle(
                fontSize: 15,
                fontFamily: "Mina",
                color: Colors.white,
                fontWeight: FontWeight.w500,

              ),),
                GestureDetector(
                  onTap: ()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage())),
                  child: Container(child: Text("Okay",style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Mina",
                    color: Colors.white,
                    fontWeight: FontWeight.w700,

                  ),),),
                )
              ],
            ),
          ),

          Positioned(
              top:-50,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset('assets/img/app-main-logo',fit: BoxFit.cover,),
                ),
              ))
        ],
      ),

    );
  }
}
*/
