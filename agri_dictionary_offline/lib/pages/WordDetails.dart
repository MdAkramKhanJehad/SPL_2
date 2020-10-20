import 'package:agridictionaryoffline/CustomAppBar.dart';
import 'package:agridictionaryoffline/Model/WordModel.dart';
import 'package:agridictionaryoffline/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:agridictionaryoffline/animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hive/hive.dart';

class WordDetails extends StatefulWidget {
  WordModel wordModel;
  String heroTag;
  WordDetails({this.wordModel,this.heroTag});
  @override
  _WordDetailsState createState() => _WordDetailsState();
}

class _WordDetailsState extends State<WordDetails> {
  final FlutterTts flutterTts = FlutterTts();


  _speak() async{
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.8);
    await flutterTts.setVolume(1);
    await flutterTts.setPitch(0.8);
    await flutterTts.speak(widget.wordModel.word);
  }

  makeWordFavouriteOrNot() async {
    if (widget.wordModel.isFavourite == 0.toString()){
      widget.wordModel.isFavourite = 1.toString();
    } else{
      widget.wordModel.isFavourite = 0.toString();
    }
    final wordBox = Hive.box<WordModel>(wordBoxName);
    setState(() {
      wordBox.put(widget.wordModel.word, widget.wordModel);
    });
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

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.heroTag,
      child: Scaffold(
        appBar: header(context, 'Agri-Dictionary'),
        body: Container(
//        padding:
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
              FadeAnimation(1,ttsAndFavourite()),
                Container(
                  padding:EdgeInsets.only(left:0, top: 0, bottom: 20, right: 0) ,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FadeAnimation(1.1,headingMaker('Word')),
                      SizedBox(height: 4,),
                      FadeAnimation(1.15,detailsMaker(widget.wordModel.word,'Kreon', 33, FontWeight.w400)),
                      SizedBox(height: 38,),
                      FadeAnimation(1.2,headingMaker("Definition")),
                      SizedBox(height: 4,),
                      FadeAnimation(1.25,detailsMaker(widget.wordModel.definition, 'Fenix', 22, FontWeight.w300)),
                      SizedBox(height: 38,),
                      FadeAnimation(1.3,headingMaker('Examples')),
                      SizedBox(height: 4,),
                      FadeAnimation(1.35,detailsMaker(widget.wordModel.example, 'Fenix', 22, FontWeight.w300)),
                      SizedBox(height: 38,),
                      FadeAnimation(1.4,headingMaker('Parts of Speech')),
                      SizedBox(height: 4,),
                      FadeAnimation(1.45,detailsMaker(widget.wordModel.partsOfSpeech, 'Fenix', 23, FontWeight.w300)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
