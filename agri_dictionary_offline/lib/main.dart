import 'dart:io';
import 'package:agridictionaryoffline/Model/WordModel.dart';
import 'package:agridictionaryoffline/pages/Home.dart';
import 'package:agridictionaryoffline/pages/SideBarLayout.dart';
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
    print('*****in main retrieve from file******');
    return rowsAsListOfValues;
  }

  insertInBox() async{
    List<List<dynamic>> allTheWords = await retrieveDataFromFile();
    print("*****inserting::length:${allTheWords.length} ******");
    for(int i=0;i<allTheWords.length;i++){
      final wordModel = WordModel(word: allTheWords[i][0],
          partsOfSpeech: allTheWords[i][3],
            definition: allTheWords[i][1], example: allTheWords[i][2], isFavourite: 0.toString());
      if(i==0)
        print('no ${i+1}:${wordModel.partsOfSpeech}zz');
      // print('${allTheWords[i][0]} :::::  ${i+1}');
      wordBox.put(wordModel.word, wordModel);
    }
  }

  deleteBox() async{
    await Hive.deleteBoxFromDisk(wordBoxName);
  }


  @override
  void initState() {
    super.initState();
    wordBox = Hive.box<WordModel>(wordBoxName);
    if(wordBox.isEmpty){
      insertInBox();
    }
//     else{
//      // deleteBox();
//      print('*******BOX IS NOT EMPTY::Size:${wordBox.length} **');
// //      makeCustomDialog();
//     }
  }

@override
  void dispose() {
    super.dispose();
    Hive.close();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
//        scaffoldBackgroundColor:Colors.blue,
        primaryColor: Colors.grey
      ),
      home:
//      SideBarLayout(),
      Home() ,
    );
  }
}


