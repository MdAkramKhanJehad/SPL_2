
import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser{
  final  String user_name,phone_number,imageUrl, district, division,bio,password;
  AppUser({required this.bio,required this.district,required this.division,required this.password,
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
    );
  }

  @override
  String toString() {
    return 'AppUser{user_name: $user_name, phone_number: $phone_number, imageUrl: $imageUrl, district: $district, division: $division, bio: $bio}';
  }
}