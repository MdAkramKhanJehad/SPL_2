import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spl_two_agri_pro/main.dart';
import 'package:spl_two_agri_pro/models/diseases_details.dart';
import 'package:spl_two_agri_pro/navbar_items/navbar_items.dart';

class AddDiseases extends StatefulWidget {
  const AddDiseases({Key? key}) : super(key: key);

  @override
  _AddDiseasesState createState() => _AddDiseasesState();
}

class _AddDiseasesState extends State<AddDiseases> {

  bool plantErr = false,diseaseErr = false,imageErr = false,preventionErr = false,symptomErr = false;

  TextEditingController   diseaseController  =TextEditingController();
  TextEditingController preventionController =TextEditingController();
  TextEditingController  symptomController =TextEditingController();

  List<String> plantList=[
    "উদ্ভিদ নির্বাচন করুন",
    "সরিষা",
    "আম",
    "মরিচ",
    "ধান",
    'লিচু'

  ];
  String selectedPlant = "উদ্ভিদ নির্বাচন করুন";


  List<File> files=[];
  GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey();
  List<GridTile>gridTiles=[];
  List<String>downloadUrls=[];
  List<UploadTask> _tasks=<UploadTask>[];
  bool workingInBackground = false;
  openFileExplorer()async{

    try{
      FilePickerResult? result =
      await FilePicker.platform.pickFiles(allowMultiple: true,allowedExtensions: ['jpg',"png"],type: FileType.custom);

      if(result != null) {
        files = result.paths.map((path) => File(path!)).toList();
      } else {
        print("No File selected...");
      }
      List<GridTile>tiles=[];
      for(int i=0;i<files.length;i++){
        tiles.add(GridTile(
          child: Container(
              height: 200*sharedObjectsGlobal.heightMultiplier,
              child: Stack(
                children: [
                  Container(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child: Image.file(files[i],fit: BoxFit.cover,),
                  ),
                ],
              )
          ),
        )
        );
      }
      print("Images= "+files.toString());
      setState(() {
        gridTiles = tiles;
      });

    }on PlatformException catch (e){
      print("Unsupported Operation "+e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    double heightMultiplier = height/712;
    double widthMultiplier= width/360;

    TextStyle title=TextStyle( fontFamily: "Mina",
      fontSize: 20*widthMultiplier,fontWeight: FontWeight.w800,
      color:Colors.white,
    );

    TextStyle subtitle=TextStyle( fontFamily: "Mina",
      fontSize: 14*widthMultiplier,fontWeight: FontWeight.w500,
      color:Colors.black,
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
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          body:workingInBackground? Center(
            child: Container(
              child: sharedObjectsGlobal.circularProgressCustomize,
            ),
          ):  SafeArea(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Center(child: Text("Add New Disease",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24*widthMultiplier,color: sharedObjectsGlobal.deepGreen,fontFamily: "Mina"),)),
                  SizedBox(height: 10*heightMultiplier,),
                  gridTiles.length==0? Container():
                  Container(
                    color: Colors.white,
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        GridView.count(
                          crossAxisCount: gridTiles.length<3?gridTiles.length:3,
                          childAspectRatio: gridTiles.length>=2?0.8:1.2,
                          physics: NeverScrollableScrollPhysics(),
                          children: gridTiles,
                          shrinkWrap: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10*heightMultiplier,),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40*widthMultiplier,vertical: 5*heightMultiplier),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow : [BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0,3),
                          blurRadius: 4
                      )],
                    ),
                    child: Center(
                      child: Container(
                        child: DropdownButton<String>(
                          hint:  Text("Select item"),
                          value: selectedPlant,
                          dropdownColor: sharedObjectsGlobal.deepGreen,
                          isExpanded: true,
                          elevation: 10,
                          icon: Icon(FontAwesomeIcons.caretDown),
                          iconSize: 18*widthMultiplier,
                          menuMaxHeight: 350*heightMultiplier,
                          onChanged: ( val) {
                            setState(() {
                              selectedPlant = val!;
                            });
                          },
                          items: plantList.map(( user) {
                            return  DropdownMenuItem<String>(
                              value: user,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(width: 10,),
                                  Text(
                                    user,
                                    style:  TextStyle(color: user ==selectedPlant? sharedObjectsGlobal.limeGreen: Colors.white),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      /**/
                    ),
                  ),
                  SizedBox(height: 5*heightMultiplier,),
                  plantErr? Text("plant selection is needed",style: sharedObjectsGlobal.errorTextStyle,): Container(),
                  SizedBox(height: 10*heightMultiplier,),
                  TextFieldWidget(controller: diseaseController,hintText: "", plantErr: diseaseErr,error: "Disease name is required",labelText: 'Disease Name',),
                  TextFieldWidget(controller: symptomController,hintText: "Break line when you write a new symptom", plantErr: symptomErr,error: "Atleast one symptom is needed",labelText: 'Symptoms',),
                  TextFieldWidget(controller: preventionController,hintText: "Break line when you write a prevention/cure", plantErr: preventionErr,error: "Atleast one prevention/cure is required",labelText: 'Prevention & Cure',),
                 Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       imageErr? Expanded(child: Text('Give atleast one picture of this disease',style: sharedObjectsGlobal.errorTextStyle,)) : Container(),
                       ElevatedButton(onPressed: ()=>openFileExplorer(), child: Text("Choose files")),
                     ],
                   ),
                 ),
                SizedBox(height: 10*heightMultiplier,),
                GestureDetector(
                  onTap: (){
                    uploadButtonFunction(context);
                  },
                  child: Container(
                    height: 50*widthMultiplier,
                    width: width/2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: sharedObjectsGlobal.deepGreen
                    ),
                    child: Center(child: Text("Upload",style: title,)),
                  ),
                ),
                  SizedBox(height: 30*heightMultiplier,),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  uploadButtonFunction(BuildContext context)async{
    setState(() {
      plantErr = false;
      diseaseErr = false;
      symptomErr = false;
      preventionErr = false;
      imageErr = false;

    });
    if(check()){
      FocusScope.of(context).requestFocus(FocusNode());
      setState(() {
        workingInBackground = true;
      });
      uploadImageToFirebase();
    }
  }

  bool check(){
    if(selectedPlant == "উদ্ভিদ নির্বাচন করুন"){
      setState(() {
        plantErr = true;
      });
      return false;
    }else if(diseaseController.text.trim() == ""){
      setState(() {
        diseaseErr = true;
      });
      return false;
    }else if(symptomController.text.trim()  == ""){
      setState(() {
        symptomErr = true;
      });
      return false;
    }else if(preventionController.text.trim() == ""){
      setState(() {
        preventionErr = true;
      });
      return false;
    }
    else if(files.length == 0){
      setState(() {
        imageErr = true;
      });
      return false;
    }
    return true;
  }
  // addToPopularDisease(){
  //   List<Disease> dList = [];
  //   FirebaseFirestore.instance.collection('diseases').doc("00000000").get().then((doc){
  //     int index = 0;
  //     doc['diseases'].forEach((data){
  //       if(index !=0){
  //         Disease disease = Disease.fromJson(data);
  //         print(disease);
  //       }
  //       index++;
  //
  //     });
  //
  //
  //   }).catchError((error){
  //     print('Getting Popular Diseases failed: $error');
  //   });
  // }

  addToPopularDisease(){
    var dList = [];
    FirebaseFirestore.instance.collection('diseases').doc("00000000").get().then((doc){
      int index = 0;
      doc['diseases'].forEach((data){
        if(index !=0){
          dList.add(data);

        }
        index++;

      });
      print(dList.toString());
      var data = {
        'images':downloadUrls,
        'plant_name': selectedPlant,
        'disease_name': diseaseController.text.trim(),
        'symptoms' : symptomController.text.trim().split("\n"),
        'prevention_cure': preventionController.text.trim().split("\n"),
      };
      dList.add(data);
      FirebaseFirestore.instance.collection('diseases').doc("00000000").update({
        "diseases": dList,
      });
    }).catchError((error){
      print('Getting Popular Diseases failed: $error');
    });
  }

  uploadImageToFirebase()async{
    final _storage =FirebaseStorage.instance.ref();
    for(int j=0;j<files.length;j++){
      String fileName = files[j].path.split('/').last;
      print(fileName);
      UploadTask uploadTask =
      _storage.child('disease_images/${sharedObjectsGlobal.userGlobal.phone_number}/${Timestamp.now().seconds}.$fileName').putFile(files[j]);
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) async{
        print('Snapshot state: ${snapshot.state}'); // paused, running, complete
        if(snapshot.state==TaskState.success){
          print(snapshot.ref.getDownloadURL());
          final a=await snapshot.ref.getDownloadURL();
          downloadUrls.add(a.toString());
        }
        uploadTask
            .then((TaskSnapshot snapshot) {
          print('Upload complete!');
          if(downloadUrls.length==files.length){
            uploadFullQuestionToFirebase();
          }
        })
            .catchError((Object e) {
          print(e); // FirebaseException
        });

      }, onError: (Object e) {
        print(e); // FirebaseExceptio
        return null;
      });
    }
    return downloadUrls;
  }
  uploadFullQuestionToFirebase(){
    addToPopularDisease();
    var data = {
      'images':downloadUrls,
      'disease_name': diseaseController.text.trim(),
      'symptoms' : symptomController.text.trim().split("\n"),
      'prevention_cure': preventionController.text.trim().split("\n"),
    };
    var question;
    FirebaseFirestore.instance.collection('diseases').where('plant',isEqualTo:selectedPlant ).get().then((querySnapshot){
      if(querySnapshot.docs.length<1){
         question={
          'diseases':[data],
          'plant': selectedPlant,
        };
         FirebaseFirestore.instance.collection('diseases').add(question);

      }else{
        DocumentSnapshot doc = querySnapshot.docs.first;
        FirebaseFirestore.instance.collection('diseases').doc(doc.id).update({
          "diseases": FieldValue.arrayUnion( [data] ),
        });
      }
      setState(() {
        workingInBackground = false;
      });
      Fluttertoast.showToast(
          msg: "Disease Details Upload Successful",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP ,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff4AA69A),
          textColor: Colors.white,
          fontSize: 13.0*sharedObjectsGlobal.widthMultiplier
      );
      Navigator.push(context,MaterialPageRoute(builder: (context)=>NavbarItems(),));
    }).catchError((error){
      print('Update failed: $error');
    });

  }
}

class TextFieldWidget extends StatelessWidget {

  final TextEditingController controller;
  final bool plantErr;
  final String labelText,error,hintText;
  TextFieldWidget({required this.error,required this.hintText,required this.labelText,required this.controller,required this.plantErr});

  InputBorder inputBorder = OutlineInputBorder(
    borderSide:  BorderSide(color: Color(0xff27462A), width: 2),
  );
  TextStyle labelStyle=TextStyle( fontFamily: "Mina",
    color:sharedObjectsGlobal.deepGreen,
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        maxLines: null,
        cursorColor: Colors.black,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          errorText: plantErr?  error: null,
          labelStyle: labelStyle,
          enabledBorder: inputBorder ,
          focusedBorder: inputBorder,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
          ),
          labelText: labelText,
        ),
      ),
    );
  }
}
