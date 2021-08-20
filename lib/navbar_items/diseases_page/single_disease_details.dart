import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spl_two_agri_pro/main.dart';
import 'package:spl_two_agri_pro/models/diseases_details.dart';
import 'package:spl_two_agri_pro/navbar_items/q_a_page/single_question_layout/single_question_header_section.dart';
class SingleDiseaseDetails extends StatefulWidget {
  final Disease disease;
  final String plant_name;
  SingleDiseaseDetails({required this.disease,required this.plant_name});

  @override
  _SingleDiseaseDetailsState createState() => _SingleDiseaseDetailsState();
}

class _SingleDiseaseDetailsState extends State<SingleDiseaseDetails> {
  int current =0;
  @override
  Widget build(BuildContext context) {

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    double heightMultiplier = height/712;
    double widthMultiplier= width/360;
    TextStyle titleVal=TextStyle(
      fontFamily: "Mina",
      fontSize: 20*widthMultiplier,fontWeight: FontWeight.w800,
      color:sharedObjectsGlobal.deepGreen,
    );
    TextStyle titleName=TextStyle(
      fontFamily: "Mina",
      fontSize: 18*widthMultiplier,fontWeight: FontWeight.w600,
      color:Colors.black,
    );

    /*  decoration: BoxDecoration(
                      color: sharedObjectsGlobal.offWhite,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow : [BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0,3),
                          blurRadius: 4
                      )],
                    ),*/
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
                widget.disease.images.length==0? Container():  Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: width,
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 5),
                        autoPlayAnimationDuration: Duration(milliseconds: 600),
                        autoPlayCurve: Curves.linear,
                        onPageChanged: (index, reason) {
                          setState(() {
                            current = index;
                          });
                        },
                        reverse: false,

                      ),

                      items: widget.disease.images.map((singleImg){
                        return Builder(
                          builder: (BuildContext context) {
                            return  Container(
                              height: width,
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                boxShadow : [BoxShadow(

                                    color: Colors.black26,
                                    offset: Offset(0,2),
                                    blurRadius: 6
                                )],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(35),
                                child: Image.network(
                                 singleImg,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    widget.disease.images.length<=1?Container():ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        color: Colors.black.withOpacity(.5),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: widget.disease.images.map((url) {
                            int index = widget.disease.images.indexOf(url);
                            return Container(
                              width: 5.0,
                              height: 5.0,
                              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: current == index
                                    ?sharedObjectsGlobal.errorColor
                                    : Colors.white,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 3,
                      left: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 20),
                        child: Row(children: [
                          IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: Icon(FontAwesomeIcons.arrowLeft),color: Colors.white,iconSize: 20*widthMultiplier,)
                        ],),
                      ),
                    )
                  ],
                ),
       /*
              Stack(
                children: [
                  Container(
                    height: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow : [BoxShadow(

                          color: Colors.black26,
                          offset: Offset(0,2),
                          blurRadius: 6
                      )],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        "https://cdn.pixabay.com/photo/2021/05/22/10/11/fishing-boat-6273132__340.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 20),
                    child: Row(children: [
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: Icon(FontAwesomeIcons.arrowLeft),color: Colors.white,iconSize: 25*widthMultiplier,)
                    ],),
                  )
                ],
              ),

                */

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
                              TextSpan(text: widget.disease.disease_name,style: titleVal,),

                            ]
                        )),
                      ),
                      SizedBox(height: 10*heightMultiplier,),
                      Text("রোগের লক্ষনঃ",style: titleName,),
                      SizedBox(height: 5*heightMultiplier,),
                      Column(
                        children: widget.disease.symptoms.map((symptom){
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
                        children: widget.disease.prevention_cure.map((symptom){
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
                SizedBox(height: 50*heightMultiplier,),
              ],
            ),
          ),
        )
      ],
    );
  }
}
