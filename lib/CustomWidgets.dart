import 'package:agridictionaryoffline/pages/AddWord.dart';
import 'package:agridictionaryoffline/pages/FrequentlyAskedQuestions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:agridictionaryoffline/pages/History.dart';


launchURL() async {
  try{
    String sub = 'Suggestions About Agri-Dictionary';
    String body  = '';
    final url = 'mailto:agrisciencesociety@yahoo.com?subject=$sub&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }catch(e){
    // print('in custom widget launch url: ${e.message}');
  }
}

Drawer buildDrawer(BuildContext context){
  // FocusScope.of(context).unfocus();
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
                child:
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 45,),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Fenix',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDisclaimer?Colors.red.shade900 : Colors.black87
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
                      SizedBox(height: 12,),
                      bottomButtonMaker(),
                    ],
                  ),
                )

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
        Container(
          height: 210,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF006666),
            ),
            child: SingleChildScrollView(
              child: Container(
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
              )
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                title: Text('Email AgSS',style: TextStyle(
                  fontFamily: 'Kreon',
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
                leading: Icon(Icons.markunread,color: Colors.teal,size: 28,),
                onTap: () =>  makeCustomDialog(context,'Send us Feedback',
                  'Do you have any  suggestions? Please send us an email. Thanks for your '
                    'cooperation.',250,true,false),
              ),
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
                title: Text('Disclaimer',style: TextStyle(
                  fontFamily: 'Kreon',
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
                leading: Icon(Icons.add_alert,color: Colors.teal,size: 28,),
                onTap: () => makeCustomDialog(context,'Disclaimer',
                  'This dictionary may be used entirely at the user\'s risk and don\'t claim to'
                    ' be highly accurate or free from errors. It should be used only for educational'
                    ' purposes. Words are collected from so many resources. We are Grateful to them.'
                    ,321, false,true),
              ),

              ListTile(
                //All right reserved to Agri-Science Society
                title: Text('Copyright',style: TextStyle(
                  fontFamily: 'Kreon',
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
                leading: Icon(Icons.copyright,color: Colors.teal,size: 28,),
                onTap: () => makeCustomDialog(context,'Copyright',
                  'All right reserved to Agri-Science Society',220,false,false),
              ),

              ListTile(
                title: Text('History',style: TextStyle(
                  fontFamily: 'Kreon',
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
                leading: Icon(Icons.history,color: Colors.teal,size: 28,),
                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => History())),
              ),
              ListTile(
                title: Text('FAQ',style: TextStyle(
                  fontFamily: 'Kreon',
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
                leading: Icon(Icons.question_answer,color: Colors.teal,size: 28,),
                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => FrequentlyAskedQuestions())),
              )
            ],
          ),
        )
      ],
    )),
  );
}