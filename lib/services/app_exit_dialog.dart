import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spl_two_agri_pro/main.dart';
class AppExitDialog extends StatefulWidget {

  @override
  _AppExitDialogState createState() => _AppExitDialogState();
}

class _AppExitDialogState extends State<AppExitDialog> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double heightMultiplier = height/712;
    double widthMultiplier= width/360;
    TextStyle titleStyle = TextStyle(
        fontFamily: "Mina",
        fontSize: 18*widthMultiplier,
        color: sharedObjectsGlobal.deepGreen,
        fontWeight: FontWeight.w700
    );
    TextStyle subTitleStyle = TextStyle(
        fontFamily: "Mina",
        fontSize: 14*widthMultiplier,
        color: Colors.white,
        fontWeight: FontWeight.w400
    );
    TextStyle ratioStyle = TextStyle(
        fontFamily: "Mina",
        fontSize: 16*widthMultiplier,
        color: Colors.white,
        fontWeight: FontWeight.w700
    );
    TextStyle buttonTextStyle = TextStyle(
        fontFamily: "Mina",
        fontSize: 16*widthMultiplier,
        color: Colors.white,
        fontWeight: FontWeight.w600
    );
    return Dialog(
      elevation: 7.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      insetAnimationCurve: Curves.bounceInOut,
      child: Stack(
        alignment: Alignment.topCenter,
        overflow: Overflow.visible,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20*widthMultiplier,vertical: 15*heightMultiplier),
            height: 200*heightMultiplier,
            width: 300*widthMultiplier,
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                color:Colors.white
            ),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 50*heightMultiplier,),
                  Text("Do You Want To Exit?",style: titleStyle,),
                  SizedBox(height: 20*heightMultiplier,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>SystemNavigator.pop(),
                          child: Container(
                            height: 40*heightMultiplier,
                            decoration: BoxDecoration(
                              color : Color(0xff0C653F),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow : [BoxShadow(
                                  color: Colors.black38,
                                  offset: Offset(0,3),
                                  blurRadius: 4
                              )],
                              //BoxShadow
                            ),
                            child: Center(child: Text("Yes",style: buttonTextStyle,)),
                          ),
                        ),
                      ),
                      SizedBox(width: 20*widthMultiplier,),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(false),
                          child: Container(
                            height: 40*heightMultiplier,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:  Color(0xff9B1010),
                              boxShadow : [BoxShadow(
                                  color: Colors.black38,
                                  offset: Offset(0,3),
                                  blurRadius: 4
                              )],
                              //BoxShadow
                            ),
                            child: Center(child: Text("No",style: buttonTextStyle,)),

                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Positioned(
              top:-60*widthMultiplier,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 60*widthMultiplier,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset('assets/images/app-main-logo.png',fit: BoxFit.cover,),
                ),
              )),
        ],
      ),
    );
  }
}
