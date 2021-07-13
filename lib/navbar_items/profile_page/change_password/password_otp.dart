import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:spl_two_agri_pro/main.dart';
import 'package:spl_two_agri_pro/navbar_items/profile_page/change_password/change_password.dart';
import 'package:spl_two_agri_pro/services/customPageRoute.dart';
import 'package:spl_two_agri_pro/services/timer.dart';
class PasswordOTP extends StatefulWidget {
  @override
  _PasswordOTPState createState() => _PasswordOTPState();
}

class _PasswordOTPState extends State<PasswordOTP> {
  String _code="",errorText="",verificationIdFromCodeSent="";
  late Timer timer;
  late TimerInfo   timerInfo;

  @override
  void initState() {
    super.initState();
    listenSmsCode();
    loginUser(sharedObjectsGlobal.userGlobal.phone_number);
    timerInit();
  }
  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    timer.cancel();
    super.dispose();
  }
  listenSmsCode() async {
    await SmsAutoFill().listenForCode;
  }
  timerInit(){
    timerInfo =Provider.of<TimerInfo>(context,listen: false);

    timer =  Timer.periodic(Duration(seconds: 1), (Timer t) {

      timerInfo.updateTimer();
    });
  }
  onCodeSent(String code)async{
    try{
      PhoneAuthCredential credential= PhoneAuthProvider.credential(verificationId: verificationIdFromCodeSent, smsCode:code);
      UserCredential userCredential =await  sharedObjectsGlobal.firebaseAuth.signInWithCredential(credential);

      if(userCredential.user!=null){
        User? firebaseUser = userCredential.user;
        timer.cancel();
        Navigator.push(context,CustomPageRout(widget: ChangePassword()));
      }else{
        setState(() {
          errorText = "Something went wrong.Try again please!";
        });
      }
    }catch(e){
      setState(() {
        errorText = "Invalid Otp number";
      });
      print("In try catch catch in Receive Otp Page");
      e.toString();
    }
  }
  loginUser(String phone)async{
    sharedObjectsGlobal.firebaseAuth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential authCredentials)async{

        try{
          UserCredential userCredential =await  sharedObjectsGlobal.firebaseAuth.signInWithCredential(authCredentials);
          User? firebaseUser = userCredential.user;
          timer.cancel();
          Navigator.push(context,CustomPageRout(widget: ChangePassword()));

        }catch(e){
          errorText = "Something wrong happened.Try again";
        }
      },
      verificationFailed: (FirebaseAuthException exception){

        setState(() {
          errorText = "Temporary Blocked All Request From This Device For Unusual Activity.Try Sometimes later";
        });
        print(exception);
      },
      codeSent: ( String verificationId, int? forceResendingToken) async {
        print("code sent");
        verificationIdFromCodeSent = verificationId;
      },
      codeAutoRetrievalTimeout:(String verificationId){
      } ,
    );
  }
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    double heightMultiplier = height/712;
    double widthMultiplier= width/360;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("OTP",style: sharedObjectsGlobal.appBarTitleStyle,),
          leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 18*widthMultiplier ,),
            onPressed: (){
              Navigator.pop(context);
            },),
        ),
        body: Container(
          height: height,
          width: width,//,vertical: 50*heightMultiplier
          margin: EdgeInsets.only(left: 30*widthMultiplier,right: 30*widthMultiplier,bottom: 50*heightMultiplier),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text('Verification Code', textAlign: TextAlign.center, style: sharedObjectsGlobal.bodyTitleStyle,),
              ),
              SizedBox(height: 25*heightMultiplier,),
              Text('Please type the verification code sent to your phone ${sharedObjectsGlobal.userGlobal.phone_number}',
                textAlign: TextAlign.center, maxLines: 6,style: sharedObjectsGlobal.bodySubtitleStyle,),
              SizedBox(height: 40*heightMultiplier,),
              errorText!=""? Container(
                child: Text(errorText,textAlign: TextAlign.center,
                  style: sharedObjectsGlobal.errorTextStyle,),)
                  :Container(),
              PinFieldAutoFill(
                decoration: UnderlineDecoration(
                  textStyle: TextStyle(fontSize: 20, color: Colors.black),
                  colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
                ),
                currentCode: _code,
                onCodeSubmitted: (code) {},
                onCodeChanged: (code) {
                  if (code!.length == 6) {
                    FocusScope.of(context).requestFocus(FocusNode());

                    onCodeSent(code);
                  }
                },
              ),
              SizedBox(height: 40*heightMultiplier,),
              Consumer<TimerInfo>(
                builder: (context,data,_){

                  if(data.isTimeUp){
                    timer.cancel();

                  }
                  return Center(child: Text('${data.getShowTime()}',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12*widthMultiplier,
                    color: sharedObjectsGlobal.limeGreen,
                    fontFamily: "Mina",
                  ),),);
                },
              ),

            ],
          ) ,
        )
    );
  }
}
