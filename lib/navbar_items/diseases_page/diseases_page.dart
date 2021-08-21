import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spl_two_agri_pro/main.dart';
import 'package:spl_two_agri_pro/models/diseases_details.dart';
import 'package:spl_two_agri_pro/navbar_items/q_a_page/single_question_layout/single_question_header_section.dart';
class DiseasesPage extends StatefulWidget {
  @override
  _DiseasesPageState createState() => _DiseasesPageState();
}

class _DiseasesPageState extends State<DiseasesPage> {
  late DiseasesDetails selectedItem;
  bool loading = true;
  List<DiseasesDetails>diseasesDetailsList = [];

  getAllDiseases(){
    FirebaseFirestore.instance.collection('diseases').get().then((querySnapshot){
      querySnapshot.docs.forEach((doc) {
        List<Disease> diseaseList=[];
        doc['diseases'].forEach((data){
          Disease disease = Disease.fromJson(data);
          diseaseList.add(disease);
        });
        DiseasesDetails dd = DiseasesDetails.fromJson(doc,diseaseList);
        diseasesDetailsList.add(dd);
        print(dd.toString());
      });
      setState(() {
        loading = false;
        selectedItem = diseasesDetailsList[0];
      });
    });
  }
  @override
  void initState() {

    getAllDiseases();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    double heightMultiplier = height/712;
    double widthMultiplier= width/360;
    TextStyle titleVal=TextStyle(
      fontSize: 20*widthMultiplier,fontWeight: FontWeight.w800,
      color:sharedObjectsGlobal.deepGreen,
    );
    TextStyle titleName=TextStyle(
      fontSize: 17*widthMultiplier,fontWeight: FontWeight.w600,
      color:Colors.black,
    );
    TextStyle other=TextStyle(
      fontSize: 14*widthMultiplier,fontWeight: FontWeight.w500,
      color:sharedObjectsGlobal.deepGreen,
    );


    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
        loading? Container(height: height,width: width,child: Center(child: sharedObjectsGlobal.circularProgressCustomize,),) : Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor:  Colors.teal.shade400,
            backwardsCompatibility: false,
            automaticallyImplyLeading: false,
            centerTitle: true,
            elevation: 0,
            leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: sharedObjectsGlobal.deepGreen,size: 18*widthMultiplier ,),
              onPressed: (){
                Navigator.pop(context);
              },),
            title: Text("Diseases Details", style:TextStyle( fontFamily: "Mina", letterSpacing: 0, fontSize: 20*widthMultiplier,fontWeight: FontWeight.w800, color:sharedObjectsGlobal.deepGreen,) ),
          ),
          body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20*heightMultiplier,),
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
                      child: DropdownButton<DiseasesDetails>(
                        hint:  Text("Select item"),
                        value: selectedItem,
                        dropdownColor: sharedObjectsGlobal.deepGreen,
                        isExpanded: true,
                        elevation: 10,
                        icon: Icon(FontAwesomeIcons.caretDown),
                        iconSize: 18*widthMultiplier,
                        //itemHeight: 40*heightMultiplier,
                        menuMaxHeight: 350*heightMultiplier,
                        onChanged: ( val) {
                          setState(() {
                            selectedItem = val!;
                          });
                        },
                        items: diseasesDetailsList.map(( details) {
                          return  DropdownMenuItem<DiseasesDetails>(
                            value: details,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10,),
                                Text(
                                  details.plant,
                                  style:  TextStyle(color: details ==selectedItem? sharedObjectsGlobal.limeGreen: Colors.white),
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
                SizedBox(height: 20*heightMultiplier,),
                Column(
                  children: selectedItem.diseaseList.map((diseasesDetails){
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: EdgeInsets.only(bottom: 20*heightMultiplier),
                        margin: EdgeInsets.only(top:5,bottom: 10,left: 5,right: 5),
                        decoration: BoxDecoration(
                          color: sharedObjectsGlobal.offWhite,
                          boxShadow : [BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              offset: Offset(0,3),
                              blurRadius: 4
                          )],
                        ),
                        child: Column(
                          children: [
                            diseasesDetails.images.length==0? Container():  SingleQuestionHeader(imgList: diseasesDetails.images),
                            SizedBox(height: 10*heightMultiplier,),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10*widthMultiplier),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Center(
                                    child: RichText(text: TextSpan(
                                        children: [
                                          TextSpan(text: "রোগের নামঃ ",style: titleName,),
                                          TextSpan(text: diseasesDetails.disease_name,style: titleVal,),

                                        ]
                                    )),
                                  ),
                                  SizedBox(height: 10*heightMultiplier,),
                                  //র
                                  Text("রোগের লক্ষনঃ",style: titleName,),
                                  SizedBox(height: 5*heightMultiplier,),
                                  Column(
                                    children: diseasesDetails.symptoms.map((symptom){
                                      return ListTile(
                                        dense: true,
                                        contentPadding: EdgeInsets.all(0),
                                        horizontalTitleGap: 0,
                                        minVerticalPadding: 0,
                                        leading: Icon(FontAwesomeIcons.solidCircle,size: 16*widthMultiplier,color: sharedObjectsGlobal.deepGreen,),
                                        title: Text(symptom,style: sharedObjectsGlobal.bodyCaptionStyle,textAlign: TextAlign.left,),
                                      );

                                        //;
                                    }).toList(),
                                  ),
                                  SizedBox(height: 20*heightMultiplier,),
                                  Text("রোগের প্রতিরোধ ও প্রতিকারঃ",style: titleName,),
                                  SizedBox(height: 5*heightMultiplier,),
                                  Column(
                                    children: diseasesDetails.prevention_cure.map((symptom){
                                      return ListTile(
                                        dense: true,
                                        contentPadding: EdgeInsets.all(0),
                                        horizontalTitleGap: 0,
                                        minVerticalPadding: 0,
                                        leading: Icon(FontAwesomeIcons.cube,size: 16*widthMultiplier,color: sharedObjectsGlobal.deepGreen,),
                                        title: Text(symptom,style: sharedObjectsGlobal.bodyCaptionStyle,textAlign: TextAlign.left,),
                                      );

                                      //;
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),

              ],
            ),
          ),
        )
      ],
    );
  }
}
