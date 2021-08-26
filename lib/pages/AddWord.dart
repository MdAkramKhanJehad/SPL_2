import 'package:agridictionaryoffline/CustomAppBar.dart';
import 'package:agridictionaryoffline/Model/WordModel.dart';
import 'package:agridictionaryoffline/main.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


class AddWord extends StatefulWidget {
  @override
  _AddWordState createState() => _AddWordState();
}

class _AddWordState extends State<AddWord> {
  String _word;
  String _definition;
  String _partsOfSpeech = '';
  String _example = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTheField(String label, bool isWord){
    return TextFormField(
      style: TextStyle(
        fontSize: 17,
        color: Colors.black,
        fontFamily: 'Volkhov'
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black)
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black)
        ),
        hintText: 'Enter $label',
        labelText: label,
      ),
      validator: (String value){
        if(value.isEmpty){
          return '$label is Required';
        }
        return null;
      },
      onSaved: (String value){
        if(isWord){
          _word = value;
        } else {
          _definition = value;
        }
      },
    );
  }

  Widget _buildTheFieldWithoutValidation(String label, bool isExample){
    return TextFormField(
      style: TextStyle(
        fontSize: 17,
        color: Colors.black,
        fontFamily: 'Volkhov'
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black)
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black)
        ),
        labelText: label,
      ),
      onSaved: (String value){
        if(isExample){
          _example = value;
        } else {
          _partsOfSpeech = value;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Add Word'),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  'Add as many words as you can. It\'s totally free!',
                  style: TextStyle(
                    fontSize: 21,
                    fontFamily: 'Volkhov',
                    color: Colors.teal
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25,),
                _buildTheField('Word',true),
                SizedBox(height: 15,),
                _buildTheField('Definition',false),
                SizedBox(height: 15,),
                _buildTheFieldWithoutValidation('Example(Optional)', true),
                SizedBox(height: 15,),
                _buildTheFieldWithoutValidation('Parts Of Speech(Optional)', false),
                SizedBox(height: 25,),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 39,
                  onPressed: (){
                    if(!_formKey.currentState.validate()){
                      return;
                    }
                    _formKey.currentState.save();
                    final wordModel = WordModel(word: _word,definition: _definition,example: _example,partsOfSpeech: _partsOfSpeech);

                    try{
                      wordBox.put(_word, wordModel);
                    }catch(e){
                      // print('error in addword:${e.message}');
                    }
                    Navigator.of(context).pop();
                  } ,
                  color: Colors.teal.shade700,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Text("Add Word", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Colors.white,
                    fontFamily: 'Fenix'
                  ),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
