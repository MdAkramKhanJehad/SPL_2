import 'package:flutter/cupertino.dart';

class TimerInfo extends ChangeNotifier{

  int time;
  bool _isTimeUp=false;

  String showTime="";
  TimerInfo({required this.time});
  getShowTime() {
    return showTime;
  }

  int getTime(){
    return time;
  }
  bool get isTimeUp => _isTimeUp;

  void updateTimer(){
    time--;
    if(time==0){
      _isTimeUp=true;
    }
    notifyListeners();
    _setShowTime(time);
  }

  _setShowTime(int time){
    int seconds = time%60;
    int bigSeconds=time~/60;
    int minutes = bigSeconds%60;
    int bigMinutes=bigSeconds~/60;
    int hours = bigMinutes%60;

    if(minutes ==0 && hours==0){
      showTime = "${seconds.toString().padLeft(2, '0')}sec";
    }
    else if(hours==0){
      showTime = "${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}";
    }
    else {
      showTime =
      "${hours.toString ( ).padLeft ( 2, '0' )} : ${minutes.toString ( ).padLeft (
          2, '0' )} : ${seconds.toString ( ).padLeft ( 2, '0' )}";
    }
    //print(showTime);


  }

}