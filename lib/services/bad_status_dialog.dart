import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spl_two_agri_pro/main.dart';
class BadStatusDialog extends StatefulWidget {
  const BadStatusDialog({Key? key}) : super(key: key);

  @override
  _BadStatusDialogState createState() => _BadStatusDialogState();
}

class _BadStatusDialogState extends State<BadStatusDialog> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double heightMultiplier = height/712;
    double widthMultiplier= width/360;
    TextStyle titleStyle = TextStyle(
        fontFamily: "Mina",
        fontSize: 20*widthMultiplier,
        color: sharedObjectsGlobal.errorColor,
        fontWeight: FontWeight.w800
    );
    TextStyle subtitleStyle = TextStyle(
        fontFamily: "Mina",
        fontSize: 12*widthMultiplier,
        color:Colors.black38,
        fontWeight: FontWeight.w500
    );

    TextStyle buttonTextStyle = TextStyle(
        fontFamily: "Mina",
        fontSize: 14*widthMultiplier,
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
            height: 250*heightMultiplier,
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

                  Text("Continue Without Signin?",textAlign: TextAlign.center,style: titleStyle,),

                  SizedBox(height: 20*heightMultiplier,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(true),
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
                            child: Center(child: Text("Yes Continue",style: buttonTextStyle,)),
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
                            child: Center(child: Text("Quit App",style: buttonTextStyle,)),

                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10*heightMultiplier,),
                  Text("Your account has been deleted for some unethical activity",textAlign: TextAlign.center,style: subtitleStyle,),
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
