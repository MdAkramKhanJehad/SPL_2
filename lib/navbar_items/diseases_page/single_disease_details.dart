import 'package:flutter/material.dart';
import 'package:spl_two_agri_pro/models/diseases_details.dart';
class SingleDiseaseDetails extends StatefulWidget {
  final Disease disease;
  final String plant_name;
  SingleDiseaseDetails({required this.disease,required this.plant_name});

  @override
  _SingleDiseaseDetailsState createState() => _SingleDiseaseDetailsState();
}

class _SingleDiseaseDetailsState extends State<SingleDiseaseDetails> {
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
                  image: AssetImage("assets/images/background-low-opacity.png"),
                  fit: BoxFit.cover
              )
          ),
        ),
        Scaffold(

        )
      ],
    );
  }
}
