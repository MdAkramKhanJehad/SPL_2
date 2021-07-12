
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spl_two_agri_pro/main.dart';



class DialogWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    TextStyle questionStyle= TextStyle(fontFamily: "Mina",fontSize:14*sharedObjectsGlobal.widthMultiplier ,fontWeight:FontWeight.w600 ,color: sharedObjectsGlobal.deepGreen);
    TextStyle  answerStyle= TextStyle(fontFamily: "Mina",fontSize:13*sharedObjectsGlobal.widthMultiplier ,fontWeight:FontWeight.w500 ,color: Colors.black);

    return Dialog(
      elevation: 7.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      insetAnimationCurve: Curves.bounceInOut,
      child: Stack(
        alignment: Alignment.topCenter,
        overflow: Overflow.visible,
        children: [
          Container(
            height: 600,
            width: 320,
            padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
            decoration: new BoxDecoration(
             // borderRadius: BorderRadius.all(Radius.circular(30.0)),
            //  color: Colors.deepOrange
            ),
            child: ListView(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              //  crossAxisAlignment: CrossAxisAlignment.stretch,
              //  mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select Your Crop",style: questionStyle,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context,"");
                      },
                      child: Text("Cancel",style: TextStyle(
                        color: Colors.red,fontFamily: "Mina",fontSize: 14
                      ),),
                    ),
                  ],
                ),
                ListView.builder(
                  itemCount: sharedObjectsGlobal.crops.length,
                 shrinkWrap: true,

                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.pop(context,sharedObjectsGlobal.crops[index]);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 7),
                        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                        decoration: BoxDecoration(
                          color:Colors.white
                        ),
                        child: Text(
                          sharedObjectsGlobal.crops[index].toString(),style: TextStyle(
                          fontFamily: "Mina",
                          fontSize: 13,
                          color: Colors.black
                        ),
                        ),
                      ),
                    );
                  },
                ),

              ],
            ),
          ),

        ],
      ),

    );
  }
}