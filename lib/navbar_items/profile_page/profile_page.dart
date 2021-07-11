import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spl_two_agri_pro/login_signup/login.dart';
import 'package:spl_two_agri_pro/main.dart';
bool isEditEnable = false;
class ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String nameErr = "",divisionErr = "",districtErr = "";
  TextEditingController     nameController =TextEditingController();
  TextEditingController     numberController =TextEditingController();
  TextEditingController   divisionController  =TextEditingController();
  TextEditingController districtController  =TextEditingController();
  TextEditingController   bioController  =TextEditingController();
  updateProfileButton() async {
    final data = {
      "user_name" : nameController.text.trim(),
      "division" : divisionController.text.trim(),
      "district" : districtController.text.trim(),
      "bio" : bioController.text.trim(),
    };
    FirebaseFirestore.instance.collection("users").doc(sharedObjectsGlobal.userGlobal.phone_number).update(data).then((value){
      Fluttertoast.showToast(
          msg: "User Profile Update Successful",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP ,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff4AA69A),
          textColor: Colors.white,
          fontSize: 13.0*sharedObjectsGlobal.widthMultiplier
      );
    });
  }

  initControllerValue(){
    nameController.text = sharedObjectsGlobal.userGlobal.user_name;
    numberController.text =sharedObjectsGlobal.userGlobal .phone_number;
    divisionController.text =sharedObjectsGlobal.userGlobal.division;
    districtController.text =sharedObjectsGlobal.userGlobal.district;
    bioController.text =sharedObjectsGlobal.userGlobal.bio;
  }
  void handleClick(String value) {
    if(value == 'Logout'){
      sharedFunctionsGlobal.clearAppDataAfterLogout();
    }else if(value == 'Edit Profile'){
      setState(() {
        isEditEnable = !isEditEnable;
      });
    }else if(value =='Change Password'){

    }
  }
  handleNonLoginClock(){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>Login()));
  }
  @override
  void initState() {
   sharedObjectsGlobal.userSignIn? initControllerValue():print('');
    super.initState();
  }
  @override
  void dispose() {
    isEditEnable = false;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    double heightMultiplier = height / 712;
    double widthMultiplier = width / 360;
    return sharedObjectsGlobal.userSignIn ? signInScaffold(heightMultiplier, widthMultiplier):signOutScaffold(heightMultiplier,widthMultiplier);
  }

