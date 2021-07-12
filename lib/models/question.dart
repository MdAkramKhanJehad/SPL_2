import 'package:cloud_firestore/cloud_firestore.dart';

class Question{
  final String questionDetails,userId,questionId,mainQuestion,docId;
  final  List<String> questionImageLinks,relatedCategories;
  final Timestamp questionPostedDate;
  final List<String> likes,dislikes;
  int numberOfComments;
  // final List<dynamic>popularCommentsId;

  Question({required this.questionId,required this.docId,required this.mainQuestion,required this.numberOfComments,required this.relatedCategories,
    required this.questionDetails,required this.userId,
    required this.questionImageLinks,required this.questionPostedDate,required this.dislikes,required this.likes});

  @override
  String toString() {
    return 'Question{questionDetails: $questionDetails, userId: $userId, questionId: $questionId, mainQuestion: $mainQuestion, questionImageLinks: $questionImageLinks, relatedCategories: $relatedCategories, questionPostedDate: $questionPostedDate, likes: $likes, dislikes: $dislikes, numberOfComments: $numberOfComments}';
  }

  factory Question.fromJson(doc){
    return Question(
      docId: doc.id,
      mainQuestion :doc.data()!.containsKey('mainQuestion')?doc['mainQuestion']:"",
      questionId: doc.id,
      numberOfComments: doc['numberOfComments'],
      userId: doc['userId'] ,
      questionDetails: doc['details'],
      questionImageLinks: doc.data()!.containsKey("imageLinks") ? List<String>.from(doc['imageLinks']): [],
      questionPostedDate: doc['postDate'],
      dislikes:doc.data()!.containsKey("dislikes")? List<String>.from(doc['dislikes'])  :[],
      likes:doc.data()!.containsKey("likes")? List<String>.from(doc['likes']):[],
      relatedCategories: doc.data()!.containsKey('relatedCategories')? List<String>.from(doc['relatedCategories']):[],
    );
  }
}