import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spl_two_agri_pro/models/user.dart';

class SharedObjects{
  Color deepGreen = Color(0xff27462A);
  Color lightGreen = Color(0xffDBF3D2);
  Color limeGreen = Color(0xff59A514);
  Color errorColor = Color(0xff9B1010);
  Widget circularProgressCustomize = CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Color(0xff59A514)),);
  double mobilePortraitHeight=0.0,mobilePortraitWidth=0.0 ;
  FirebaseAuth firebaseAuth =FirebaseAuth.instance;
  double heightMultiplier= 0.0,widthMultiplier = 0.0,areaMultiplier=0.0;
  late AppUser userGlobal ;
  bool userSignIn = false;
  String userDefaultImage =  "https://firebasestorage.googleapis.com/v0/b/agri-pro-ccc60.appspot.com/o/shared_photos%2Fuser.png?alt=media&token=ba3de876-3a5a-41ff-974b-2d81fcd4dee9";
  late TextStyle appBarTitleStyle, bodyTitleStyle, bodySubtitleStyle, bodyNormalTextStyle, bodyCaptionStyle, errorTextStyle;
  List<String> crops=[
    "Apple","Onion","Olive","Papaya","Pear","Peach","Mango"
        "Apricot","Banana","Jackfruit","Barley","Bean","Brinjal",'Cabbage','Canola','Carrot','Cherry',
    'Cucumber', "Cotton", "Grape", "Ginger", "Garlic",
  ];
}