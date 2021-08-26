import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {

  _launchURLl(String fbProtocolUrl, String fallbackUrl) async {
    try {
      bool launched = await launch(fbProtocolUrl, forceSafariVC: false);

      if (!launched) {
        await launch(fallbackUrl , forceSafariVC: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.black12,
      padding: EdgeInsets.all(30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 40,),
            Text(
              'About Us',
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'Kreon',
                fontWeight: FontWeight.bold
              ),
            ),
            Divider(height: 5,color: Colors.black87,),
            SizedBox(height: 10,),
            Center(
              child: Text(
                'Agri-Science Society(AgSS)',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Kreon',
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 7,),
            Text(
              '"Let\'s Make a Future of Agriculture"',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Kreon',
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10,),
            AspectRatio(
              aspectRatio: 4/2,
              child: Image(image: AssetImage('assets/leaf.png'),)
            ),
            SizedBox(height: 10,),
            Text(
              "Join us",
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Volkhov',
                fontWeight: FontWeight.w100
              ),
            ),
            SizedBox(height: 10,),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Image.asset('assets/facebook.png'),
                    iconSize: 50,
                    onPressed: () {
                      _launchURLl("fb://page/102190607876880","https://www.facebook.com/agrisciencesociety");
                    },
                  ),
                  SizedBox(width: 10,),
                  IconButton(
                    icon: Image.asset('assets/linkedin.png'),
                    iconSize: 50,
                    onPressed: () {
                      _launchURLl("linkedin://profile/company/53480554","https://linkedin.com/company/agri-science-society-agss");
                    },
                  ),
                  SizedBox(width: 10,),
                  IconButton(
                    icon: Image.asset('assets/twitter.png'),
                    iconSize: 50,
                    onPressed: () {
                      _launchURLl("twitter://user?screen_name=MakeAgriculture","https://twitter.com/MakeAgriculture?s=03");
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

