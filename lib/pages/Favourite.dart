import 'package:agridictionaryoffline/CustomAppBar.dart';
import 'package:agridictionaryoffline/CustomWidgets.dart';
import 'package:agridictionaryoffline/Model/WordModel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../main.dart';
import 'WordDetails.dart';

class Favourite extends StatefulWidget {

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Box<WordModel> wordBox;


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
                    var favouriteWords;
                    try{
                      favouriteWords = wordBox.values.where((item) =>
                      item.isFavourite==1.toString()).toList();
                    }catch(e){
                      // print('error in listing fav: ${e.message}');
                    }

                    return ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (_, index){
                          final String key = favouriteWords[index].word;
                          WordModel wordModel;
                          try{
                            wordModel = wordBox.get(key);
                          }catch(e){
                            // print('error in getting word in favList: ${e.message}');
                          }
                          return Card(
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
                                        WordDetails(
                                          wordModel:wordModel,
                                          ))),
                                  title:  Text(key, style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Volkhov',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400
                                  ),),
                                ),
                          );
                        },
                        separatorBuilder: (_, index) => Divider(height: 6,),
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
