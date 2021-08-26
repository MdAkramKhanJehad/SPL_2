import 'package:agridictionaryoffline/CustomAppBar.dart';
import 'package:flutter/material.dart';

class FrequentlyAskedQuestions extends StatelessWidget {
  String question1 = "Q1: What is Agri-Science Society?";
  String answer1 = "A1: Agri-Science Society is an agricultural based organization working towards digitalization of Agriculture.";
  String question2 = "Q2: Why was this dictionary developed?";
  String answer2 = "A2: We developed this dictionary to facilitate agricultural education all over the World.";
  String question3 = "Q3: Is this dictionary free of cost to use?";
  String answer3 = "A3: Yes.";
  String question4 = "Q4: Can I use this dictionary without internet connection?";
  String answer4 = "A4: Yes.";
  String question5 = "Q5: If I add word in \"Add Word\" feature,will those word visible to everyone?";
  String answer5 = "A5: No, only you will see your newly added words.";
  String question6 = "Q6: How many words can I add using \"Add Word\" feature in this dictionary app?";
  String answer6 = "A6: As many as you wish!";
  String question7 = "Q7: Is this dictionary app covered words from all the subjects related to Agriculture?";
  String answer7 = "A7: Yes, we tried and will update continuously this dictionary with new words as well as new features.";

  
  Widget questionMaker(String question,BuildContext context){
    return Container(
      color: Colors.black12,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
        child: Text(
          question,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.teal.shade800,
            fontFamily: "Fenix"
          ),
        ),
    );
  }

  Widget answerMaker(String ans){
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 5,bottom: 5,left: 18,right: 10),
          child:
            Text(
              ans,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.teal.shade800,
                fontFamily: 'Fenix'
              ),
            )
        ),
        SizedBox(height: 10,)
      ],
    ) ;
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'FAQs'),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ Colors.black26,Colors.white12],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
        ),
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              questionMaker(question1,context),
              answerMaker(answer1),
              questionMaker(question2,context),
              answerMaker(answer2),
              questionMaker(question3,context),
              answerMaker(answer3),
              questionMaker(question4,context),
              answerMaker(answer4),
              questionMaker(question5,context),
              answerMaker(answer5),
              questionMaker(question6,context),
              answerMaker(answer6),
              questionMaker(question7,context),
              answerMaker(answer7),
            ],
          ),
        ),
      )
    );
  }
}
