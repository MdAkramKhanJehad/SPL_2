import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spl_two_agri_pro/login_signup/signup.dart';
import 'package:spl_two_agri_pro/main.dart';
import 'package:spl_two_agri_pro/navbar_items/navbar_items.dart';
import 'package:spl_two_agri_pro/services/customPageRoute.dart';
import 'package:crypt/crypt.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}
class _ChangePasswordState extends State<ChangePassword> {
  String currentPasswordErr = "",passwordErr = "",reEnterPasswordErr = "";
  TextEditingController     currentPasswordController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  TextEditingController  reEnterPasswordController =TextEditingController();


  errorDetection()async{

    final currentPassEncrypt = Crypt.sha256(currentPasswordController.text.trim(), rounds: 10000, salt: dotenv.env['ENCRYPT']);
    if(currentPasswordController.text.trim().isEmpty || currentPassEncrypt.toString() != sharedObjectsGlobal.userGlobal.password){
      setState(() {
        currentPasswordErr="Current Password Incorrect";
      });
    }
    else if(passwordController.text.trim().isEmpty || passwordController.text.trim().length<6){
      setState(() {
        passwordErr="Password should be more than 6 letters";
      });
    }
    else if(reEnterPasswordController.text.trim().isEmpty || reEnterPasswordController.text != passwordController.text){
      setState(() {
        reEnterPasswordErr="Don't match";
      });
    }
    else{
      FocusScope.of(context).requestFocus(FocusNode());
      final encrypted = Crypt.sha256(passwordController.text.trim(), rounds: 10000, salt: dotenv.env['ENCRYPT']);
      final data = {
        "password": encrypted.toString(),
      };
      createUserInFirebase(data);
    }
  }

  createUserInFirebase(userData)async{
    FirebaseFirestore.instance.collection('users').doc(sharedObjectsGlobal.userGlobal.phone_number).update(userData).then((value){
      Fluttertoast.showToast(
          msg: "User Password Change Successful",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP ,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff4AA69A),
          textColor: Colors.white,
          fontSize: 13.0*sharedObjectsGlobal.widthMultiplier
      );
      Navigator.push(context,MaterialPageRoute(builder: (context)=>NavbarItems()));
    }).catchError((error){
      print('Update failed: $error');
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 18*widthMultiplier ,),
          onPressed: (){
            Navigator.push(context,CustomPageRout(widget: Signup()));
          },),
        title: Text("Registration Form",style: sharedObjectsGlobal.appBarTitleStyle,),

      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          margin: EdgeInsets.only(
              left: 30*widthMultiplier,right: 30*widthMultiplier,
              bottom: 50*heightMultiplier),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30*heightMultiplier,),
              Center(
                child: Text('Create Account', textAlign: TextAlign.left, style: sharedObjectsGlobal.bodyTitleStyle),
              ),
              SizedBox(height: 30*heightMultiplier,),
              Text('Current Password', textAlign: TextAlign.left, style: fieldName),
              TextField(
                controller: currentPasswordController,
                cursorColor: Colors.grey,
                style:fieldValue,
                obscureText: true,
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
                    errorText: currentPasswordErr
                ),
              ),
              SizedBox(height: 10*heightMultiplier,),
              Text('New Password', textAlign: TextAlign.left, style: fieldName),
              TextField(
                controller: passwordController,
                obscureText: true,
                cursorColor: Colors.grey,
                style:fieldValue,
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

                    errorText: passwordErr
                ),
              ),
              SizedBox(height: 10*heightMultiplier,),
              Text('Re-Enter Password', textAlign: TextAlign.left, style: fieldName),
              TextField(
                controller: reEnterPasswordController,
                cursorColor: Colors.grey,
                obscureText: true,
                style:fieldValue,
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

                    errorText: reEnterPasswordErr
                ),
              ),
              SizedBox(height: 10*heightMultiplier,),
              GestureDetector(
                onTap: (){
                  setState(() {
                    currentPasswordErr = "";passwordErr = "";reEnterPasswordErr = "";
                  });
                  errorDetection();
                },
                child: Container(
                  width: width*0.60,
                  height: 57*heightMultiplier,
                  decoration: BoxDecoration(
                      borderRadius : BorderRadius.only(
                        topLeft: Radius.circular(13),
                        topRight: Radius.circular(13),
                        bottomLeft: Radius.circular(13),
                        bottomRight: Radius.circular(13),
                      ),
                      boxShadow : [BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0,3),
                          blurRadius: 4
                      )],
                      color : sharedObjectsGlobal.deepGreen
                  ),
                  child: Center(
                    child: Text('Submit', textAlign: TextAlign.left, style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Mina',
                        fontSize: 20*widthMultiplier,
                        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.bold,
                        height: 1
                    ),),
                  ),
                ),
              ),
            ],
          ) ,
        ),
      ),
    );
  }
}

