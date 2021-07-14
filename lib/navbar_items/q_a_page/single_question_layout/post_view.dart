import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spl_two_agri_pro/main.dart';
import 'package:spl_two_agri_pro/models/question.dart';
import 'package:spl_two_agri_pro/navbar_items/q_a_page/single_question_layout/single_question_middle_section.dart';
import 'single_question_footer_section.dart';
import 'single_question_header_section.dart';
class PostView extends StatefulWidget {
  final Question question;
  PostView({required this.question});
  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  TextEditingController commentController=TextEditingController();
  showAlertDialog(BuildContext context) {
    Widget cancelButton = MaterialButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = MaterialButton(
      child: Text("Comment"),
      onPressed:  () async{
        final comment={
          'userId' : sharedObjectsGlobal.userGlobal.phone_number,
          'details' : commentController.text.trim() ,
          'dislikes' : [] ,
          'likes' :  [],
          'postDate' : Timestamp.now() ,
        };
        print("comment = $comment");
        setComment(comment);
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      elevation: 7,
      title: Text("Comment Dialog"),
      content:   Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
        height:90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: sharedObjectsGlobal.deepGreen)
        ),
        child: TextField(
          maxLines: 5,
          controller: commentController,
          cursorColor: sharedObjectsGlobal.deepGreen,
          style: TextStyle(fontFamily: "Mina",fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black),
          decoration: InputDecoration(
            hintText: "Write your answer...",
            hintStyle: TextStyle(
                color:  Colors.grey,
                fontFamily: "Mina",
                fontWeight: FontWeight.w600
            ),
            border: InputBorder.none,

          ),
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  setComment(final data)async{
    FirebaseFirestore.instance.collection('questions').doc(widget.question.docId).collection('comments').add(data).then((docRef){
      FirebaseFirestore.instance.collection('questions').doc(widget.question.docId).update({
        "numberOfComments":FieldValue.increment(1),
      });
      setState(() {
        widget.question.numberOfComments+=1;
        commentController.clear();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    double heightMultiplier = height/712;
    double widthMultiplier= width/360;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 4,
            automaticallyImplyLeading: false,
            leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: sharedObjectsGlobal.deepGreen,size: 18*widthMultiplier ,),
              onPressed: (){
                print("back");
                Navigator.pop(context);
              },),
            actions: [
              TextButton(onPressed:(){
                showAlertDialog(context);
              }, child: Text("Write a comment",style: TextStyle(fontSize: 15*widthMultiplier,fontWeight: FontWeight.w600),)),
              SizedBox(width: 15*widthMultiplier,)
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  color: Colors.white,
                  child: Column(children: [
                    SingleQuestionHeader(question: widget.question,),
                    SingleQuestionMiddle(question: widget.question,isPostView: true,),
                    SingleQuestionFooter(question: widget.question,),

                  ],),
                ),
              ),
            ],
          ),
        ),

      ],
    );

  }
}
