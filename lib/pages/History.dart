import 'package:agridictionaryoffline/Model/WordModel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../CustomAppBar.dart';
import '../CustomWidgets.dart';
import '../main.dart';
import 'WordDetails.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String box_name = 'history';
  Box<DateTime> _box;


  @override
  void initState(){
    _box = Hive.box<DateTime>(box_name);
    var _temp = _box.keys.toList();
    for(int i=0;i<_temp.length;i++){
      if(DateTime.now().difference(_box.get(_temp[i])).inDays>15)
        _box.delete(_temp[i]);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: appBar(context,'Search History'),
      body: Container(
        padding: EdgeInsets.only( left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                padding: const EdgeInsets.all(8.0),
                icon:Icon(Icons.history_rounded),
                textColor: Colors.white,
                color: Colors.teal,
                onPressed: () {
                  setState(() {
                    _box.deleteAll(_box.keys.toList());
                  });
                },
                label: Text("Clear history"),
              ),
              SizedBox(height: 20,),
              ValueListenableBuilder(
                valueListenable: _box.listenable(),
                builder: (context, Box<DateTime> words,_){
                  var _allHistory;
                  try{
                    _allHistory = _box.keys.toList();
                  }catch(e){
                    // print('error in listing fav: ${e.message}');
                  }

                  return ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, index){
                      final String key = _allHistory[index];
                      WordModel wordModel;
                      try{
                        wordModel = wordBox.get(key);
                      }catch(e){
                        // print('error in getting word in history: ${e.message}');
                      }
                      return Container(
                        height: 60,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Colors.blueGrey,
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
                        )
                      );
                    },
                    separatorBuilder: (_, index) => Divider(height: 8,),
                    itemCount: _allHistory.length
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