Scaffold  signOutScaffold(double heightMultiplier, double widthMultiplier){
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 4,

        title: Text(
          "Profile Page",
          style: TextStyle(
              color: sharedObjectsGlobal.deepGreen,
              fontFamily: 'Mina',
              fontSize: 18 * widthMultiplier,
              fontWeight: FontWeight.bold,
              height: 2),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 15*heightMultiplier,),
          GestureDetector(
            onTap: ()=>handleNonLoginClock(),
            child: Container(
              height: 120*heightMultiplier,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 2*widthMultiplier),
              padding: EdgeInsets.symmetric(vertical: 5*heightMultiplier,horizontal: 10*widthMultiplier),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: sharedObjectsGlobal.deepGreen),

              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/no-profile.png"),
                          fit: BoxFit.contain,
                        )
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 7*heightMultiplier),
                      child: Column(
                        children: [
                          Text("Join Agri-Pro Community for more exclusive features.",textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w700,color: sharedObjectsGlobal.deepGreen,fontSize: 15*widthMultiplier,fontFamily: "Mina"),),
                            SizedBox(height: 5*heightMultiplier,),
                            GestureDetector(
                              onTap: ()=>handleNonLoginClock(),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 5*heightMultiplier,horizontal: 45*widthMultiplier),
                                child: Text("Login",  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 14*widthMultiplier,fontFamily: "Mina"),),
                                decoration: BoxDecoration(
                                  color: sharedObjectsGlobal.deepGreen,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: sharedObjectsGlobal.deepGreen),

                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Scaffold signInScaffold(double heightMultiplier, double widthMultiplier) {
    return Scaffold(
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(40 * heightMultiplier),
      child: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,

        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(FontAwesomeIcons.ellipsisV,color:sharedObjectsGlobal.deepGreen,size: 18*widthMultiplier,),
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout', 'Edit Profile','Change Password'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),

                );
              }).toList();
            },
          ),
          Container(
            width: 5 * widthMultiplier,
          ),
        ],
        title: Text(
          "My Profile",
          style: TextStyle(
              color: sharedObjectsGlobal.deepGreen,
              fontFamily: 'Mina',
              fontSize: 18 * widthMultiplier,
              fontWeight: FontWeight.bold,
              height: 2),
        ),
      ),
    ),
    body: SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        padding: EdgeInsets.only(
          left: 35 * widthMultiplier,
          right: 35 * widthMultiplier,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 30 * heightMultiplier,
            ),
            GestureDetector(
              onTap: () {

              },
              child: Container(
                child: Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Image.network(
                            sharedObjectsGlobal.userGlobal.imageUrl,
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15 * heightMultiplier,
            ),
            MyProfileTextField(
              title: "Name",
              hintText: "",
              fieldValue: sharedObjectsGlobal.userGlobal.user_name,
              textEditingController: nameController,
            ),
            MyProfileTextField(
              title: "Phone Number",
              hintText: "",
              fieldValue: sharedObjectsGlobal.userGlobal.phone_number,
              textEditingController: numberController,
            ),
            MyProfileTextField(
              title: "Division",
              hintText: "",
              fieldValue: sharedObjectsGlobal.userGlobal.division,
              textEditingController: divisionController,
            ),
            MyProfileTextField(
              title: "District",
              hintText: "",
              fieldValue: sharedObjectsGlobal.userGlobal.district,
              textEditingController: districtController,
            ),
            MyProfileTextField(
              title: "Bio",
              hintText: "",
              fieldValue: sharedObjectsGlobal.userGlobal.bio,
              textEditingController: bioController,
            ),
            SizedBox(
              height: 20 * heightMultiplier,
            ),
            GestureDetector(
              onTap: () {
                updateProfileButton();
              },
              child: Center(
                child: Container(
                  height: 60 * heightMultiplier,
                  width: 200 * widthMultiplier,
                  decoration: BoxDecoration(
                    color: sharedObjectsGlobal.deepGreen,
                    borderRadius: BorderRadius.circular(15),
                    //border: Border.all(width: 3,color: Color(0xff703816)),
                  ),
                  child: Center(
                    child: Text(
                      "Update",
                      style: TextStyle(
                          fontSize: 20 * heightMultiplier,
                          color: Colors.white,
                          fontFamily: "Mina",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20 * heightMultiplier,
            ),
          ],
        ),
      ),
    ),
  );
  }
}

class MyProfileTextField extends StatelessWidget {
  final String title, hintText, fieldValue;
  final TextEditingController textEditingController;

  MyProfileTextField({required this.title,required this.hintText,required this.fieldValue, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    final double heightMultiplier = MediaQuery.of(context).size.height / 712;
    final double widthMultiplier = MediaQuery.of(context).size.width / 360;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Mina',
              fontSize: 12 * widthMultiplier,
              letterSpacing:
              0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.w800,
              height: 1),
        ),
        TextField(
          controller: textEditingController,
          enabled: title == "Phone Number" || !isEditEnable ? false : true,
          style: TextStyle(
            fontFamily: 'Mina',
            fontSize: 18 * widthMultiplier,
            letterSpacing: 0,
            fontWeight: FontWeight.w500,
            height: 1,
            color: title == "Phone Number" || !isEditEnable
                ? Colors.grey
                : Colors.black,
          ),
          cursorColor: sharedObjectsGlobal.limeGreen,
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
            hintStyle: new TextStyle(color: Colors.grey),
            hintText: hintText,
          ),
        ),
        SizedBox(
          height: 12 * heightMultiplier,
        ),
      ],
    );
  }
}
