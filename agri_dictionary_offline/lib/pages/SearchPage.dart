import 'package:agridictionaryoffline/CustomAppBar.dart';
import 'package:agridictionaryoffline/CustomWidgets.dart';
import 'package:agridictionaryoffline/Model/WordModel.dart';
import 'package:agridictionaryoffline/pages/WordDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../main.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>  {
//  with AutomaticKeepAliveClientMixin<SearchPage>
  Box<WordModel> wordBox;
  String query='';
  TextEditingController _controller = TextEditingController();
  List<String> suggestions = [];
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    wordBox = Hive.box<WordModel>(wordBoxName);
    super.initState();
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: Colors.white30,
      border: Border.all(
        color: Colors.grey,
        width: 3.0
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(15.0) 
      ),
    );
  }

  IconButton prefixIcon(BuildContext context){
    return IconButton(
      color: Colors.black,
      icon: Icon(Icons.search, size: 30,),
      onPressed: (){
        setState(() {
          _controller.text = "";
          query = "";
        });
      },
    );

  }

  changeSuggestions(BuildContext context, String currentQuery){
    setState(() {
      query = _controller.text;
      List<String> keys = wordBox.keys.cast<String>().toList();
      suggestions = currentQuery.isEmpty ? null:
        keys.where((element) {
          if(element.toLowerCase().startsWith(currentQuery) || element.toUpperCase().startsWith(currentQuery)|| element.startsWith(currentQuery))
            return true;
          else
            return false;
        }).toList();
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldKey ,
      drawer: buildDrawer(context),
      appBar: appBar(context,'Search Word'),
      body: Container(
        color: Colors.black12,
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20,),
            Container(
              decoration: myBoxDecoration() ,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      onChanged: (text) => changeSuggestions(context, text),
                      autofocus: false,
//                      onTap:() => showSearch(context: context, delegate: DataSearch()),
                      controller: _controller,
                      decoration: InputDecoration(
                        prefixIcon: prefixIcon(context) ,
                        contentPadding: EdgeInsets.only(left: 10, top: 14,bottom: 15),
                        hintText: 'Search for a Word',
                        hintStyle: TextStyle(fontFamily: 'Kreon',fontSize: 19),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Divider(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => Hero(
                  tag: suggestions[index]+'z',
                  child: Card(
                    color: Colors.white,
                    child: ListTile(
                      onTap: (){
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 500),
                            pageBuilder: (_, __, ___) =>
                              WordDetails(
                                wordModel: wordBox.get(suggestions[index]),
                                heroTag: suggestions[index]+'z' ,
                              )));
//                    Navigator.push(context, MaterialPageRoute(builder:
//                      (context) => WordDetails(wordModel: wordBox.get(suggestions[index]),)));
                      },
                      leading: Icon(Icons.wb_sunny,color: Colors.lightGreen,),
                      title: RichText(
                        text: TextSpan(
                          text: suggestions[index].substring(0,query.length),
                          style: TextStyle(
                            fontFamily: 'Volkhov',
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: suggestions[index].substring(query.length),
                              style: TextStyle(
                                fontFamily: 'Fenix',
                                fontSize: 18,
                                color: Colors.grey,
                              )
                            )
                          ]
                        ),
                      ),
                    ),
                  ),
                ),
                itemCount: suggestions == null? 0 : suggestions.length,
              ),
            ),

          ],
        ),
      ),
    );
  }
}


