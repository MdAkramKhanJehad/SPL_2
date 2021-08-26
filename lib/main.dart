import 'dart:io';
import 'package:agridictionaryoffline/Model/WordModel.dart';
import 'package:agridictionaryoffline/pages/Home.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';


const String wordBoxName = 'dictionary';
Box<WordModel> wordBox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(WordModelAdapter());
  await Hive.openBox<WordModel>(wordBoxName);
  await Hive.openBox<DateTime>('history');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  retrieveDataFromFile() async{
    String str = await rootBundle.loadString('assets/test.txt');
    List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(str);
    return rowsAsListOfValues;
  }

  insertInBox() async{
    try{
      List<List<dynamic>> allTheWords = await retrieveDataFromFile();
      for(int i=0;i<allTheWords.length;i++){
        final wordModel = WordModel(word: allTheWords[i][0], partsOfSpeech: allTheWords[i][3],
          definition: allTheWords[i][1], example: allTheWords[i][2], isFavourite: 0.toString());

        wordBox.put(wordModel.word, wordModel);
      }
    }catch(e){
       // print('in insertbox in main: ${e.message}');
    }
  }

  // deleteBox() async{
  //     await Hive.deleteBoxFromDisk(wordBoxName);
  // }

  @override
  void initState() {
    super.initState();
    try{
      wordBox = Hive.box<WordModel>(wordBoxName);
      if(wordBox.isEmpty){
        insertInBox();
      }
      // else{
      //   deleteBox();
      // }
    }catch(e){
      // print("in init state: ${e.message}");
    }

  }

  @override
  void dispose() {
    super.dispose();
    try{
      Hive.close();
    }catch(e){
      // print('in dispos:  ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.grey
      ),
      home: Home() ,
    );
  }
}