import 'package:cloud_firestore/cloud_firestore.dart';

class Comment{
  final List<String> likes,dislikes;
  final String details,userId,docId;
  final Timestamp postDate;

  Comment({
    required this.docId,
    required this.details,
    required this.likes,required this.dislikes,
    required this.userId,required this.postDate
  });
  factory Comment.fromJson(doc){
    return Comment(
      userId:doc['userId'] ,
      details: doc["details"],
      dislikes:doc.data().containsKey("dislikes")? List<String>.from(doc['dislikes'])  :[],
      likes:doc.data().containsKey("likes")? List<String>.from(doc['likes']):[],
      postDate:doc['postDate'] ,
      docId: doc.id,
    );
  }
}
