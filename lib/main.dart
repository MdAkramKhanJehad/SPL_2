import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spl_two_agri_pro/fertilizer.dart';
import 'package:spl_two_agri_pro/login_signup/signup.dart';
import 'package:spl_two_agri_pro/login_signup/otp_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spl_two_agri_pro/models/user.dart';

import 'navbar_items/fertilizer_page/fertilizer_page.dart';
import 'navbar_items/navbar_items.dart';
import 'shared/shared_objects.dart';
import 'shared/shared_functions.dart';
final SharedFunctions sharedFunctionsGlobal = new SharedFunctions();
final SharedObjects sharedObjectsGlobal = new SharedObjects();
// getSharedPreferences()async{
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return [prefs.getString('userId'),prefs.getString('password')];
//
// }

getSharedPreferences()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('userId');
  if(userId!=null){
    //return prefs.getString('userId');
    return [userId,prefs.getString('password')];
  }else{

    return ['',''];
  }
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  final personalInfo = await getSharedPreferences();
  String userId = personalInfo[0];
  String password = personalInfo[1];
  print(userId);
  print(password);
  //String userId = personalInfo[0]!=null ? personalInfo[0] : null;
  // String password = personalInfo[1]!=null ? personalInfo[1] : null;

  // userId = "+8801611115205";
  // password = '\$5\$rounds=10000\$^F!K%JXfZy&L6&@g\$YUWO1QRFxexBf42XR9vVM74cLpx74nrWxMbXbaLtkQA';
  runApp(MyApp(password: password,userId: userId,));
}

class MyApp extends StatelessWidget {

  final String userId,password;
  MyApp({required this.userId,required this.password});
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
              home:
              //FertilizerPage()
              SplashScreen(userId: userId,password: password,)
            //Fertilizer(),
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

    splashScreenDelay();
    if(widget.userId != ""){
      setSharedPreferences();
      setUserDetails();

    }
    super.initState();
  }

  splashScreenDelay(){
    Future.delayed(Duration(milliseconds: 3500),(){
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
  setUserDetails(){
    FirebaseFirestore.instance.collection('users').doc(widget.userId).snapshots().listen((DocumentSnapshot doc){
      sharedObjectsGlobal.userGlobal = AppUser.fromJson(doc);
      sharedObjectsGlobal.userSignIn = true;

    }).onError((handleError){
      sharedFunctionsGlobal.clearAppDataAfterLogout();
    });

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