import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spl_two_agri_pro/login_signup/login.dart';
import 'package:spl_two_agri_pro/main.dart';
import 'package:spl_two_agri_pro/services/timer.dart';
import 'package:spl_two_agri_pro/login_signup/otp_page.dart';
class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String errorText="";
  TextEditingController textEditingController=TextEditingController();
  bool isContinueButtonTappedOneTime=true;
  checkUserNumber(String userNumber){
    String pattern =r'(^(?:01[3-9])?[0-9]{8}$)';
    RegExp regExp = new RegExp(pattern);

    if (userNumber.length == 0) {
      setState(() {
        errorText = "Please enter mobile number";
      });
      return false;
    }
    else if (regExp.hasMatch(userNumber)){
      setState(() {
        //errorText =null;
        errorText = "";
      });
      return true;
    }else{
      setState(() {
        errorText = "Invalid mobile number";
      });
      return false ;
    }

  }
  getUsersCredentials(String phoneNumber)async{
    FirebaseFirestore.instance.collection('users').doc(phoneNumber).get().then((userDoc){
      if(!userDoc.exists){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>ChangeNotifierProvider(
          child:  OTPPage(phoneNumber: phoneNumber,isSignup: true,password: "",),
          create: (context)=>TimerInfo(time:60 ),
        )));
      }else{
        setState(() {
          errorText = "You already have an account!\nGo to login page and do login";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height =sharedObjectsGlobal.mobilePortraitHeight;
    final double width = sharedObjectsGlobal.mobilePortraitWidth;
    double heightMultiplier =sharedObjectsGlobal.heightMultiplier;
    double widthMultiplier= sharedObjectsGlobal.widthMultiplier;

    return Scaffold(
      body:  SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          margin: EdgeInsets.only(left: 30*widthMultiplier,right: 30*widthMultiplier,bottom: 50*heightMultiplier),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Sign Up', textAlign: TextAlign.left, style: TextStyle(
                  fontFamily: 'Mina',
                  fontSize: 30*widthMultiplier,
                  letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.bold,
                  height: 1
              ),),
              SizedBox(height: 30*heightMultiplier,),
              Text('Enter Your Mobile Number', textAlign: TextAlign.left, style: TextStyle(
                  fontFamily: 'Mina',
                  fontSize: 22*widthMultiplier,
                  letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.w800,
                  height: 1
              ),),
              SizedBox(height:30*heightMultiplier,),
              Container(
                height: 50*heightMultiplier,
                margin: EdgeInsets.only(left: 25*widthMultiplier,right: 10*widthMultiplier),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text("+88", style: TextStyle(
                            fontFamily: 'Mina',
                            fontSize: 18*widthMultiplier,
                            letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.bold,
                            height: 1
                        )),
                      ),
                    ),
                    SizedBox(width: 10*widthMultiplier,),
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.only(left: 10*widthMultiplier),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color:Colors.black, ),
                        ),
                        child: TextField(
                          style: TextStyle(
                              color:  Colors.black,
                              fontFamily: 'Mina',
                              fontSize: 15*widthMultiplier,
                              letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.bold,
                              height: 1
                          ),
                          cursorColor: Colors.black26,
                          controller: textEditingController,
                          keyboardType: TextInputType.phone,

                          decoration: InputDecoration(
                            border: InputBorder.none,
                              hintText: "Mobile Number",hintStyle: TextStyle(fontWeight: FontWeight.normal,fontSize: 11*widthMultiplier,fontFamily: "Mina")
                          ),

                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10*heightMultiplier,),
              errorText==null? Container(): Center(
                child: Container(
                  child: Text(errorText,textAlign: TextAlign.center,style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,fontSize: 12*widthMultiplier,
                  ),),
                ),
              ),
              SizedBox(height: 30*heightMultiplier,),
              GestureDetector(
                onTap: (){
                  if(isContinueButtonTappedOneTime){
                    isContinueButtonTappedOneTime = false;
                    Timer(Duration(seconds: 3),(){
                      isContinueButtonTappedOneTime=true;
                    });
                    String userNumber = textEditingController.text.trim();
                    errorText= "";
                    if(checkUserNumber(userNumber)){
                      userNumber="+88"+userNumber;
                      getUsersCredentials(userNumber);

                    }
                  }
                },
                child: Container(
                  width: width,
                  height: 57*heightMultiplier,
                  decoration: BoxDecoration(
                    borderRadius : BorderRadius.circular(13),
                    boxShadow : [BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        offset: Offset(0,3),
                        blurRadius: 4
                    )],
                    color : sharedObjectsGlobal.deepGreen
                  ),
                  child: Center(
                    child: Text('Continue', textAlign: TextAlign.left, style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Mina',
                        fontSize: 24*heightMultiplier,
                        letterSpacing: 0 ,
                        fontWeight: FontWeight.bold,
                        height: 1
                    ),),
                  ),
                ),
              ),
              SizedBox(height: 20*heightMultiplier,),
              Container(
                child: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: "Already have an account?",style: TextStyle(
                          fontFamily: 'Mina',
                          color: Colors.black45,
                          fontSize: 12*widthMultiplier,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold,
                          height: 1
                      ),),
                      TextSpan(text: "Login",style: TextStyle(
                          color: sharedObjectsGlobal.limeGreen,
                          fontFamily: 'Mina',
                          fontSize: 15*widthMultiplier,
                          letterSpacing: 0 ,
                          fontWeight: FontWeight.w700,
                          height: 1
                      ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('login');
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>Login()));
                            }),
                    ]
                )),
              ),
            ],
          ) ,
        )
      ),
    );
  }

}

