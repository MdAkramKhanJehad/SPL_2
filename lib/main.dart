import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spl_two_agri_pro/login_signup/signup.dart';
import 'package:spl_two_agri_pro/login_signup/otp_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'navbar_items/navbar_items.dart';
import 'shared/shared_objects.dart';
import 'shared/shared_functions.dart';
final SharedFunctions sharedFunctionsGlobal = new SharedFunctions();
final SharedObjects sharedObjectsGlobal = new SharedObjects();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          sharedFunctionsGlobal.getMobileHeightWeight(constraints);
          return MaterialApp(
            title: 'Agri Pro',
            theme: ThemeData(
              fontFamily: 'Mina',
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home: Signup(),
          );
        }
    );
  }
}
class SplashScreen extends StatefulWidget {
  final String userId,password;
  SplashScreen({required this.userId,required this.password});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    setSharedPreferences();
    splashScreenDelay();
    super.initState();
  }

  splashScreenDelay(){
    Future.delayed(Duration(milliseconds: 3000),(){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>
          NavbarItems(),
      ));
    });
  }
  setSharedPreferences()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('password',widget.password );
    prefs.setString('userId',widget.userId );
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    double heightMultiplier = height/712;
    return Scaffold(

      body:  splashScreenSameUI(heightMultiplier,width)
    );
  }
  Column splashScreenSameUI(double heightMultiplier, double width) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 50*heightMultiplier,),
        Center(
          child: Text("Agri Pro",
            style: TextStyle(fontSize: 28*width/360,color: sharedObjectsGlobal.deepGreen,fontFamily: "Mina",fontWeight: FontWeight.bold,),),
        ),
        Center(
          child: Container(
            height:300*heightMultiplier,
            width: width*0.8,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/app-main-logo.png"),
                  fit: BoxFit.contain,
                )
            ),
          ),
        ),
        Center(
          child: Text("Institute of Information Technology\nSPL-2",textAlign: TextAlign.center,maxLines: 3,
            style: TextStyle(fontSize: 12*width/360,color: sharedObjectsGlobal.deepGreen,fontFamily: "Mina",fontWeight: FontWeight.w500,),),
        ),
      ],
    );
  }
}