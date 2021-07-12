import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spl_two_agri_pro/main.dart';
import 'package:spl_two_agri_pro/navbar_items/navbar_items.dart';
import 'package:spl_two_agri_pro/services/customPageRoute.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  
  TextEditingController  otpCntrl= TextEditingController();
  TextEditingController  currentPasswordCntrl= TextEditingController();
  TextEditingController  newPasswordCntrl= TextEditingController();
  TextEditingController  reEnterPasswordCntrl= TextEditingController();
  late String otpErr = "",currentPasswordErr = "" ,newPasswordErr = "", reEnterPasswordErr = "";
  int i =0;
  late String verificationIdFromCodeSent;

  loginUser(String phone)async{
    sharedObjectsGlobal.firebaseAuth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential authCredentials)async{
        try{
          UserCredential userCredential =await  sharedObjectsGlobal.firebaseAuth.signInWithCredential(authCredentials);
          User? firebaseUser = userCredential.user;
          Navigator.pop(context);

        }catch(e){
          setState(() {
            otpErr = "Something wrong happened.Try again";
          });
        }
      },
      verificationFailed: (FirebaseAuthException exception){
        setState(() {
         otpErr = "Temporary Blocked All Request From This Device For Unusual Activity.Try Sometimes later";
        });
        print(exception);
      },
      codeSent: ( String verificationId, int? forceResendingToken) async {
        print("code sent");
        verificationIdFromCodeSent = verificationId;
      },
      codeAutoRetrievalTimeout:(String verificationId){
        print("Now you can resend code");
      } ,
    );
  }
  onCodeSent(String code)async{
    try{
      PhoneAuthCredential credential= PhoneAuthProvider.credential(verificationId: verificationIdFromCodeSent, smsCode:code);
      UserCredential userCredential =await  sharedObjectsGlobal.firebaseAuth.signInWithCredential(credential);
      if(userCredential.user!=null){
        User? firebaseUser = userCredential.user;
       Navigator.pop(context);
      }else{
        setState(() {
          otpErr = "Something went wrong.Try again please!";
        });
      }
    }catch(e){
      setState(() {
        otpErr = "Invalid Otp number";
      });
      print("In try catch catch in Receive Otp Page");
      e.toString();
    }
  }
  showOtpDialog(BuildContext context) {
    Widget cancelButton = MaterialButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.push(context,CustomPageRout(widget: NavbarItems()));
      },
    );
    Widget continueButton = MaterialButton(
      child: Text("Next Step"),
      onPressed:  () async{
       print(otpCntrl.text);
       onCodeSent(otpCntrl.text.trim());
      },
    );
    AlertDialog alert = AlertDialog(
      elevation: 7,
      title: Text("We sent you an OTP in your mobile."),
      content:   CustomTextField(otpCntrl: otpCntrl,hintText: "Write OTP",errorText: otpErr,),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    print(sharedObjectsGlobal.userGlobal.phone_number);
    loginUser(sharedObjectsGlobal.userGlobal.phone_number);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    double heightMultiplier = height / 712;
    double widthMultiplier = width / 360;
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
    
    if(i == 0){
      Future.delayed(Duration.zero, () => showOtpDialog(context,));
      i++;
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20*widthMultiplier),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Text("Change Password",textAlign: TextAlign.center,style: TextStyle(fontSize: 16*heightMultiplier,color: sharedObjectsGlobal.deepGreen,fontWeight: FontWeight.bold),),
           SizedBox(height: 40*heightMultiplier,),
           CustomTextField(otpCntrl: currentPasswordCntrl,hintText: "Current Password",errorText: currentPasswordErr,),
           SizedBox(height: 20*heightMultiplier,),
           CustomTextField(otpCntrl: newPasswordCntrl,hintText: "New Password",errorText: newPasswordErr,),
           SizedBox(height: 20*heightMultiplier,),
           CustomTextField(otpCntrl: reEnterPasswordCntrl,hintText: "Re-Enter New Password",errorText: reEnterPasswordErr,),
           SizedBox(height: 20*heightMultiplier,),
          ElevatedButton(
            child: Text("Submit"),
            style:  ElevatedButton.styleFrom(
              primary:  sharedObjectsGlobal.deepGreen,
            ),
            onPressed: (){
              print("Tap");
              errorDetection();
            },
          )
         ],
        ),
      ),
    );
  }
  errorDetection()async{
     if(currentPasswordCntrl.text.trim().isEmpty || currentPasswordCntrl.text != sharedObjectsGlobal.userGlobal.password){
      setState(() {
        currentPasswordErr="Current Password is Incorrect";
      });
    }
     else if(newPasswordCntrl.text.trim().isEmpty || newPasswordCntrl.text.trim().length<6){
       setState(() {
         newPasswordErr="Password should be more than 6 letters";
       });
     }
    else if(reEnterPasswordCntrl.text.trim().isEmpty || reEnterPasswordCntrl.text != newPasswordCntrl.text){
      setState(() {
        reEnterPasswordErr="Don't match";
      });
    }
    else{
      FocusScope.of(context).requestFocus(FocusNode());
      final encrypted = Crypt.sha256(newPasswordCntrl.text.trim(), rounds: 10000, salt: dotenv.env['ENCRYPT']);
      final data = {
        "password": encrypted.toString(),
      };
      FirebaseFirestore.instance.collection('users').doc(sharedObjectsGlobal.userGlobal.phone_number).update(data).then((value){
        Fluttertoast.showToast(
            msg: "User Password Update Successful",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP ,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xff4AA69A),
            textColor: Colors.white,
            fontSize: 13.0*sharedObjectsGlobal.widthMultiplier
        );

      });
    }
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController otpCntrl;
  final String hintText,errorText;
  CustomTextField({required this.hintText,required this.otpCntrl,required this.errorText});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: otpCntrl,
      obscureText: true,
      cursorColor: Colors.grey,
      style:TextStyle(fontSize: 13*sharedObjectsGlobal.widthMultiplier,color: sharedObjectsGlobal.deepGreen,fontWeight: FontWeight.w600),
      decoration: InputDecoration(
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: sharedObjectsGlobal.deepGreen),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: sharedObjectsGlobal.deepGreen),

          ),
          errorStyle: sharedObjectsGlobal.errorTextStyle,
          errorText: errorText
      ),
    );
  }
}
