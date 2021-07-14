import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Diseases extends StatefulWidget {
  @override
  _DiseasesState createState() => _DiseasesState();
}


class _DiseasesState extends State<Diseases> {
  updateData()async{
    final diseases1 ={
      'disease_name': "ধানের ব্লাস্ট রোগ",
      'images' : [],
      'symptoms' : [
        "ধানের ব্লাস্ট রোগে গাছের পাতা",
        "গিঁট শিস বীজ এমনকি শিকড়ও সংক্রামিত হতে পারে",
        "বচেয়ে সাধারণ লক্ষণ পাতায় ডিম্বাকৃতির দাগ, গিঁট কালো ও দুর্বল ,শিষে কালচে বাদামি দাগ দেখা যায়",

      ],
      'prevention_cure':[
        "ব্লাস্ট রোগের প্রাথমিক অবস্থায় জমিতে ১-২ ইঞ্চি পানি ধরে রাখতে পারলে ব্যাপকতা অনেকাংশে হ্রাস পায়",
        "ছত্রাকনাশক ত্রিয়াযোলস ও স্ট্রবিলুরিন্স পরিমানমতো ব্যাবহারে এই রোগ নিয়ন্ত্রণ করা যায়",
        "পটাশ জাতীয় সার উপরি প্রয়োগ, জৈব সার প্রয়োগ করা",

        "সুস্থ ও রোগমুক্ত ধানের জমি থেকে বীজ সংগ্রহ করতে হবে","জমিতে সুষম পরিমানে সার প্রয়োগ করতে হবে","রোগ প্রতিরোধী জাত বি আর ১৪, বি আর ১৫, বি আর ১৬, বি আর ২৪, ব্রি ধান ২৮ রোপন করা",

      ],
    };


    final diseases2 ={
      'disease_name': "ধানের টুংরো রোগ",
      'images' : [],
      'symptoms' : [
        "আক্রমনের প্রথমে পাতার রং হালকা সবুজ ,আস্তে আস্তে হলুদ হয়ে যায়",
       "গাছ টান দিলে সহজেই উঠে আসে, কুশি হয় না",
      ],

      'prevention_cure':[
        "রোগ প্রতিরোধী জাতগুলো চান্দিনা, দুলাভোগ,গাজী, বি আর ১৬, বি আর ২২, ব্রি ধান ৩৭,ব্রি ধান ৩৯, ব্রি ধান ৪১, ব্রি ধান ৪২ চাষ করা",
        "পাতা ফড়িং-এ রোগ ছড়ায় ,তাই আলোর ফাঁদ ব্যাবহার করে সবুজ পাতা ফড়িং মেরে ফেলতে হবে",
        "রোগাক্রান্ত গাছ তুলে মাটিতে পুঁতে ফেলতে হবে। ম্যালাথিয়ন ৫৭ ইসি স্প্রে করতে হবে",
      ],
    };
    final uploadData = {
      "plant" : "ধান",
      "diseases": [ diseases1,diseases2]

    };
    FirebaseFirestore.instance.collection('diseases').add(uploadData).then((docRef){
      print("${docRef.id} Upload Success");
    });
  }

  @override
  void initState() {
    // updateData();
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
