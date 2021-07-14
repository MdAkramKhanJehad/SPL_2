import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spl_two_agri_pro/main.dart';
import 'package:spl_two_agri_pro/models/diseases_details.dart';
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
            // image: DecorationImage(
            //     image: AssetImage("assets/images/home-page-bg.png"),
            //     fit: BoxFit.cover
            // )
          ),
        ),
        loading? Container(height: height,width: width,child: Center(child: sharedObjectsGlobal.circularProgressCustomize,),) : Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor:  Colors.white,
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
        )
      ],
    );
  }
}
