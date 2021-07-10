import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:spl_two_agri_pro/login_signup/otp_page.dart';
import 'package:spl_two_agri_pro/login_signup/signup.dart';
import 'package:spl_two_agri_pro/main.dart';
import 'package:spl_two_agri_pro/services/timer.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String errorText="";
  TextEditingController phoneNumberController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
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
      if(userDoc.exists){
        final password = userDoc['password'];
        final encrypted = Crypt.sha256(passwordController.text.trim(), rounds: 10000, salt: dotenv.env['ENCRYPT']);
        password == encrypted.toString() ?   Navigator.push(context,MaterialPageRoute(builder: (context)=>ChangeNotifierProvider(
          child:  OTPPage(phoneNumber: phoneNumber,isSignup: false,password: password,),
          create: (context)=>TimerInfo(time:60 ),
        )))
            :  setState(() {
          errorText = "Phone number or password is invalid!";
        });

      }else{
        setState(() {
          errorText = "Tou don't have any account!\nGo to signup for creating account.";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    double heightMultiplier = height/712;
    double widthMultiplier= width/360;

    TextStyle fieldName = TextStyle(
        color: Colors.black,
        fontFamily: 'Mina',
        fontSize: 16*widthMultiplier,
        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
        fontWeight: FontWeight.w700,
        height: 1
    );
    TextStyle fieldValue =  TextStyle(
      fontFamily: 'Mina',
      fontSize: 18*widthMultiplier,
      letterSpacing: 0 ,
      fontWeight: FontWeight.w500,
      height: 1,
      color: Colors.black,
    );

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
                Text('Login', textAlign: TextAlign.left, style: TextStyle(
                    fontFamily: 'Mina',
                    fontSize: 30*widthMultiplier,
                    letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.bold,
                    height: 1
                ),),
                SizedBox(height: 30*heightMultiplier,),
                Text('Enter Login Credentials', textAlign: TextAlign.left, style: TextStyle(
                    fontFamily: 'Mina',
                    fontSize: 22*widthMultiplier,
                    letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.w800,
                    height: 1
                ),),
                SizedBox(height:15*heightMultiplier,),
                Container(
                  height: 50*heightMultiplier,
                  margin: EdgeInsets.only(left: 25*widthMultiplier,right: 10*widthMultiplier),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerRight,
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
                              height: 1,

                            ),
                            cursorColor: Colors.black26,
                            controller: phoneNumberController,
                            keyboardType: TextInputType.phone,

                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Mobile Number",hintStyle: TextStyle(fontWeight: FontWeight.normal,fontSize: 11*widthMultiplier,fontFamily: "Mina")

                              //   errorText: errorText,errorMaxLines: 3,
                              // errorStyle: TextStyle(
                              //   fontFamily: "Mina",color: Colors.red,
                              //   fontWeight: FontWeight.w600,fontSize: 16*widthMultiplier,
                              // )
                            ),

                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height:15*heightMultiplier,),
                Container(
                  height: 50*heightMultiplier,
                  margin: EdgeInsets.only(left: 25*widthMultiplier,right: 10*widthMultiplier),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Icon(FontAwesomeIcons.lock),
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
                              height: 1,

                            ),
                            cursorColor: Colors.black26,
                            controller: passwordController,
                            keyboardType: TextInputType.text,

                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",hintStyle: TextStyle(fontWeight: FontWeight.normal,fontSize: 11*widthMultiplier,fontFamily: "Mina")
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10*heightMultiplier,),
                errorText==""? Container(): Center(
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
                      String userNumber = phoneNumberController.text.trim();
                      errorText= "";
                      if(checkUserNumber(userNumber)){
                        userNumber="+88"+userNumber;
                        getUsersCredentials(userNumber);




                        //  Navigator.push(context,CustomPageRout(widget: OTP(phoneNumber: userNumber, isSignup: true, password: '')));
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
                        TextSpan(text: "Are you new here?",style: TextStyle(
                            fontFamily: 'Mina',
                            color: Colors.black45,
                            fontSize: 12*widthMultiplier,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                            height: 1
                        ),),
                        TextSpan(text: "Signup",style: TextStyle(
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
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>Signup()));
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
