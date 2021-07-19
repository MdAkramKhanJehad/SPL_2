import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

class WeatherForecast extends StatefulWidget {
  @override
  _WeatherForecastState createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {

  String key = '7029c894ace1201df03d5de86958f262'; // dotenv.env['WEATHER_KEY']
  String _indicator = "Press the button";
  late WeatherFactory ws;
  List<Weather> _data = [];
  AppState _state = AppState.NOT_DOWNLOADED;
  double? lat, lon;
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ws = new WeatherFactory(key);
    getGeoLocation();
  }

  void queryForecast(bool isCity,String city) async {
    /// Removes keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _state = AppState.DOWNLOADING;
    });

    late List<Weather> forecasts;

    try{
      if (isCity){
        forecasts = (await ws.fiveDayForecastByCityName(city)) ;
      }
      else{
        forecasts = (await ws.fiveDayForecastByLocation(lat!, lon!)).cast<Weather>() ;
      }
      setState(() {
        _data = forecasts;
        _state = AppState.FINISHED_DOWNLOADING;
      });
    } catch(e){
      print("Exception: ${e.toString()}");
      setState(() {
        _indicator = "Invalid Location";
        _state = AppState.NOT_DOWNLOADED;
      });
    }
  }

  void queryWeather(bool isCity,String city) async {
    // Removes keyboard
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      _state = AppState.DOWNLOADING;
    });

    late Weather weather;
    try {
      if (isCity) {
        weather = (await ws.currentWeatherByCityName(city));
      }
      else {
        weather = (await ws.currentWeatherByLocation(lat!, lon!));
      }

      setState(() {
        _data = [weather];
        _state = AppState.FINISHED_DOWNLOADING;
      });
    }catch(e){
      print("Exception: ${e.toString()}");
      setState(() {
        _indicator = "Invalid Location";
        _state = AppState.NOT_DOWNLOADED;
      });
    }
  }

  Widget contentFinishedDownload() {
    return Center(
      child:
      ListView.separated(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${_data[index].areaName.toString()}, ${_data[index].country.toString()} || "
                "Humidity: ${_data[index].humidity.toString()}",style: TextStyle(fontSize: 14),),
            subtitle: Text("T:${_data[index].temperature.toString().split(" ")[0]}\u2103 || "
                "Feels like:${_data[index].tempFeelsLike.toString().split(" ")[0]}\u2103\n"
                "Max: ${_data[index].tempMax.toString().split(" ")[0]}\u2103 || "
                "Min: ${_data[index].tempMin.toString().split(" ")[0]}\u2103"),
            leading:
            Text("${_data[index].date.toString().split(" ")[0]},\n"
                "${(_data[index].date.toString().split(" ")[1]).split(".000")[0]}",style: TextStyle(fontSize: 13),)
            ,
            trailing:Text("${_data[index].weatherMain},\n${_data[index].weatherDescription}",style: TextStyle(fontSize: 14),),

          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }

  Widget contentDownloading() {
    return Container(
      margin: EdgeInsets.all(25),
      child: SingleChildScrollView(
        child: Column(children: [
          Text(
            'Fetching Weather...',
            style: TextStyle(fontSize: 20),
          ),
          Container(
              margin: EdgeInsets.only(top: 50),
              child: Center(child: CircularProgressIndicator(strokeWidth: 5)))
        ]),
      ),
    );
  }

  Widget contentNotDownloaded(String indicator) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              indicator,
              style: TextStyle(
                fontSize: 23,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resultView() => _state == AppState.FINISHED_DOWNLOADING
      ? contentFinishedDownload()
      : _state == AppState.DOWNLOADING
      ? contentDownloading()
      : contentNotDownloaded(_indicator);


  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  void getGeoLocation() async {
    Position position = await locateUser();
    lat = position.latitude;
    lon = position.longitude;

    print(position.longitude.toString());
    print(position.latitude.toString());
  }


  Widget _inputCityName() {
    return Row(
      children: <Widget>[

        Expanded(
            child: Container(
                margin: EdgeInsets.all(5),
                child: TextField(
                  controller: myController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter City (Default:Current Location)'),
                )))
      ],
    );
  }

  Widget _buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5),
          child: TextButton(
            child: Text(
              'Fetch weather',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: (){
              if(myController.text.isEmpty){
                queryWeather(false,"");
              }else{
                queryWeather(true,myController.text);
              }
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
          ),
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: TextButton(
            child: Text(
              'Fetch forecast',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: (){
              if(myController.text.isEmpty){
                queryForecast(false,"");
              }else{
                queryForecast(true,myController.text);
              }
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(child: Text('Weather',style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold),)),
        ),
        body: Column(
          children: <Widget>[
            _inputCityName(),
            _buttons(),
            Text(
              'Output:',
              style: TextStyle(fontSize: 20),
            ),
            Divider(
              height: 20.0,
              thickness: 2.0,
            ),
            Expanded(child: _resultView())
          ],
        ),
      ),
    );
  }
}