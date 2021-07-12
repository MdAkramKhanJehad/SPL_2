import 'package:flutter/material.dart';
import 'package:spl_two_agri_pro/login_signup/login.dart';
import 'package:spl_two_agri_pro/login_signup/signup.dart';
import 'package:spl_two_agri_pro/main.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    double heightMultiplier = height/712;
    double widthMultiplier= width/360;
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/home-page-bg.png"),
                  fit: BoxFit.cover
              )

          ),

        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar:AppBar(
              backgroundColor: Colors.white,
              elevation: 4,
              automaticallyImplyLeading: false,
              centerTitle: false,
              title:Text("Agri Pro",style: sharedObjectsGlobal.appBarTitleStyle,),
              actions:[ //sharedObjectsGlobal.userSignIn==false?
                !sharedObjectsGlobal.userSignIn? TextButton(
                    child: Text('Login',style: TextStyle(fontSize: 16*widthMultiplier,fontWeight: FontWeight.w500,height: 1.5,color:Color(0xff70ABD3)),),
                    onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>Login())),
                ):Container(),
                !sharedObjectsGlobal.userSignIn?TextButton(
                    child: Text('Signup',style: TextStyle(fontSize: 16*widthMultiplier,fontWeight: FontWeight.w500,height: 1.5,color:Color(0xff70ABD3)),),
                    onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>Signup()))
                ):Container(),
                SizedBox(width: 15*widthMultiplier,),
              ],

          ),
          body: Column(
            children: [
                 Center(child: Text("Home Page"))
            ],
          )

        ),

      ],
    );
  }
}
