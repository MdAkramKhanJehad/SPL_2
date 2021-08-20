import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spl_two_agri_pro/main.dart';

class AddAdmin extends StatefulWidget {
  const AddAdmin({Key? key}) : super(key: key);

  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {

  String phoneErr = "",passwordErr = "",password_confirmation = '',nameErr = '';
  TextEditingController     password_controller =TextEditingController();
  TextEditingController     password_confirmation_Controller =TextEditingController();
  TextEditingController   phone_controller  =TextEditingController();
  TextEditingController     name_controller =TextEditingController();

  updateProfileButton(bool photoChanged) async {
    final data = {
      "user_name" : name_controller.text.trim(),
      "division" : '',
      "district" : '',
      "bio" : '',
      "imageUrl" : sharedObjectsGlobal.userDefaultImage,
      "created_at": Timestamp.now(),
      "password": ,
      "phone_number": ,

    };
    FirebaseFirestore.instance.collection("users").doc(sharedObjectsGlobal.userGlobal.phone_number).update(data).then((value){
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


  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    double heightMultiplier = height/712;
    double widthMultiplier= width/360;
    TextStyle titleVal=TextStyle(
      fontFamily: "Mina",
      fontSize: 18*widthMultiplier,fontWeight: FontWeight.w800,
      color:sharedObjectsGlobal.deepGreen,
    );
    TextStyle subtitleVal=TextStyle(
      fontFamily: "Mina",
      fontSize: 12*widthMultiplier,fontWeight: FontWeight.w600,
      color:sharedObjectsGlobal.deepGreen,
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
          body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 30*heightMultiplier,),
                Center(child: Text("Add New Admin",style: titleVal,)),
                SizedBox(height: 60*heightMultiplier,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15*widthMultiplier,vertical: 10*heightMultiplier),
                  height: 380*heightMultiplier,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xffC9D8B6),
                    boxShadow : [BoxShadow(
                        color:sharedObjectsGlobal.deepGreen,
                        offset: Offset(0,3),
                        blurRadius: 4
                    )],
                  ),
                )

              ],
            ),
          ),
        )
      ],
    );
  }
}
