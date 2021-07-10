import 'package:cloud_firestore/cloud_firestore.dart';

class Database{
  final FirebaseFirestore  _firestore = FirebaseFirestore.instance;

  createNewFirebaseUser({final userData,userId}){
    _firestore.collection('users').doc(userId).set(userData).then((value){


    });
  }



}