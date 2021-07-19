import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:spl_two_agri_pro/main.dart';
import 'package:spl_two_agri_pro/models/comment.dart';
import 'package:spl_two_agri_pro/models/question.dart';
import 'package:spl_two_agri_pro/models/user.dart';
import 'package:timeago/timeago.dart'as timeago;

class SingleQuestionFooter extends StatefulWidget {
  final Question question;
  SingleQuestionFooter({required this.question});
  @override
  _SingleQuestionFooterState createState() => _SingleQuestionFooterState();
}

class _SingleQuestionFooterState extends State<SingleQuestionFooter> {


  Future<List<Comment>> getPostComments(){
    List<Comment>cmntList = [];
    return FirebaseFirestore.instance.collection('questions').doc(widget.question.docId).collection('comments').orderBy('postDate',descending: true).get().then((querySnapshot){
      querySnapshot.docs.forEach((doc) {
        Comment c= Comment.fromJson(doc);
        cmntList.add(c);
      });
      return cmntList;
    });
  }
  Future<AppUser>getCommentWriterDetails(String userId){
    return  FirebaseFirestore.instance.collection('users').doc(userId).get().then((doc){
      AppUser appUser = AppUser.fromJson(doc);
      return appUser;
    });
  }

  String  calculateTimeShowingMethod(Timestamp givenTime){
    int difference =Timestamp.now().seconds-givenTime.seconds;
    if(difference>100000){
      return  DateFormat.yMMMd().add_jm().format(givenTime.toDate());
    }else{
      return timeago.format(givenTime.toDate());
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    double heightMultiplier = height/712;
    double widthMultiplier= width/360;
    TextStyle bodyTextStyle = TextStyle(
      color:  Colors.black,
      fontWeight: FontWeight.w500,
      fontFamily: "Mina",
      letterSpacing: 0,
      fontSize: 14/widthMultiplier,
    );
    TextStyle postInfoTextStyle = TextStyle(
      fontFamily: "Mina",
      letterSpacing: 0,
      fontSize: 14/widthMultiplier,fontWeight: FontWeight.w700,color: sharedObjectsGlobal.educationGreen,);
    TextStyle bodyTitle = TextStyle(
      fontFamily: "Mina",
      letterSpacing: 0,
      fontSize: 18/widthMultiplier,fontWeight: FontWeight.w800,color:   Color(0xff3A7F0D),);

    return Container(
        color: Colors.blueGrey.shade100,
        child: FutureBuilder(
          future: getPostComments(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              List<Comment> commentList = snapshot.data as List<Comment>;
              return ListView.builder(
                padding: EdgeInsets.all(0.0),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: commentList.length,
                itemBuilder: (context,index){
                  Comment comment = commentList[index];
                  return Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 4,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10*widthMultiplier),
                          child: FutureBuilder<AppUser>(
                              future:getCommentWriterDetails(comment.userId),
                              builder: (context, userSnapshot) {
                                if(userSnapshot.hasData){
                                  AppUser app_user = userSnapshot.data as AppUser;
                                  return  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        child: Center(
                                          child:  CircleAvatar(
                                            radius: 17*widthMultiplier,
                                            backgroundColor: Colors.white,
                                            child: ClipOval(
                                              child: SizedBox(
                                                  height: 34*widthMultiplier,
                                                  width: 34*widthMultiplier,
                                                  child: Image.network(
                                                    app_user.imageUrl,
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 15,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(app_user.user_name,textAlign: TextAlign.left,style: postInfoTextStyle),
                                          Text( calculateTimeShowingMethod(comment.postDate),textAlign: TextAlign.left,style: postInfoTextStyle),
                                        ],
                                      )
                                    ],
                                  );
                                }else{
                                  return Container(
                                    child: Center(child: sharedObjectsGlobal.circularProgressCustomize),
                                  );
                                }
                              }
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10*widthMultiplier),
                          child: Text(comment.details,
                            maxLines: 30,overflow: TextOverflow.ellipsis,textAlign: TextAlign.left,
                            style: bodyTextStyle,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10*widthMultiplier),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  if(sharedObjectsGlobal.userSignIn){
                                    if( comment.likes.contains(sharedObjectsGlobal.userGlobal.phone_number)){
                                      FirebaseFirestore.instance.collection('questions').doc(widget.question.docId).collection('comments').doc(comment.docId).update({
                                        "likes":FieldValue.arrayRemove([sharedObjectsGlobal.userGlobal.phone_number]),
                                      });
                                      comment.likes.remove(sharedObjectsGlobal.userGlobal.phone_number);
                                    }else{
                                      FirebaseFirestore.instance.collection('questions').doc(widget.question.docId).collection('comments').doc(comment.docId).update({
                                        "likes":FieldValue.arrayUnion([sharedObjectsGlobal.userGlobal.phone_number]),
                                        "dislikes":FieldValue.arrayRemove([sharedObjectsGlobal.userGlobal.phone_number]),
                                      });
                                      comment.dislikes.remove(sharedObjectsGlobal.userGlobal.phone_number);
                                      comment.likes.add(sharedObjectsGlobal.userGlobal.phone_number);
                                    }
                                    setState(() {});
                                  }
                                },
                                child: Icon(comment.likes.contains(sharedObjectsGlobal.userGlobal.phone_number)?FontAwesomeIcons.solidThumbsUp:FontAwesomeIcons.thumbsUp,
                                  color:sharedObjectsGlobal.userSignIn? sharedObjectsGlobal.educationGreen: Colors.grey,
                                ),
                              ),
                              SizedBox(width: 3,),
                              Text(comment.likes.length.toString(),style: TextStyle(color: sharedObjectsGlobal.educationGreen,fontSize: 10,fontFamily: "Mina",fontWeight: FontWeight.w700),),
                              SizedBox(width: 50,),
                              GestureDetector(
                                onTap: (){
                                  if(sharedObjectsGlobal.userSignIn){
                                    if( comment.dislikes.contains(sharedObjectsGlobal.userGlobal.phone_number)){
                                      FirebaseFirestore.instance.collection('questions').doc(widget.question.docId).collection('comments').doc(comment.docId).update({
                                        "dislikes":FieldValue.arrayRemove([sharedObjectsGlobal.userGlobal.phone_number]),
                                      });
                                      comment.dislikes.remove(sharedObjectsGlobal.userGlobal.phone_number);
                                    }else{
                                      FirebaseFirestore.instance.collection('questions').doc(widget.question.docId).collection('comments').doc(comment.docId).update({
                                        "dislikes":FieldValue.arrayUnion([sharedObjectsGlobal.userGlobal.phone_number]),
                                        "likes":FieldValue.arrayRemove([sharedObjectsGlobal.userGlobal.phone_number]),
                                      });
                                      comment.dislikes.add(sharedObjectsGlobal.userGlobal.phone_number);
                                      comment.likes.remove(sharedObjectsGlobal.userGlobal.phone_number);
                                    }
                                    setState(() {});
                                  }
                                },
                                child: Icon(comment.dislikes.contains(sharedObjectsGlobal.userGlobal.phone_number)?FontAwesomeIcons.solidThumbsDown:FontAwesomeIcons.thumbsDown,
                                  color:sharedObjectsGlobal.userSignIn ? sharedObjectsGlobal.errorColor:  Colors.grey,
                                ),
                              ),
                              SizedBox(width: 3,),

                              Text(comment.dislikes.length.toString(),
                                style: TextStyle(color: sharedObjectsGlobal.errorColor,fontSize: 10,fontFamily: "Mina",fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        index ==commentList.length-1 ?SizedBox(height: 20*heightMultiplier,):
                        SizedBox(
                          width: width,
                          child: Divider(color: Colors.white,),
                        )
                      ],
                    ),
                  );
                },
              );
            }else {
              return Container(
                child: Center(child: sharedObjectsGlobal.circularProgressCustomize,),
              );
            }
          },
        )
    );
  }
}
