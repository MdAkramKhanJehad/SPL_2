import 'package:agridictionaryoffline/animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:agridictionaryoffline/CustomWidgets.dart';


class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {

//
//  _launchURL() async {
//    final String sub = 'Suggestions About Agri-Dictionary';
//    final String body  = '';
//    final url = 'mailto:agrisciencesociety@yahoo.com?subject=$sub&body=$body';
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not launch $url';
//    }
//  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.black12,
      padding: EdgeInsets.all(40),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 40,),
            FadeAnimation(1,Text(
              'About Us',
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'Kreon',
                fontWeight: FontWeight.bold
              ),
            )),
            Divider(height: 5,color: Colors.black87,),
            SizedBox(height: 10,),
            Center(
              child: FadeAnimation(1.1,Text(
                'Agri-Science Society(AgSS)',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Kreon',
                  fontWeight: FontWeight.bold
                ),
              )),
            ),
            SizedBox(height: 7,),
            FadeAnimation(1.2,Text(
              '"Let\'s Make a Future of Agriculture"',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Kreon',
                fontWeight: FontWeight.bold
              ),
            )),
            SizedBox(height: 13,),
            AspectRatio(
              aspectRatio: 16/9,
              child: FadeAnimation(1.3,Image(image: AssetImage('assets/leaf.png'),))
            ),
            SizedBox(height: 35,),
            FadeAnimation(1.4,Text(
//              'Agri-Science Society(AgSS) is a non-profit agricultural organization founded on May,2019.The mission of AgSS is to transform traditional farming into smart farming.',
              'Any Suggestions?',
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'Volkhov',
                fontWeight: FontWeight.w100
              ),
            )),
            Center(
              child: FadeAnimation(1.5,RaisedButton(
                hoverElevation: 1,
                color: Colors.cyan,
                onPressed:() => launchURL(),
                child: Text('Mail AgSS'),
              )),
            ),

          ],
        ),
      ),
    );
  }
}

