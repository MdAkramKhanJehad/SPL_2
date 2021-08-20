
import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser{
  final  String user_name,phone_number,imageUrl, district, division,bio,password;
  final bool status,isAdmin;
  AppUser({required this.bio,required this.district, required this.isAdmin,required this.status,required this.division,required this.password,
    required this.imageUrl,required this.phone_number,required this.user_name});

  factory AppUser.fromJson(DocumentSnapshot doc){
    return AppUser(
      bio: doc['bio'],
      district: doc['district'],
      division: doc['division'],
      imageUrl: doc['imageUrl'],
      phone_number: doc['phone_number'],
      user_name: doc['user_name'],
      password:doc['password'],
      isAdmin: doc['is_admin'],
      status: doc['status'],
    );
  }

  clearUser(){
    return AppUser(
      bio: "",
      district:"",
      division: "",
      imageUrl:"",
      phone_number: "",
      user_name: "",
      password:"",
      status: true,
      isAdmin: false,
    );
  }
  @override
  String toString() {
    return 'AppUser{user_name: $user_name, phone_number: $phone_number, imageUrl: $imageUrl, district: $district, division: $division, bio: $bio}';
  }
}