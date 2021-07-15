import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
// String key = '7029c894ace1201df03d5de86958f262';


enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

class WeatherForecast extends StatefulWidget {
  @override
  _WeatherForecastState createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  String key = '7029c894ace1201df03d5de86958f262';
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
    if (isCity){
      forecasts = (await ws.fiveDayForecastByCityName(city)) ;
    }
    else{
      forecasts = (await ws.fiveDayForecastByLocation(lat!, lon!)).cast<Weather>() ;
    }
    // List<Weather> forecasts = (await ws.fiveDayForecastByLocation(lat!, lon!)).cast<Weather>();
    setState(() {
      _data = forecasts;
      _state = AppState.FINISHED_DOWNLOADING;
    });
  }

  void queryWeather(bool isCity,String city) async {
    // Removes keyboard
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      _state = AppState.DOWNLOADING;
    });

    late Weather weather;
    if (isCity){
      weather = (await ws.currentWeatherByCityName(city)) ;
    }
    else{
      weather = (await ws.currentWeatherByLocation(lat!, lon!)) ;
    }

    print(weather.cloudiness);
    print(weather.date.toString().split(' ')[0]);
    setState(() {
      _data = [weather];
      _state = AppState.FINISHED_DOWNLOADING;
    });
  }

  Widget contentFinishedDownload() {
    return Center(
      child: ListView.separated(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_data[index].toString()),
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
      child: Column(children: [
        Text(
          'Fetching Weather...',
          style: TextStyle(fontSize: 20),
        ),
        Container(
          margin: EdgeInsets.only(top: 50),
          child: Center(child: CircularProgressIndicator(strokeWidth: 10)))
      ]),
    );
  }

  Widget contentNotDownloaded() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Press the button to download the Weather forecast',
          ),
        ],
      ),
    );
  }

  Widget _resultView() => _state == AppState.FINISHED_DOWNLOADING
    ? contentFinishedDownload()
    : _state == AppState.DOWNLOADING
    ? contentDownloading()
    : contentNotDownloaded();

  
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
                hintText: 'Enter city name'),
              // onChanged: _saveLon,
              // onSubmitted: _saveLon
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
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Weather'),
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