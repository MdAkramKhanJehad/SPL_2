import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Diseases extends StatefulWidget {
  @override
  _DiseasesState createState() => _DiseasesState();
}


class _DiseasesState extends State<Diseases> {
  updateData()async{
    final diseases1 ={
      'disease_name': "ঢলে পড়া বা গোড়া ও মূল পঁচা",
      'images' : [],
      'symptoms' : [
        "এ রোগটি সাধারণত নার্সারিতে হয়ে থাকে,বীজ বপনের পর বীজই পচে যেতে পারে অথবা চারা মাটি থেকে উঠার আগেই মারা যেতে পারে",
        "বীজ অংকুরোদগমের পরেই কচি চারার গোড়ায় পানিভেজা দাগ পড়ে ও পরে কুঁচকে গিয়ে চারা ঢলে পড়ে ও মারা যায়",
        "মারাত্মক আকারে আক্রান্ত হলে নার্সারির সব গাছ ২-৪ দিনের মধ্যে মরে যেতে পারে",
      ],
      'prevention_cure':[
        "রোগ প্রতিরোধী সহনশীল মরিচের জাত চাষ।",
        "মাটির আঠালো ভাব দূর করা,অতিরিক্ত সেচ অপসারণ করা।",
        "বীজতলা গম্বুজ আকৃতির করা এবং প্লাস্টিক মালচিং করা।",
        "চারা রোপণের পর চারা গোড়ায় গর্ত না রাখা।",
        "সুনিষ্কাশিত উঁচু বীজতলা তৈরি করতে হবে।",
        "বীজ বপনের ২ সপ্তাহ আগে ফরমালডিহাইড দ্বারা বীজতলা শোধন করতে হবে।",
        "ট্রাইগোডারমা দ্বারা বীজ শোধন করে বপন করতে হবে।",
        "প্রোভেক্স-২০০ অথবা রিডোমিল গোল্ড (প্রতি কেজি বীজে ২.৫ গ্রাম) দ্বারা শোধন করে বীজ বপন করতে হবে।",
        "বীজ ৫২০ঈ তাপমাত্রায় গরম পানিতে ৩০ মিনিট রেখে শোধন করে নিয়ে বপন করতে হবে।",
        "কিউপ্রাভিট অথবা ব্যভিস্টিন প্রতি লিটার পানিতে ২ গ্রাম হারে মিশিয়ে আক্রান্ত গাছের গোড়ার মাটিতে প্রয়োগ করতে হবে।",

      ],
    };


    final diseases2 ={
      'disease_name': "ক্যাংকার রোগ",
      'images' : [],
      'symptoms' : [
        "এ রোগে আক্রান্ত পাতায় নিচের দিকে প্রথমে ছোট ছোট পানিভেজা দাগ দেখা যায় আস্তে আস্তে দাগগুলো বড় হয়",
        "কান্ডে ক্যাংকারের ক্ষত দেখা যায়",
      ],

      'prevention_cure':[
        "সুস্থ গাছ থেকে বীজ সংগ্রহ করা।",
        "সুষম সার ব্যবহার করা।",
        "প্রোভেক্স বা হোমাই বা বেনলেট ১% দ্বারা বীজ শোধন করা ।",
        "রোগ দেখা দিলে প্রাধমিক পর্যায়ে আক্রান্ত গাছ অপসারণ করা ।",
        "পানি নিষ্কাশনের ভাল ব্যবস্থা করা।",
        "নাইট্রেজেন সার ভাগ ভাগ করে কয়েকবারে প্রয়োগ করা।",

      ],
    };


    final uploadData = {
      "plant" : "মরিচ",
      "diseases": [ diseases1,diseases2]
    };
    FirebaseFirestore.instance.collection('diseases').add(uploadData).then((docRef){
      print("${docRef.id} Upload Success");
    });
  }

  @override
  void initState() {
    //  updateData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Center(child: TextButton(child: Text("Upload"),onPressed: updateData,)),
        ),
      ),
    );
  }
}
