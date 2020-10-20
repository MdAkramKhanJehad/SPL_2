import 'package:agridictionaryoffline/CustomAppBar.dart';
import 'package:agridictionaryoffline/CustomWidgets.dart';
import 'package:agridictionaryoffline/Model/WordModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChannels, rootBundle;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:async';
import '../main.dart';
import 'WordDetails.dart';

class Favourite extends StatefulWidget {

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Box<WordModel> wordBox;

  Future<void> _showDialog1(BuildContext context, String title) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alerttttt'),
          content: Text(title),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: ()=>Navigator.pop(context, true),
            ),
          ],
        );
      },
    );
  }


  @override
  void initState() {
    wordBox = Hive.box<WordModel>(wordBoxName);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      drawer: buildDrawer(context),
      backgroundColor:Colors.black12,
      appBar: appBar(context,'Favourite Words'),
      body: Container(
          padding: EdgeInsets.only(top: 10, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ValueListenableBuilder(
                  valueListenable: wordBox.listenable(),
                  builder: (context, Box<WordModel> words,_){

                    var favouriteWords = wordBox.values.where((item) =>
                                item.isFavourite==1.toString()).toList();

                      return ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (_, index){
                            final String key = favouriteWords[index].word;
                            final wordModel = wordBox.get(key);
                            return Hero(
                              tag: key,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                  color: Colors.teal.shade500,
                                  child: ListTile(
                                    onTap: () => Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        transitionDuration: Duration(milliseconds: 500),
                                        pageBuilder: (_, __, ___) =>
                                          WordDetails(wordModel:wordModel,heroTag: key,))),
                                    title:  Text(key, style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Volkhov',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400
                                    ),),
                                  ),
                              ),
                            );
                          },
                          separatorBuilder: (_, index) => Divider(),
                          itemCount: favouriteWords.length
                        );
                  },
                )
              ],
            ),
          ),
      ),
    );
  }
}
