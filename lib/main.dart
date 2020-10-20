import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'animation/FadeAnimation.dart';
import 'login.dart';



void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage( ),
    )
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FadeAnimation(1, Text("Welcome to", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                      ),)),
                      SizedBox(height: 5,),
                      FadeAnimation(1.2, Text("Agri-Science Society",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 30
                      ),)),
                    ],
                  ),
                  FadeAnimation(1.4, Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/leaf.png')
                      )
                    ),
                  )),
                  SizedBox(height: 15,),
                  FadeAnimation(1.5, Text("Choose your Profession!", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.blueGrey
                  ),)),
                  SizedBox(height: 10,),
                  Column(
                    children: <Widget>[
                      FadeAnimation(1.6, MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                        },
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black
                          ),
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: Text("Student", style: TextStyle(
                          fontWeight: FontWeight.w600, 
                          fontSize: 18
                        ),),
                      )),
                      SizedBox(height: 15,),
                      FadeAnimation(1.7, Container(
                        padding: EdgeInsets.only(top: 3, left: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                          )
                        ),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                          },
                          color: Colors.yellow,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: Text("Farmer", style: TextStyle(
                            fontWeight: FontWeight.w600, 
                            fontSize: 18
                          ),),
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
