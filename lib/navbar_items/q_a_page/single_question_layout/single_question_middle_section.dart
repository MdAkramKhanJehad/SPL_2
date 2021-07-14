import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:spl_two_agri_pro/main.dart';
import 'package:spl_two_agri_pro/models/question.dart';
import 'package:spl_two_agri_pro/models/user.dart';
import 'package:timeago/timeago.dart'as timeago;
import 'post_view.dart';

class SingleQuestionMiddle extends StatefulWidget {
  final Question question;
  final bool isPostView;
  SingleQuestionMiddle({required this.question , required this.isPostView});
  @override
  _SingleQuestionMiddleState createState() => _SingleQuestionMiddleState();
}

class _SingleQuestionMiddleState extends State<SingleQuestionMiddle> {

  late String  postDate;
  calculateTimeShowingMethod(){
    int difference =Timestamp.now().seconds-widget.question.questionPostedDate.seconds;
    if(difference>100000){
      postDate =   DateFormat.yMMMd().add_jm().format(widget.question.questionPostedDate.toDate());
    }else{
      postDate = timeago.format(widget.question.questionPostedDate.toDate());
    }
    //
  }
  Future<AppUser> getPostOwnerInfo()async{
    return FirebaseFirestore.instance.collection('users').doc(widget.question.userId).get().then((doc){
      AppUser appUser = AppUser.fromJson(doc);
      return appUser;
    });
  }
  @override
  void initState() {
    getPostOwnerInfo();
    calculateTimeShowingMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    double heightMultiplier = height/712;
    double widthMultiplier= width/360;
    TextStyle bodyTextStyle = TextStyle(
      color:  Colors.black54,
      fontWeight: FontWeight.w500,
      fontFamily: "Mina",
      letterSpacing: 0,
      fontSize: 14*widthMultiplier,
    );
    TextStyle bodyTitleStyle = TextStyle(
      color:  Colors.black,
      fontWeight: FontWeight.w800,
      fontFamily: "Mina",
      letterSpacing: 0,
      fontSize: 16*widthMultiplier,
    );
    TextStyle postInfoTextStyle = TextStyle(
      fontFamily: "Mina",
      letterSpacing: 0,
      fontSize: 14/widthMultiplier,fontWeight: FontWeight.w800,color:   Color(0xff3A7F0D),);

    return FutureBuilder(
      future: getPostOwnerInfo(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          AppUser appUser = snapshot.data as AppUser;
          return  GestureDetector(
            onTap: (){
              if(!widget.isPostView){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>PostView(question: widget.question,)));
              }
            },
            child: Container(
              padding: EdgeInsets.only(left: 15,right: 20,top: 5,bottom: 10),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  SizedBox(height: 4,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: Center(
                          child:  CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Image.network(
                                    appUser.imageUrl,
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
                          Text(appUser.user_name,textAlign: TextAlign.left,style: postInfoTextStyle),

                          FittedBox(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(postDate,overflow: TextOverflow.ellipsis,textAlign: TextAlign.left,style: postInfoTextStyle),
                                SizedBox(width: 12,),
                                widget.question.relatedCategories.length==0?Container():
                                Text("* ${widget.question.relatedCategories[0].toString()}",style: postInfoTextStyle,),
                              ],
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                  SizedBox(height: 5,),
                  Text(widget.question.mainQuestion,
                    maxLines:widget.isPostView?10: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.left,
                    style: bodyTitleStyle,
                  ),
                  SizedBox(height: 5,),
                  Text(widget.question.questionDetails,
                    maxLines:widget.isPostView?50: 6,overflow: TextOverflow.ellipsis,textAlign: TextAlign.left,
                    style: bodyTextStyle,
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      GestureDetector(
                          onTap: (){
                            if( widget.question.likes.contains(sharedObjectsGlobal.userGlobal.phone_number)){
                              FirebaseFirestore.instance.collection('questions').doc(widget.question.docId).update({
                                "likes":FieldValue.arrayRemove([sharedObjectsGlobal.userGlobal.phone_number]),
                              });
                              widget.question.likes.remove(sharedObjectsGlobal.userGlobal.phone_number);
                            }else{
                              FirebaseFirestore.instance.collection('questions').doc(widget.question.docId).update({
                                "likes":FieldValue.arrayUnion([sharedObjectsGlobal.userGlobal.phone_number]),
                                "dislikes":FieldValue.arrayRemove([sharedObjectsGlobal.userGlobal.phone_number]),
                              });
                              widget.question.dislikes.remove(sharedObjectsGlobal.userGlobal.phone_number);
                              widget.question.likes.add(sharedObjectsGlobal.userGlobal.phone_number);
                            }
                            setState(() {});

                          },
                          child: Icon(widget.question.likes.contains(sharedObjectsGlobal.userGlobal.phone_number)?FontAwesomeIcons.solidThumbsUp:FontAwesomeIcons.thumbsUp,
                            color:widget.question.likes.contains(sharedObjectsGlobal.userGlobal.phone_number)? Colors.green: Colors.blueGrey,
                          )),
                      SizedBox(width: 3,),
                      Text(widget.question.likes.length.toString(),style: TextStyle(color: Color(0xff3A7F0D),fontSize: 10,fontFamily: "Mina",fontWeight: FontWeight.w700),),
                      SizedBox(width: 50,),
                      GestureDetector(
                          onTap: (){
                            if( widget.question.dislikes.contains(sharedObjectsGlobal.userGlobal.phone_number)){
                              FirebaseFirestore.instance.collection('questions').doc(widget.question.docId).update({
                                "dislikes":FieldValue.arrayRemove([sharedObjectsGlobal.userGlobal.phone_number]),
                              });
                              widget.question.dislikes.remove(sharedObjectsGlobal.userGlobal.phone_number);
                            }else{
                              FirebaseFirestore.instance.collection('questions').doc(widget.question.docId).update({
                                "dislikes":FieldValue.arrayUnion([sharedObjectsGlobal.userGlobal.phone_number]),
                                "likes":FieldValue.arrayRemove([sharedObjectsGlobal.userGlobal.phone_number]),
                              });
                              widget.question.dislikes.add(sharedObjectsGlobal.userGlobal.phone_number);
                              widget.question.likes.remove(sharedObjectsGlobal.userGlobal.phone_number);
                            }
                            setState(() {});

                          },
                          child: Icon(widget.question.dislikes.contains(sharedObjectsGlobal.userGlobal.phone_number)?FontAwesomeIcons.solidThumbsDown:FontAwesomeIcons.thumbsDown,
                            color:widget.question.dislikes.contains(sharedObjectsGlobal.userGlobal.phone_number)? Colors.red: Colors.grey,

                          )),
                      SizedBox(width: 3,),
                      Text(widget.question.dislikes.length.toString(),
                        style: TextStyle(color: Colors.red,fontSize: 10,fontFamily: "Mina",fontWeight: FontWeight.w700),
                      ),
                      Expanded(child: Container()),
                      GestureDetector(
                          onTap: (){
                            if(!widget.isPostView){
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>PostView(question: widget.question,)));
                            }

                          },
                          child: Icon(FontAwesomeIcons.commentAlt,color: Colors.grey,)),
                      SizedBox(width: 3,),
                      Text(widget.question.numberOfComments.toString(),
                        style: TextStyle(color: Colors.red,fontSize: 10,fontFamily: "Mina",fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }else{
          return Container(
            height: height,width: width,
            child: Center(child: sharedObjectsGlobal.circularProgressCustomize,),
          );
        }
      },
    );

  }
}
