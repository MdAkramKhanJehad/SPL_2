import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spl_two_agri_pro/login_signup/signup.dart';
import 'package:spl_two_agri_pro/main.dart';
import 'package:spl_two_agri_pro/services/customPageRoute.dart';
import 'package:crypt/crypt.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RegistrationForm extends StatefulWidget {
  final User? firebaseUser;
  RegistrationForm({ required this.firebaseUser});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {


  String nameErr = "",divisionErr = "",districtErr = "",passwordErr = "",reEnterPasswordErr = "";
  TextEditingController     nameController =TextEditingController();
  TextEditingController   divisionController  =TextEditingController();
  TextEditingController districtController  =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  TextEditingController  reEnterPasswordController =TextEditingController();


  errorDetection()async{
    if(nameController.text.trim().isEmpty){
      setState(() {
        nameErr="Name field is Empty";
      });
    }else if(divisionController.text.trim().isEmpty){
      setState(() {
        divisionErr="Division field is Empty";
      });
    }
    else if(districtController.text.trim().isEmpty){
      setState(() {
        districtErr="District field is Empty";
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
        "user_name": nameController.text.trim(),
        "division": divisionController.text.trim(),
        "district": districtController.text.trim(),
        "password": encrypted.toString(),
        "created_at": Timestamp.now(),
        "imageUrl":sharedObjectsGlobal.userDefaultImage,
        "bio":"",
        "phone_number": widget.firebaseUser!.phoneNumber,
      };
      createUserInFirebase(data,widget.firebaseUser!.phoneNumber,encrypted.toString());
    }
  }

  createUserInFirebase(userData,userId,password)async{
    FirebaseFirestore.instance.collection('users').doc(userId).set(userData).then((value){
      Fluttertoast.showToast(
          msg: "User Registration Successful",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP ,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff4AA69A),
          textColor: Colors.white,
          fontSize: 13.0*sharedObjectsGlobal.widthMultiplier
      );
      Navigator.push(context,MaterialPageRoute(builder: (context)=>SplashScreen(password:password ,userId: userId,)));
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
        letterSpacing: 0 ,
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
              Text('Full Name', textAlign: TextAlign.left, style: fieldName),
              TextField(
                controller: nameController,
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
                    errorText: nameErr
                ),
              ),
              SizedBox(height: 10*heightMultiplier,),

              Text('Password', textAlign: TextAlign.left, style: fieldName),
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

              Text('Division', textAlign: TextAlign.left, style:fieldName ),
              TextField(
                controller: divisionController,
                cursorColor: Colors.grey,
                style: fieldValue,
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
                    errorText: divisionErr
                ),
              ),
              SizedBox(height: 10*heightMultiplier,),
              Text('District', textAlign: TextAlign.left, style: fieldName,),
              TextField(
                controller: districtController,
                cursorColor: Colors.grey,
                style: fieldValue,

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
                    errorText: districtErr
                ),
              ),
              SizedBox(height: 10*heightMultiplier,),
              GestureDetector(
                onTap: (){
                  setState(() {
                    nameErr = "";divisionErr = "";districtErr = "";passwordErr = "";reEnterPasswordErr = "";
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
                    child: Text('Complete', textAlign: TextAlign.left, style: TextStyle(
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

