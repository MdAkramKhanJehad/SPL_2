import 'package:agridictionaryoffline/CustomAppBar.dart';
import 'package:agridictionaryoffline/Model/WordModel.dart';
import 'package:agridictionaryoffline/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hive/hive.dart';

class WordDetails extends StatefulWidget {
  WordModel wordModel;
  WordDetails({this.wordModel});
  @override
  _WordDetailsState createState() => _WordDetailsState();
}

class _WordDetailsState extends State<WordDetails> {
  final FlutterTts flutterTts = FlutterTts();


  _speak() async{
    try{
      await flutterTts.setLanguage('en-US');
      await flutterTts.setSpeechRate(0.8);
      await flutterTts.setVolume(1);
      await flutterTts.setPitch(0.8);
      await flutterTts.speak(widget.wordModel.word);
    }catch(e){
      // print("error in speak in word details: ${e.message}");
    }
  }

  makeWordFavouriteOrNot() async {
    try{
      if (widget.wordModel.isFavourite == 0.toString()){
        widget.wordModel.isFavourite = 1.toString();
      } else{
        widget.wordModel.isFavourite = 0.toString();
      }
      final wordBox = Hive.box<WordModel>(wordBoxName);
      setState(() {
        wordBox.put(widget.wordModel.word, widget.wordModel);
      });
    }catch(e){
      // print("error in speak in word details: ${e.message}");
    }
  }


  Widget headingMaker(String keyWord){
    return Center(
      child: Container(
        padding: EdgeInsets.only(left: 20),
        color: Color(0xFF006666),
        width: MediaQuery.of(context).size.width,
        height: 33,
        child: Text(
          keyWord,
          style: TextStyle(
            fontFamily: 'Kreon',
            fontWeight: FontWeight.w600,
            fontSize: 25,
            color: Colors.white
          ),
        ),
      ),
    );
  }

  Widget detailsMaker(String keyWord,String family,double sizee, FontWeight weight){
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Text(
        keyWord,
        style: TextStyle(
          fontFamily: family,
          fontSize: sizee,
          fontWeight: weight
        ),
      ),
    );
  }

  Widget ttsAndFavourite(){
    return Container(
      height: 48,
      color: Colors.grey.shade400,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                child:
                Image.asset(
                  'assets/speak.png',
                  width:32,
                  height: 32,
                  fit:BoxFit.fill,
                ),
                onTap: () {
                  _speak();
                  } ,
              ),

              SizedBox(width: 11,),
              IconButton(
                icon: widget.wordModel.isFavourite == 1.toString() ? Icon(Icons.bookmark, size: 30,color: Colors.yellow,):
                Icon(Icons.bookmark_border, size: 31,color: Colors.yellow,),
                onPressed: () => makeWordFavouriteOrNot(),
              ),
              SizedBox(width: 22,)
            ],
          )
        ],
      ),
    );
  }

  insertInHistory() async{
    final wordBox = await Hive.box<DateTime>('history');
    if (wordBox.isEmpty){
      print('inserted in new box');
    }
    wordBox.put(widget.wordModel.word, DateTime.now());
  }

  @override
  void initState() {
    insertInHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header(context, 'Agri-Dictionary'),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
              ttsAndFavourite(),
                Container(
                  padding:EdgeInsets.only(left:0, top: 0, bottom: 20, right: 0) ,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      headingMaker('Word'),
                      SizedBox(height: 4,),
                      detailsMaker(widget.wordModel.word,'Kreon', 33, FontWeight.w400),
                      SizedBox(height: 38,),
                      headingMaker("Definition"),
                      SizedBox(height: 4,),
                      detailsMaker(widget.wordModel.definition, 'Fenix', 22, FontWeight.w300),
                      SizedBox(height: 38,),
                      headingMaker('Examples'),
                      SizedBox(height: 4,),
                      detailsMaker(widget.wordModel.example, 'Fenix', 22, FontWeight.w300),
                      SizedBox(height: 38,),
                      headingMaker('Parts of Speech'),
                      SizedBox(height: 4,),
                      detailsMaker(widget.wordModel.partsOfSpeech, 'Fenix', 23, FontWeight.w300),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}
