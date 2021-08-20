import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

class WeatherForecast extends StatefulWidget {
  @override
  _WeatherForecastState createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {

  String key =  dotenv.env['WEATHER_KEY'].toString();
  String _indicator = "Search by Location";
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
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.white70,
            child:
              ListTile(
              title: Text("Location: ${_data[index].areaName.toString()}, ${_data[index].country.toString()}"),

              subtitle: Text("T: ${_data[index].temperature.toString().split(" ")[0]}\u2103 || "
                  "Feels like: ${_data[index].tempFeelsLike.toString().split(" ")[0]}\u2103\n"
                  "Max: ${_data[index].tempMax.toString().split(" ")[0]}\u2103 || "
                  "Min: ${_data[index].tempMin.toString().split(" ")[0]}\u2103"),

              trailing:Text("Time: ${_data[index].date.toString().split(" ")[0]},${(DateFormat.jm().format(_data[index].date!))}\nWeather: ${_data[index].weatherDescription}",style: TextStyle(fontSize: 15),),

            )
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
                fontFamily: "Mina",
                fontWeight: FontWeight.bold
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

  IconButton IconMaker(BuildContext context,IconData icon,double sizee){
    return IconButton(
      color: Colors.black,
      icon: Icon(icon, size: sizee,),
      onPressed: (){
        setState(() {
          final FocusScopeNode currentScope = FocusScope.of(context);
          if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
          myController.clear();

        });
      },
    );
  }

  Widget _inputCityName() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
                margin: EdgeInsets.all(5),
                child: TextFormField(
                  autofocus: false,
                  controller: myController,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search,size: 30,color: Colors.teal.shade500,),
                      onPressed: () {
                        final FocusScopeNode currentScope = FocusScope.of(context);
                        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        }
                      },
                    ),
                    contentPadding: EdgeInsets.only(left: 10, top: 14,bottom: 15),
                    hintText: 'Enter City (Default:Current Location)',
                    hintStyle: TextStyle(fontFamily: 'Mina',fontSize: 14),
                    border: OutlineInputBorder(),
                    suffixIcon: IconMaker(context, Icons.clear,25),
                  ),
                )
          )
        )
      ],
    );
  }

  Widget _buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5),
          child:
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.teal.shade400)
            ),
            child: Text('Fetch Weather', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Mina",fontSize: 15),),
            onPressed: () {
              if(myController.text.isEmpty){
                queryWeather(false,"");
              }else{
                queryWeather(true,myController.text);
              }
            }
          ),
        ),
        Container(
          margin: EdgeInsets.all(5),
          child:
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.teal.shade400)
              ),
              child: Text('Fetch Forecast', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Mina", fontSize: 15),),
              onPressed: () {
                if(myController.text.isEmpty){
                  queryForecast(false,"");
                }else{
                  queryForecast(true,myController.text);
                }
              }
            ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    double heightMultiplier = height/712;
    double widthMultiplier= width/360;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor:  Colors.white,
          backwardsCompatibility: false,
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.teal.shade800,size: 18*widthMultiplier ,),
            onPressed: (){
              Navigator.pop(context);
            },),
          title: Text("Weather Forecast", style:TextStyle( fontFamily: "Mina", letterSpacing: 0, fontSize: 20*widthMultiplier,fontWeight: FontWeight.w800, color:Colors.teal.shade800,) ),
        ),
        body: Column(
          children: <Widget>[
            _inputCityName(),
            _buttons(),
            Text(
              'Result:',
              style: TextStyle(fontSize: 20, fontFamily: "Mina", fontWeight: FontWeight.bold),
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