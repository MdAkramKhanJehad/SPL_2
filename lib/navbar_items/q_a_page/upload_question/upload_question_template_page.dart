import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spl_two_agri_pro/main.dart';
import 'package:spl_two_agri_pro/navbar_items/navbar_items.dart';

import 'dialog_box.dart';
class QuestionTemplate extends StatefulWidget {
  @override
  _QuestionTemplateState createState() => _QuestionTemplateState();
}

class _QuestionTemplateState extends State<QuestionTemplate> {
  List<File> files=[];
  GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey();
  List<GridTile>gridTiles=[];
  TextEditingController questionController = TextEditingController();

  TextEditingController detailsController = TextEditingController();
  String cropTag = "";
  List<String>downloadUrls=[];
  List<UploadTask> _tasks=<UploadTask>[];
  bool cropErr= false,questionErr = false,descriptionErr = false,filesEr = false;
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
                  // Positioned.fill(
                  //   child: Align(alignment: Alignment.center,
                  //     child: GestureDetector(
                  //       onTap: (){
                  //        setState(() {
                  //          //files.remove(files[i]);
                  //          tiles.remove(tiles[i]);
                  //        });
                  //        print(files.length);
                  //       },
                  //       child: Container(
                  //         height: 25*sharedObjectsGlobal.heightMultiplier,
                  //         padding: EdgeInsets.symmetric(horizontal: 15*sharedObjectsGlobal.widthMultiplier),
                  //         decoration: BoxDecoration(
                  //           border: Border.all(color: Colors.white,width: 2),
                  //           borderRadius: BorderRadius.circular(4),
                  //           color: Colors.transparent
                  //         ),
                  //         child: Text("Delete",style: TextStyle(fontSize: 11*sharedObjectsGlobal.widthMultiplier,fontFamily: "Mina",color: Colors.white,),),
                  //       ),
                  //     ),
                  //   ),
                  // )
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
  void initState() {
    questionController=TextEditingController();
    detailsController=TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    double heightMultiplier = height/712;
    double widthMultiplier= width/360;
    TextStyle questionStyle= TextStyle(fontFamily: "Mina",fontSize:14*sharedObjectsGlobal.widthMultiplier ,fontWeight:FontWeight.w600 ,color: sharedObjectsGlobal.deepGreen);
    TextStyle  answerStyle= TextStyle(fontFamily: "Mina",fontSize:13*sharedObjectsGlobal.widthMultiplier ,fontWeight:FontWeight.w500 ,color: Colors.black);
    TextStyle hintStyle= TextStyle(fontFamily: "Mina",fontSize:12*sharedObjectsGlobal.widthMultiplier ,fontWeight: FontWeight.w500,color: Colors.grey);
    TextStyle appBarStyle= TextStyle(fontFamily: "Mina",fontSize:18*sharedObjectsGlobal.widthMultiplier ,fontWeight: FontWeight.w800,color: sharedObjectsGlobal.deepGreen);
    TextStyle errStyle= TextStyle(fontFamily: "Mina",fontSize:14*sharedObjectsGlobal.widthMultiplier ,fontWeight:FontWeight.w600 ,color: sharedObjectsGlobal.errorColor);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor:Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        backwardsCompatibility: false,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: Text("Ask Community", style:appBarStyle),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: sharedObjectsGlobal.deepGreen,size: 22*widthMultiplier ,),
          onPressed: (){
            print("back");
            Navigator.pop(context);
          },),
        actions: [
          SizedBox(width: 20,),
          GestureDetector(onTap: (){
            openFileExplorer();
          },child: Icon(FontAwesomeIcons.paperclip,color:filesEr?sharedObjectsGlobal.errorColor: sharedObjectsGlobal.deepGreen,)),
          SizedBox(width: 15,),
          TextButton(onPressed: (){uploadButtonFunction(context);}, child: Text("Upload")),

          SizedBox(width: 15,),
        ],
      ),
      body:workingInBackground? Container(
        height: height,width: width,
        child: Center(child: sharedObjectsGlobal.circularProgressCustomize,),
      ): SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Adding a crop will improve the probability of receiving the right answer",textAlign: TextAlign.center,style: questionStyle,),
                  SizedBox(height: 5,),

                  cropTag !=""? Container(
                      padding: EdgeInsets.symmetric(vertical: 0,horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),border: Border.all(color: Colors.grey)),
                      child:Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(cropTag,style: answerStyle,),
                          SizedBox(width: 10,),
                          GestureDetector(
                              onTap: (){
                                setState(() {
                                  cropTag="";
                                });
                              },
                              child:Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                child: Icon(FontAwesomeIcons.times,color: Colors.white,size: 11,),
                              ) )
                        ],
                      )
                  ):GestureDetector(
                    onTap: ()async{
                      String crop = await showDialog(context: context,barrierDismissible: false, builder: (context) => DialogWidget());
                      setState(() {
                        cropTag=crop;
                        print(cropTag);
                      });
                    },
                    child: Container(padding: EdgeInsets.symmetric(vertical: 1,horizontal: 8),
                      child: Text("Add Crop",style:cropErr?errStyle : questionStyle,),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),border: Border.all(color: Colors.grey)),),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20,right: 20,bottom: 10),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(child: Text("Your Question to the community",style:questionErr?errStyle: questionStyle,)),
                  TextField(
                    style: answerStyle,
                    maxLines: 3,
                    controller: questionController,

                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Add a question indicating what's wrong with your crop",
                      hintStyle:hintStyle,

                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(

              padding: EdgeInsets.only(left: 20,right: 20,bottom: 10),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(child: Text("Description of your problem",style: descriptionErr?errStyle : questionStyle,)),
                  TextField(
                    style: answerStyle,
                    controller: detailsController,
                    maxLines: 6,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Describe specialities such as changes of leaves,roots,color,bugs...",
                      hintStyle:hintStyle,
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
  uploadButtonFunction(BuildContext context)async{
    setState(() {
      descriptionErr = false;
      questionErr = false;
      cropErr = false;
      filesEr = false;
    });
    if(check()){
      setState(() {
        workingInBackground = true;
      });
      uploadImageToFirebase();
    }
  }

  bool check(){
    if(detailsController.text.trim() == ""){
      setState(() {
        descriptionErr = true;
      });
      return false;
    }else if(questionController.text.trim() == ""){
      setState(() {
        questionErr = true;
      });
      return false;
    }else if(cropTag == ""){
      setState(() {
        cropErr = true;
      });
      return false;
    }else if(files.length == 0){
      setState(() {
        filesEr = true;
      });
      return false;
    }
    return true;
  }
  uploadImageToFirebase()async{
    final _storage =FirebaseStorage.instance.ref();
    for(int j=0;j<files.length;j++){
      String fileName = files[j].path.split('/').last;
      print(fileName);
      UploadTask uploadTask =
      _storage.child('question_images/${sharedObjectsGlobal.userGlobal.phone_number}/${Timestamp.now().seconds}.$fileName').putFile(files[j]);
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
    final question={
    'likes':[] ,
    'dislikes':[] ,
    'userId': sharedObjectsGlobal.userGlobal.phone_number,
    'postDate': Timestamp.now(),
    'details':detailsController.text.trim() ,
    'numberOfComments': 0,
    'imageLinks':files.length==0? []: downloadUrls,
    'relatedCategories':cropTag==""? []: [cropTag],
    'mainQuestion': questionController.text.trim(),
    };
    FirebaseFirestore.instance.collection('questions').add(question).then((docRef){
      setState(() {
      workingInBackground = false;
      });
      Fluttertoast.showToast(
        msg: "Question Upload Successful",
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
