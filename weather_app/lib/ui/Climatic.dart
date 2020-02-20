import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../util/utils.dart' as util;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';




class Climatic extends StatefulWidget {
  @override
  _ClimaticState createState() => _ClimaticState();
}

class _ClimaticState extends State<Climatic> {

  String _temperature='';
  String _location='';

  void _getWeather() async{
      WeatherStation weatherStation = new WeatherStation("7029c894ace1201df03d5de86958f262");
      Weather weather = await weatherStation.currentWeather();
      double celsius = weather.temperature.celsius;
      double lat =  weather.latitude;
      double long = weather.longitude;
      setState(() {
        _temperature = celsius.toString();
        _location = weather.areaName;
      });

  }


  Future<Position> locateUser() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  void getGeoLocation() async {
      //Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Position position = await locateUser();
    print(position.longitude.toString());
  }


    String _cityEntered;
    void show(String city) async{
      Map data = await getWeather(util.appID, city);
      print(data);
    }

    Future _goToNextScreen(BuildContext context) async{
      Map results =  await Navigator.of(context).push(
         MaterialPageRoute(builder: (BuildContext context){
           return ChangeCity();
         })
      );
      if(results!=null  && results.containsKey('enter')){
          _cityEntered = results['enter'];
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime,
      appBar: AppBar(
        title: Text('Climate'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: (){
              _goToNextScreen(context);
//              setState(() {
//                show('dhaka');
//              });
            },
            icon: Icon(Icons.menu),
            label: Text(''),
          ),

        ],
        elevation: 0.0,
      ),

        body: Stack(
        children: <Widget>[
          Center(
              child: Image.asset(
                'images/city.jpg',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity ,
              ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.all(5),

            child: LimitedBox(
              maxHeight: 150,
              maxWidth: 150,
              child: Column(
                children: <Widget>[
                  FlatButton.icon(
                    onPressed: (){
                      _getWeather();
                    },
                    icon: Icon(Icons.wb_sunny),
                    label: Text('Click for current weather'),
                  ),
                  Text(
                      '$_temperature',
                    style: temperatureStyle(),

                  ),
                ],

              ),


            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.all(20),
            child: Text(
              '${_cityEntered == null ? util.defaultCity: _cityEntered}',
              style:  TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Container(
            alignment: Alignment.center,
            child: Image.asset('images/cloudicon.png',),
          ),

          Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(child: updateTempWidget(_cityEntered)),
          ),
        ],
      )
    );
  }
//7029c894ace1201df03d5de86958f262
  //data/2.5/weather?lat=23.81&lon=90.41&appid=
  Future<Map> getWeather(String appid, String city) async{
    String apiUrl = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=''${util.appID}&units=metric';
    //String apiUrl =   'https://api.openweathermap.org/data/2.5/weather?lat=27.33&lon=88.62&appid=7029c894ace1201df03d5de86958f262&units=metric';

  http.Response res;

    try{
      res = await http.get(apiUrl);
    }catch(e){
      print("Wrong location");
    }
    return jsonDecode(res.body.toString());

  }



  Widget updateTempWidget(String city){
      String _notFound = 'Not Found';
      return FutureBuilder(
          future: getWeather(util.appID, city==null ? util.defaultCity: city),
          builder: (BuildContext context, AsyncSnapshot<Map> snapshot){
            if(snapshot.hasData){
              Map content = snapshot.data;

              return Container(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Column(
                        children: <Widget>[
                          Center(
                            child: Text(

                    '${content['main']['temp'].toString() == null ? _notFound: content['main']['temp'].toString()}',
                              //content['main']['temp'].toString(),
                              style: tempStyle(),

                            ),
                          ),
                        ],
                      )
                    )
                  ],
                ),
              );
            }
            else
              return CircularProgressIndicator();
          });
  }

}

class ChangeCity extends StatefulWidget {
  @override
  _ChangeCityState createState() => _ChangeCityState();
}

class _ChangeCityState extends State<ChangeCity> {
  var _cityFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Your City'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset(
              'images/snow.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity ,
            ),
          ),

          ListView(
            children: <Widget>[
              ListTile(
                title: TextField(
                  enableSuggestions: true,
                  decoration: InputDecoration(
                    hintText: "Enter city",
                    hintStyle: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 20,
                    )
                  ),
                  controller: _cityFieldController,
                  keyboardType: TextInputType.text,
                ),

              ),
              ListTile(
                title: FlatButton(
                  onPressed: (){
                    Navigator.pop(context,{
                      'enter' : _cityFieldController.text
                    });
                  },
                  textColor: Colors.grey,
                  color: Colors.yellow,
                  child: Text(
                      'Get weather',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23
                    ),

                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

TextStyle temperatureStyle(){
  return TextStyle(
    //height: 15,
    color: Colors.black,
    fontSize: 25,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );
}

TextStyle tempStyle(){
  return TextStyle(
    height: 15,
    color: Colors.white,
    fontSize: 25,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );
}