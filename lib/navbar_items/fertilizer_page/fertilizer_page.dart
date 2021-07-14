import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spl_two_agri_pro/main.dart';
import 'package:spl_two_agri_pro/models/fertilizer_calculator.dart';
class FertilizerPage extends StatefulWidget {
  @override
  _FertilizerPageState createState() => _FertilizerPageState();
}

class _FertilizerPageState extends State<FertilizerPage> {

  late FertilizerCalculator selectedItem;
  double fieldSize = 0.0;
  late String selectedUnit ;
  bool loading = true,viewResult = false;
  List<Fertilizer> selectedUnitFertilizerList=[];

  List<FertilizerCalculator> fertilizerCalcList=[];
  getAllFertilizers()async{
    FirebaseFirestore.instance.collection('fertilizers').limit(5).get().then((querySnapshot){
      querySnapshot.docs.forEach((doc) {
        List<Fertilizer> acreFertilizerList=[];
        List<Fertilizer> hectareFertilizerList=[];
        doc['acre'].forEach((data){
          Fertilizer f = Fertilizer.fromJson(data);
          acreFertilizerList.add(f);
        });
        doc['hectare'].forEach((data){
          Fertilizer f = Fertilizer.fromJson(data);
          hectareFertilizerList.add(f);
        });
        FertilizerCalculator ft = FertilizerCalculator.fromJson(doc,acreFertilizerList,hectareFertilizerList);
        fertilizerCalcList.add(ft);
      });
      setState(() {
        loading = false;
        selectedItem = fertilizerCalcList[0];
        selectedUnit = fertilizerCalcList[0].units[0];
      });
    });
  }
  @override
  void initState() {
    getAllFertilizers();
    //  selectedIndex = 0;
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
            title: Text("Fertilizer Calculator", style:TextStyle( fontFamily: "Mina", letterSpacing: 0, fontSize: 20*widthMultiplier,fontWeight: FontWeight.w800, color:sharedObjectsGlobal.deepGreen,) ),
          ),
          body: SingleChildScrollView(
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
                      //color: sharedObjectsGlobal.deepGreen,
                      child: DropdownButton<FertilizerCalculator>(
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
                            fieldSize = 0.0;
                            viewResult = false;
                            selectedItem = val!;
                          });
                        },
                        items: fertilizerCalcList.map(( user) {
                          return  DropdownMenuItem<FertilizerCalculator>(
                            value: user,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10,),
                                Text(
                                  user.name,
                                  style:  TextStyle(color: user ==selectedItem? sharedObjectsGlobal.limeGreen: Colors.white),
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
                Container(
                  color: sharedObjectsGlobal.offWhite,
                  padding: EdgeInsets.symmetric(horizontal: 20*widthMultiplier,vertical: 10*heightMultiplier),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RichText(text: TextSpan(
                                  children: [
                                    TextSpan(text: "Name: ",style: titleName,),
                                    TextSpan(text: selectedItem.name,style: titleVal,),
                                  ]
                              )),

                              RichText(text: TextSpan(
                                  children: [
                                    TextSpan(text: "Unit: ",style: titleName,),
                                    TextSpan(text: selectedUnit,style: titleVal,),
                                  ]
                              )),
                            ],
                          )
                      ),
                      SizedBox(height: 10*heightMultiplier,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(

                              child: IconButton(
                                onPressed: (){
                                  setState(() {
                                    viewResult = false;
                                    if(fieldSize !=0.0){
                                      fieldSize -=0.5;
                                    }
                                  });
                                },
                                icon: Icon(FontAwesomeIcons.minusCircle,color: sharedObjectsGlobal.deepGreen,size: 40*sharedObjectsGlobal.areaMultiplier,),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Container(
                              height: 60*heightMultiplier,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1),
                                  border: Border.all(color: sharedObjectsGlobal.deepGreen,width: 2)
                              ),
                              child: Center(child: Text("$fieldSize",style: TextStyle(
                                color: sharedObjectsGlobal.deepGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 25*widthMultiplier,
                                height: 2,
                              ),)),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: IconButton(
                                onPressed: (){
                                  viewResult = false;
                                  setState(() {
                                    fieldSize +=0.5;
                                  });
                                },
                                icon: Icon(FontAwesomeIcons.plusCircle,color: sharedObjectsGlobal.deepGreen,size: 40*sharedObjectsGlobal.areaMultiplier,),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10*heightMultiplier,),
                      Text('You can set your desired field value by pressing on plus minus button',textAlign: TextAlign.center,style: sharedObjectsGlobal.bodyCaptionStyle,),
                      SizedBox(height: 10*heightMultiplier,),
                      selectedItem.units.length>1?Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: selectedItem.units.map((data){
                          return Expanded(
                            child: Container(
                              height: 40,
                              child: RadioListTile(
                                  activeColor: sharedObjectsGlobal.deepGreen,
                                  tileColor:Colors.black,
                                  title: Text(data),
                                  value: data,
                                  groupValue: selectedUnit,
                                  onChanged: (value) {
                                    setState(() {
                                      viewResult = false;
                                      selectedUnit = data;
                                    });
                                  }),
                            ),
                          );
                        }).toList(),
                      ):Container(),
                      SizedBox(height: 20*heightMultiplier,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){

                              if(selectedUnit.toLowerCase() == selectedItem.units[0].toLowerCase()){
                                setState(() {
                                  viewResult = true;
                                  selectedUnitFertilizerList = selectedItem.hectare;
                                });
                              }else{
                                setState(() {
                                  viewResult = true;
                                  selectedUnitFertilizerList = selectedItem.acre;
                                });
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20*widthMultiplier,vertical: 5*heightMultiplier),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: fieldSize ==0.0? Colors.black26:sharedObjectsGlobal.deepGreen,
                              ),
                              child: Text("Calculate",style: TextStyle(color: Colors.white,fontSize: 12*widthMultiplier,fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 20*heightMultiplier,),
                fieldSize==0.0 || !viewResult? Container():Container(
                  color: sharedObjectsGlobal.offWhite,
                  padding: EdgeInsets.symmetric(horizontal: 10*widthMultiplier,vertical: 20*heightMultiplier),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:selectedUnitFertilizerList.map((fertilizer){
                        return Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5*widthMultiplier,vertical: 5*heightMultiplier),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(fertilizer.fertilizer_name,style: TextStyle(color: sharedObjectsGlobal.deepGreen,fontWeight: FontWeight.w600,fontSize: 18*widthMultiplier,height: 1.5),),
                                RichText(text: TextSpan(
                                    children: [
                                      TextSpan(text: "${fertilizer.quantity * fieldSize}",style: titleName,),
                                      TextSpan(text: " ${fertilizer.unit}",style: sharedObjectsGlobal.bodyCaptionStyle,),
                                    ]
                                )),
                              ],
                            ),
                          ),
                        );
                      }).toList()
                  ),
                )

              ],
            ),
          ),
        )
      ],
    );
  }
  Map<String, dynamic> toJson(FertilizerCalculator f){
    return {
      'name' : f.name,
      'units' : f.units,
      'hectare' : f.hectare,
      'acre' : f.acre
    };
  }
}
