import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';


class SharedFunctions{

  getBackgroundImage(BuildContext context){
    return  Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/login_page_background.png"),
              fit: BoxFit.cover
          )
      ),
    );
  }
  getMainPageBackgroundImage(){
    return Container(
      height:   sharedObjectsGlobal.mobilePortraitHeight,
      width: sharedObjectsGlobal.mobilePortraitWidth,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home-page-bg.png'),
            fit: BoxFit.cover,
          )
      ),
    );
  }

  getMobileHeightWeight(BoxConstraints constraints){
    sharedObjectsGlobal.mobilePortraitHeight = constraints.maxHeight;
    sharedObjectsGlobal.mobilePortraitWidth = constraints.maxWidth;
    sharedObjectsGlobal.heightMultiplier = constraints.maxHeight/712.0;
    sharedObjectsGlobal.widthMultiplier = constraints.maxWidth/360.0;
    sharedObjectsGlobal.areaMultiplier = (constraints.maxHeight/712.0)*(360.0/constraints.maxWidth);
    setTestStyles();
  }

  setTestStyles(){
    TextStyle optionsTextStyle=TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 12*sharedObjectsGlobal.widthMultiplier,
      color: Colors.black,
      fontFamily: "Mina",
    );
    sharedObjectsGlobal.appBarTitleStyle = TextStyle(fontFamily: "Mina",fontSize:20*sharedObjectsGlobal.widthMultiplier ,fontWeight:FontWeight.w700 ,color: Colors.black);
    sharedObjectsGlobal.bodyTitleStyle = TextStyle(fontFamily: "Mina",fontSize:24*sharedObjectsGlobal.widthMultiplier ,fontWeight:FontWeight.bold ,color: Colors.black);
    sharedObjectsGlobal.bodySubtitleStyle = TextStyle(fontFamily: "Mina",fontSize:18*sharedObjectsGlobal.widthMultiplier ,fontWeight:FontWeight.w600 ,color: Colors.black);
    sharedObjectsGlobal.bodyNormalTextStyle = TextStyle(fontFamily: "Mina",fontSize:15*sharedObjectsGlobal.widthMultiplier ,fontWeight:FontWeight.w500 ,color: Colors.black);
    sharedObjectsGlobal.bodyCaptionStyle = TextStyle(fontFamily: "Mina",fontSize:12*sharedObjectsGlobal.widthMultiplier ,fontWeight: FontWeight.w500,color: Colors.black);
    sharedObjectsGlobal.errorTextStyle = TextStyle(fontSize: 11*sharedObjectsGlobal.widthMultiplier,fontWeight: FontWeight.w700, color: Colors.red,fontFamily: "Mina");
  }
}