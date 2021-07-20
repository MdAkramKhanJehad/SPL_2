import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spl_two_agri_pro/login_signup/login.dart';
import 'package:spl_two_agri_pro/login_signup/signup.dart';
import 'package:spl_two_agri_pro/main.dart';
import 'package:spl_two_agri_pro/navbar_items/diseases_page/diseases_page.dart';
import 'package:spl_two_agri_pro/navbar_items/fertilizer_page/fertilizer_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String todaysDate="Today\nTUE, 20 JUL",temperature='28',location='Azimpur, Dhaka',localTime="Sun rise 6:40 AM",cmnt_on_weather='Cloud through out the day',degree = '°';
  late Icon weather_depended_icon;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    double heightMultiplier = height/712;
    double widthMultiplier= width/360;
    TextStyle appBarTitleStyle=TextStyle(
      fontFamily: "Mina",
      letterSpacing: 0,
      fontSize: 18*widthMultiplier,fontWeight: FontWeight.w800,color:sharedObjectsGlobal.deepGreen,);
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
            appBar:AppBar(
              elevation: 0,
              backgroundColor:  Colors.transparent,
              automaticallyImplyLeading: false,
              centerTitle: false,
              backwardsCompatibility: false,
              title:Text("Agri Pro",style: appBarTitleStyle,),
              actions:[ //sharedObjectsGlobal.userSignIn==false?
                !sharedObjectsGlobal.userSignIn? TextButton(
                  child: Text('Login',style: TextStyle(fontSize: 16*widthMultiplier,fontWeight: FontWeight.w700,height: 1.5,color:sharedObjectsGlobal.deepGreen),),
                  onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>Login())),
                ):Container(),
                !sharedObjectsGlobal.userSignIn?TextButton(
                    child: Text('Signup',style: TextStyle(fontSize: 16*widthMultiplier,fontWeight: FontWeight.w700,height: 1.5,color:sharedObjectsGlobal.deepGreen),),
                    onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>Signup()))
                ):Container(),
                SizedBox(width: 15*widthMultiplier,),
              ],

            ),
            body:SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30*heightMultiplier,),
                  Container(
                    padding: EdgeInsets.only(left:30*widthMultiplier ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(todaysDate,textAlign: TextAlign.center,style: TextStyle(color: sharedObjectsGlobal.deepGreen,fontWeight: FontWeight.bold, fontFamily: "Mina",fontSize: 16*widthMultiplier),),
                        SizedBox(height: 15*heightMultiplier,),
                        Container(
                          height: 40,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Text("$temperature$degree C",style: TextStyle(color: sharedObjectsGlobal.limeGreen,fontWeight: FontWeight.bold, fontFamily: "Mina",fontSize: 32*widthMultiplier))
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  color: Colors.teal,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10*heightMultiplier,),
                        Text(location,style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal, fontFamily: "Mina",fontSize: 12*widthMultiplier)),
                      ],
                    ),
                  ),
                  SizedBox(height: 15*heightMultiplier,),
                  Container(
                      width:width*60,
                      height: 20*heightMultiplier,
                      margin: EdgeInsets.only(right: 40*widthMultiplier),
                      decoration: BoxDecoration(
                        color: sharedObjectsGlobal.limeGreen,
                        borderRadius : BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child:Text(localTime,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontFamily: "Mina",fontSize: 11*widthMultiplier))
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 7*widthMultiplier),
                          child: Icon(FontAwesomeIcons.solidCircle,size: 6*widthMultiplier,color: Colors.white,),
                        ),
                        Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              child:Text(cmnt_on_weather,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontFamily: "Mina",fontSize: 11*widthMultiplier))
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20*heightMultiplier,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20*widthMultiplier),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            print('dictionary');
                          },
                          child: Container(
                            width: 125*widthMultiplier,
                            height: 150*heightMultiplier,
                            decoration: BoxDecoration(
                              borderRadius : BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                              image: DecorationImage(
                                image: AssetImage('assets/images/dictionary.png'),
                                fit: BoxFit.cover,
                              ),
                              boxShadow : [BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  offset: Offset(0,2),
                                  blurRadius: 2
                              )],
                              color : Colors.transparent,
                            ),

                          ),
                        ),
                        SizedBox(width: 20*widthMultiplier,),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>DiseasesPage()));
                          },
                          child: Container(
                            width: 140*widthMultiplier,
                            height: 150*heightMultiplier,
                            decoration: BoxDecoration(
                              borderRadius : BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                              image: DecorationImage(
                                image: AssetImage('assets/images/diseases.png'),
                                fit: BoxFit.cover,
                              ),
                              boxShadow : [BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  offset: Offset(0,2),
                                  blurRadius: 2
                              )],
                              color : Color.fromRGBO(219, 245, 210, 1),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(height: 25*heightMultiplier,),
                                    Container(
                                      padding: EdgeInsets.only(right: 12*widthMultiplier),
                                      width: width,
                                      child: Text("PLANT\nSICK?",textAlign: TextAlign.right,
                                        style: TextStyle(color: sharedObjectsGlobal.deepGreen,fontWeight: FontWeight.bold,
                                            fontFamily: "Mina",fontSize: 14*widthMultiplier),),
                                    ),
                                    SizedBox(height: 15*heightMultiplier,),
                                    Container(
                                      padding: EdgeInsets.only(right: 12*widthMultiplier),
                                      width: width,
                                      child: Text("Find Out\nWhat Happened\nAnd Diagnose",textAlign: TextAlign.right,
                                        style: TextStyle(color: sharedObjectsGlobal.deepGreen,fontWeight: FontWeight.w500,
                                            fontFamily: "Mina",fontSize: 11*widthMultiplier),),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20*heightMultiplier,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>FertilizerPage()));
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20*widthMultiplier),
                        width: 280*widthMultiplier,
                        height: 145*heightMultiplier,
                        decoration: BoxDecoration(
                          borderRadius : BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          boxShadow : [BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              offset: Offset(0,2),
                              blurRadius: 2
                          )],
                          color : Color.fromRGBO(22, 70, 10, 1),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: width/2,
                                  height: height,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("assets/images/calculator-text.png"),
                                          fit: BoxFit.contain
                                      )
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage("assets/images/calculator.png"),
                                            fit: BoxFit.contain
                                        )
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    child: Text("Fertilizer\nCalculator",textAlign: TextAlign.center,style: TextStyle(color: sharedObjectsGlobal.lightGreen,fontWeight: FontWeight.w500,fontFamily: "Mina",fontSize: 22*widthMultiplier),),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                    ),
                  ),
                  // SizedBox(height: 10*heightMultiplier,),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 10*widthMultiplier),
                  //   child:  Container(
                  //       width: 240*widthMultiplier,
                  //       height: 185*heightMultiplier,
                  //       padding: EdgeInsets.only(left: 20*widthMultiplier,top: 10*heightMultiplier,bottom: 10*heightMultiplier,right: 5*widthMultiplier),
                  //       decoration: BoxDecoration(
                  //         borderRadius : BorderRadius.only(
                  //           topLeft: Radius.circular(20),
                  //           topRight: Radius.circular(20),
                  //           bottomLeft: Radius.circular(20),
                  //           bottomRight: Radius.circular(20),
                  //         ),
                  //         boxShadow : [BoxShadow(
                  //             color: Color.fromRGBO(0, 0, 0, 0.25),
                  //             offset: Offset(0,2),
                  //             blurRadius: 4
                  //         )],
                  //         color : Color.fromRGBO(230, 239, 182, 1),
                  //       ),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.stretch,
                  //       children: [
                  //         Text("Plant Sick?",style: TextStyle(color: sharedObjectsGlobal.deepGreen,fontWeight: FontWeight.bold,fontFamily: "Mina",fontSize: 27*widthMultiplier),),
                  //         SizedBox(height: 20*heightMultiplier,),
                  //         Row(
                  //           children: [
                  //             Expanded(
                  //               flex: 4,
                  //               child: Text("Find Out\nWhat Happened\nAnd Diagnose",style:
                  //               TextStyle(color: sharedObjectsGlobal.deepGreen,fontWeight: FontWeight.w700,fontFamily: "Mina",fontSize: 15*widthMultiplier),),
                  //             ),
                  //             Expanded(
                  //               flex: 7,
                  //               child: Container(
                  //                 decoration: BoxDecoration(
                  //                   image: DecorationImage(
                  //                     image: AssetImage("assets/images/calculator.png"),
                  //                     fit: BoxFit.contain,
                  //                   )
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 10*heightMultiplier,),
                ],
              ),
            )

        ),

      ],
    );
  }
}
/*   child: Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/images/calculator.png"),
                                          fit: BoxFit.contain,
                                        )
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text('Fertilizer\nCalculator', textAlign: TextAlign.left, style: TextStyle(
                                      color: Color.fromRGBO(20, 54, 8, 1),
                                      fontFamily: 'Mina',
                                      fontSize: 14*widthMultiplier,
                                      letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                      fontWeight: FontWeight.bold,
                                      height: 1.5 /*PERCENT not supported*/
                                  ),),
                                )
                              ],
                            ),*/