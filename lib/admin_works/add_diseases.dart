import 'package:flutter/material.dart';
import 'package:spl_two_agri_pro/main.dart';

class AddDiseases extends StatefulWidget {
  const AddDiseases({Key? key}) : super(key: key);

  @override
  _AddDiseasesState createState() => _AddDiseasesState();
}

class _AddDiseasesState extends State<AddDiseases> {

  TextEditingController textEditingController = TextEditingController();
  InputBorder _inputBorder = OutlineInputBorder(
    borderSide:  BorderSide(color: Color(0xff27462A), width: 2),
  );


  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    double heightMultiplier = height/712;
    double widthMultiplier= width/360;

    TextStyle title=TextStyle( fontFamily: "Mina",
      fontSize: 16*widthMultiplier,fontWeight: FontWeight.w800,
      color:sharedObjectsGlobal.deepGreen,
    );
    TextStyle labelStyle=TextStyle( fontFamily: "Mina",
      color:sharedObjectsGlobal.deepGreen,
    );
    TextStyle subtitle=TextStyle( fontFamily: "Mina",
      fontSize: 14*widthMultiplier,fontWeight: FontWeight.w500,
      color:Colors.black,
    );

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
          body: SafeArea(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Center(child: Text("Add New Disease",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24*widthMultiplier,color: sharedObjectsGlobal.deepGreen,fontFamily: "Mina"),)),

                  SizedBox(height: 50*heightMultiplier,),

                  Padding(

                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      cursorColor: Colors.black,
                      controller: textEditingController,
                      decoration: InputDecoration(

                        errorText: "There is an error",
                        labelStyle: labelStyle,
                        enabledBorder: _inputBorder ,
                        focusedBorder: _inputBorder,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        labelText: 'Full Name',
                      ),

                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
