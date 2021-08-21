import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spl_two_agri_pro/main.dart';
import 'package:spl_two_agri_pro/navbar_items/profile_page/profile_page.dart';

class AddAdmin extends StatefulWidget {
  const AddAdmin({Key? key}) : super(key: key);

  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {

  String phoneErr = "Phone Number",passwordErr = "Password",password_confirmation = 'ReEnter Password',nameErr = 'Name';
  TextEditingController     password_controller =TextEditingController();
  TextEditingController     password_confirmation_Controller =TextEditingController();
  TextEditingController   phone_controller  =TextEditingController();
  TextEditingController     name_controller =TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    double heightMultiplier = height/712;
    double widthMultiplier= width/360;
    TextStyle titleVal=TextStyle(
      fontFamily: "Mina",
      height: 2.5,
      fontSize: 20*widthMultiplier,fontWeight: FontWeight.w800,
      color:sharedObjectsGlobal.deepGreen,
    );
    TextStyle hintStyle=TextStyle(
      fontFamily: "Mina",
      letterSpacing: 1.1,
      fontSize: 12*widthMultiplier,fontWeight: FontWeight.w500,

    );
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background-low-opacity.png"),
                  fit: BoxFit.cover
              )
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15*widthMultiplier,vertical: 10*heightMultiplier),
                padding: EdgeInsets.symmetric(horizontal: 10*widthMultiplier,vertical: 5*widthMultiplier),
                height: 410*heightMultiplier,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xffC9D8B6),
                  boxShadow : [BoxShadow(
                      color:sharedObjectsGlobal.deepGreen,
                      offset: Offset(0,3),
                      blurRadius: 4
                  )],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Icon(FontAwesomeIcons.userShield,size: 28,color: sharedObjectsGlobal.deepGreen,),
                       SizedBox(width: 20*widthMultiplier,),
                       Text("Add New Admin",style: titleVal,),
                     ],
                   ),
                    SizedBox(height: 20*heightMultiplier,),
                    TextFieldContainer(
                      child: TextField(
                        cursorColor: Color(0xffC9D8B6),
                        controller: name_controller,
                        decoration: InputDecoration(
                          hintText: nameErr,//,
                          hintStyle:nameErr == "Name"? hintStyle:sharedObjectsGlobal.errorTextStyle,
                          icon: Icon(FontAwesomeIcons.user,size: 20,),
                          border: InputBorder.none,
                        ),
                      ),),
                    SizedBox(height: 20*heightMultiplier,),
                    TextFieldContainer(
                      child: TextField(
                        cursorColor: Color(0xffC9D8B6),
                        controller: phone_controller,
                        decoration: InputDecoration(
                          hintText: phoneErr,//,
                          hintStyle: phoneErr == "Phone Number"? hintStyle: sharedObjectsGlobal.errorTextStyle,
                          icon: Icon(FontAwesomeIcons.phone,size: 20,),
                          border: InputBorder.none,
                        ),
                      ),),

                    SizedBox(height: 20*heightMultiplier,),
                    TextFieldContainer(
                      child: TextField(
                        cursorColor: Color(0xffC9D8B6),
                        controller: password_controller,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: passwordErr,//,
                          hintStyle:passwordErr == "Password"? hintStyle: sharedObjectsGlobal.errorTextStyle,
                          icon: Icon(FontAwesomeIcons.lock,size: 20,),
                          border: InputBorder.none,
                        ),
                      ),),

                    SizedBox(height: 20*heightMultiplier,),
                    TextFieldContainer(
                      child: TextField(
                        cursorColor: Color(0xffC9D8B6),
                        obscureText: true,
                        controller: password_confirmation_Controller,
                        decoration: InputDecoration(
                          hintText: password_confirmation,//,
                          hintStyle:password_confirmation == "ReEnter Password" ?  hintStyle: sharedObjectsGlobal.errorTextStyle,
                          icon: Icon(FontAwesomeIcons.lock,size: 20,),
                          border: InputBorder.none,
                        ),
                      ),),
                    SizedBox(height: 20*heightMultiplier,),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          phoneErr = "Phone Number";
                          passwordErr = "Password";
                          password_confirmation = 'ReEnter Password';
                          nameErr = 'Name';
                        });
                        errorDetection();

                      },
                      child: Container(
                        height: 50,
                        width: width/2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(29),
                          color: sharedObjectsGlobal.deepGreen,
                        ),
                        child: Center(child: Text("Submit",style: TextStyle(fontFamily: "Mina",fontSize: 16*widthMultiplier,color: Colors.white,fontWeight: FontWeight.bold),)),
                      ),
                    ),

                  ],
                ),
              )

            ],
          ),
        )
      ],
    );
  }

Future<bool>  checkPhoneNumber(String phoneNumber){
    print(phoneNumber);
   return FirebaseFirestore.instance.collection('users').doc(phoneNumber).get().then((userDoc){
      if(!userDoc.exists){
       return true;
      }else{
        return false;
      }
    });
  }

  errorDetection()async{
    final res=await checkPhoneNumber('+88${phone_controller.text.trim()}');
    print(res);
    if(name_controller.text.trim().isEmpty){
      setState(() {
        name_controller.text = "";
        nameErr="Name field is Empty";
      });
    }else if(phone_controller.text.trim().isEmpty || phone_controller.text.trim().length!=11){
      setState(() {
        phone_controller.text = "";
        phoneErr="Phone Number should be 11 Characters";
      });
    }else if(password_controller.text.trim().isEmpty || password_controller.text.trim().length<6){
      setState(() {
        password_controller.text = "";
        passwordErr="Password should be more than 6 letters";
      });
    }
    else if(password_confirmation_Controller.text.trim().isEmpty || password_confirmation_Controller.text != password_controller.text){
      setState(() {
        password_confirmation_Controller.text = "";
        password_confirmation="Don't match";
      });
    }else if(!res){
      setState(() {
        phone_controller.text = "";
        phoneErr = "This Number Already Used";
      });
    }
    else{
      FocusScope.of(context).requestFocus(FocusNode());
      final encrypted = Crypt.sha256(password_controller.text.trim(), rounds: 10000, salt: dotenv.env['ENCRYPT']);
      final data = {
        "user_name": name_controller.text.trim(),
        "division": "",
        "district": "",
        "password": encrypted.toString(),
        "created_at": Timestamp.now(),
        "imageUrl":sharedObjectsGlobal.userDefaultImage,
        "bio":"",
        "phone_number": '+88${phone_controller.text.trim()}',
        "status": true,
        "is_admin": true,
      };
      FirebaseFirestore.instance.collection("users").doc('+88${phone_controller.text.trim()}').set(data).then((value){
        Fluttertoast.showToast(
            msg: "Admin User Created Successful",
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

class TextFieldContainer extends StatelessWidget {
  final Widget child;


  const TextFieldContainer({
    Key? key,
    required this.child,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(29),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
