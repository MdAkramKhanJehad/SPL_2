import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spl_two_agri_pro/main.dart';
import 'package:spl_two_agri_pro/models/question.dart';

import 'single_question_layout/single_question_header_section.dart';
import 'single_question_layout/single_question_middle_section.dart';

class QAPage extends StatefulWidget {

  @override
  _QAPageState createState() => _QAPageState();
}

class _QAPageState extends State<QAPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  Widget  askCommunityButton(){
    return GestureDetector(
      onTap: (){
        print("Ask Community");
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        decoration: BoxDecoration(
          color:  Color(0xff3A7F0D),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(FontAwesomeIcons.penFancy,color: Colors.white,),
            SizedBox(width: 10,),
            Text("Ask Community",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Mina",fontSize: 16),),
          ],
        ),
      ),
    );
  }

  Future<List<Question>> getQuestions()async{
    List<Question> questionList=[];
    return   FirebaseFirestore.instance.collection('questions').limit(5).get().then((querySnapshot){
      querySnapshot.docs.forEach((doc){
        Question q = Question.fromJson(doc);
        questionList.add(q);

      });
      return questionList;
    });
  }
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    double heightMultiplier = height/712;
    double widthMultiplier= width/360;
    TextStyle appBarTitleStyle=TextStyle(
      fontFamily: "Mina",
      letterSpacing: 0,
      fontSize: 18/widthMultiplier,fontWeight: FontWeight.w800,color:   Colors.white,);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.blueGrey.withOpacity(0.5),
      appBar: AppBar(
        backgroundColor:  Color(0xff3A7F0D),
        backwardsCompatibility: false,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: Text("Question Answer Forum", style:appBarTitleStyle ),
        actions: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10*widthMultiplier,),
            child: IconButton(icon: Icon(Icons.settings,size: 30*widthMultiplier,color:   Color(0xff3A7F0D)),
                onPressed: (){
                  print("Menu tap");
                  scaffoldKey.currentState!.openEndDrawer();
                }
            ),
          )

        ],
      ),
      floatingActionButton: askCommunityButton(),
      body: FutureBuilder(
        future: getQuestions(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            List<Question> questionList = snapshot.data as List<Question>;

            return SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: questionList.length,
                  itemBuilder: (context,index){
                    Question question = questionList[index];

                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(bottom: 10),
                          margin: EdgeInsets.only(top:5,bottom: 5,left: 5,right: 5),
                          child: Column(children: [
                            question.questionImageLinks.length==0? Container():  SingleQuestionHeader(question: question,),
                            Container(
                              child: SingleQuestionMiddle(question: question,),
                            )

                          ],)),
                    );
                  },
                )
            );
          }else if(snapshot.hasError){
            return Container(
              child: Text("Error"),
            );
          }else{
            return Container(
              height: height,width: width,
              child: Center(child: sharedObjectsGlobal.circularProgressCustomize,),
            );
          }

        },
      ),

    );
  }
}
