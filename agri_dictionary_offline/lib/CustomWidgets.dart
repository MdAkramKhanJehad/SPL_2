import 'package:agridictionaryoffline/pages/AboutUs.dart';
import 'package:agridictionaryoffline/pages/AddWord.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL() async {
  String sub = 'Suggestions About Agri-Dictionary';
  String body  = '';
  final url = 'mailto:agrisciencesociety@yahoo.com?subject=$sub&body=$body';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Drawer buildDrawer(BuildContext context){


  makeCustomDialog(BuildContext context, String title, String content, double heightOfBox, bool isEmail, bool isDisclaimer){
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (dialogContext){
        bottomButtonMaker(){
          if(isEmail){
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  minWidth: 100,
                  height: 39,
                  onPressed: ()=> launchURL() ,
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Text("Send Email", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Colors.black87,
                    fontFamily: 'Fenix'
                  ),),
                ),
                MaterialButton(
                  minWidth: 50,
                  height: 39,
                  onPressed: ()=>Navigator.pop(context, true) ,
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Text("Exit", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Colors.black87,
                    fontFamily: 'Fenix'
                  ),),
                )
              ],
            );
          }else{
            return MaterialButton(
              minWidth: 50,
              height: 39,
              onPressed: ()=>Navigator.pop(context, true) ,
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)
              ),
              child: Text("Ok", style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                color: Colors.black87,
                fontFamily: 'Fenix'
              ),),
            );
          }
        }
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.all(Radius.circular(25)),
          ),
          child: Stack(
            overflow: Overflow.visible,
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(80, 167, 194, 1),
                      Color.fromRGBO(183, 248, 219, 1)
                    ]
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                    side: BorderSide(
                      width: 1,
                      color: Colors.black87,
                    ),
                  ),
                ),

                padding: EdgeInsets.fromLTRB(10,19,5,5),
                height: heightOfBox,
                width: 290,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 45,),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Volkhov',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isDisclaimer?Colors.red : Colors.black
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text(
                      content,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Fenix',
                      ),
                    ),
//                    Navigator.pop(context, true)
                    SizedBox(height: 20,),
                    bottomButtonMaker(),
                  ],
                ),
              ),
              Positioned(
                top: -50,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  child: Image.asset('assets/leaf2.png',),
                ),
              )
            ],
          ),
        );
      }
    );
  }


  return Drawer(
    child: Container(
      color: Colors.black12,
      child:ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Color(0xFF006666),
          ),
          child: Container(
//            color: Color(0xFF006666),
            padding: EdgeInsets.only(left: 5, top: 0, right: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                  width: 70.0,
                  height: 70.0,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage("assets/leaf2.png")
                    )
                  )),
//                Image.asset('assets/leaf.png',height: 70,width: 70,),
                SizedBox(height: 8,),
                Text(
                  'Dictionary of Agriculture ',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Fenix',
                  ),
                ),
                Text(
                  'A service of Agri-Science Society(AgSS)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontFamily: 'Fenix',
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          // color: Colors.black12,
          padding: EdgeInsets.only(left: 15),
//          decoration: BoxDecoration(
//            color: Colors.teal
//          ),
//          color: Colors.teal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                title: Text('Add Word',style: TextStyle(
                  fontFamily: 'Kreon',
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
                leading: Icon(Icons.add,color: Colors.teal,size: 28,),
                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => AddWord())),
              ),
              ListTile(
                title: Text('Email AgSS',style: TextStyle(
                  fontFamily: 'Kreon',
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
                leading: Icon(Icons.markunread,color: Colors.teal,size: 28,),
                onTap: () =>  makeCustomDialog(context,'Send us Feedback',
                  'Do you have any  suggestions? Please send us an email. Thanks for your cooperation.',280,true,false),
              ),
              ListTile(
                //All right reserved to Agri-Science Society
                title: Text('Copyright',style: TextStyle(
                  fontFamily: 'Kreon',
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
                leading: Icon(Icons.copyright,color: Colors.teal,size: 28,),
                onTap: () => makeCustomDialog(context,'Agri-Dictionary',
                  'All right reserved to Agri-Science Society',230,false,false),
              ),
              ListTile(
                title: Text('Disclaimer',style: TextStyle(
                  fontFamily: 'Kreon',
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
                leading: Icon(Icons.add_alert,color: Colors.teal,size: 28,),
                onTap: () => makeCustomDialog(context,'Disclaimer',
                    'This dictionary may be used entirely at the User\'s risk. The contents of this application do not claim to be highly accurate or free from errors. It must be use for Educational purposes only.',310, false,true),
              ),
              ListTile(
                title: Text('About Us',style: TextStyle(
                  fontFamily: 'Kreon',
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
                leading: Icon(Icons.perm_identity,color: Colors.teal,size: 28,),
                onTap: () =>
                makeCustomDialog(context,'Agri-Science Society',
                  'Agri-Science  Society (AgSS)  is a Non-profit Agricultural organisation trying to bring revolutionary changes in our agriculture sector by digitalizing it.'
                    ' The mission  of  AgSS is to transform Traditional Farming into Smart Farming.', 370,false, false),
//                  Navigator.push(context, MaterialPageRoute(builder:
//                              (context) => AboutUs())),
              ),
              ListTile(
                title: Text('Rate us',style: TextStyle(
                  fontFamily: 'Kreon',
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
                leading: Icon(Icons.star_half,color: Colors.teal,size: 28,),
//                onTap: ()=>,
              ),
              ListTile(
                title: Text('FAQ',style: TextStyle(
                  fontFamily: 'Kreon',
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
                leading: Icon(Icons.question_answer,color: Colors.teal,size: 28,),
//                onTap: ()=>,
              )
            ],
          ),
        ),
      ],
    )),
  );
}