import "package:flutter/material.dart";
import "package:quiver/async.dart";

class PomodoroPage extends StatefulWidget{
  State<StatefulWidget> createState(){
    return _PomodoroPage();
  }
}

class _PomodoroPage extends State<PomodoroPage> {
 int _started = 0;

 int _count25 = 0;
 int _count5 = 0;

 int _start25 = 1500;
 int _current25 = 1500;
 int _start5 = 300;
 int _current5 = 300;

 void startTimer25(){
   CountdownTimer countdownTimer = new CountdownTimer(
     new Duration(seconds: _start25),
     new Duration(seconds: 1),
   );

   var sub = countdownTimer.listen(null);
   sub.onData((duration){
     setState(() { _current25 = _start25 - duration.elapsed.inSeconds; });
   });

   sub.onDone(() {
     print("Done");
     _start25 = 1500;
     _current25 = 1500;
     _count25++;
     if (_count5 < 3) startTimer5();
     if (_count25 == 4) _started = 0;
     sub.cancel();
   });
 }

 void startTimer5(){
   CountdownTimer countdownTimer = new CountdownTimer(
     new Duration(seconds: _start5),
     new Duration(seconds: 1),
   );

   var sub = countdownTimer.listen(null);
   sub.onData((duration){
     setState(() { _current5 = _start5 - duration.elapsed.inSeconds; });
   });

   sub.onDone(() {
     print("Done");
     _start5 = 300;
     _current5 = 300;
     _count5++;
     if(_count25 < 4) startTimer25();
     sub.cancel();
   });
 }

 String currentString25(){
   int _currentMinutes = _current25~/60;
   int _currentSeconds = _current25%60;
   if(_currentSeconds < 10) return "$_currentMinutes:0$_currentSeconds";
   return "$_currentMinutes:$_currentSeconds";
 }

 String currentString5(){
   int _currentMinutes = _current5~/60;
   int _currentSeconds = _current5%60;
   if(_currentSeconds < 10) return "$_currentMinutes:0$_currentSeconds";
   return "$_currentMinutes:$_currentSeconds";
 }

  Widget build(BuildContext context) {
   String _currentString25 = currentString25();
   String _currentString5 = currentString5();
    return Scaffold(
      appBar: AppBar(
        title: Text("Pomodoro Page"),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              if (_started == 0){
                _started = 1;
                startTimer25();
              };
            },
            child: Text("start"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(_currentString25),
                margin: EdgeInsets.all(50),
              ),
              Container(
                child: Text(_currentString5),
                margin: EdgeInsets.all(50),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
