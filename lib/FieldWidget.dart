import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vibration/vibration.dart';
import 'package:voetbal_viewer/BottomSheet.dart';
import 'package:voetbal_viewer/DragTargetWidget.dart';
import 'package:voetbal_viewer/bottom_modal.dart';
import 'package:voetbal_viewer/football_icons.dart';
import 'package:voetbal_viewer/New_player.dart';
import 'package:voetbal_viewer/Player.dart';
import 'package:voetbal_viewer/GlobalVariable.dart';
import 'package:voetbal_viewer/DraggableWidget.dart';

class BackgroundImage extends StatefulWidget {
  const BackgroundImage({Key key}) : super(key: key);
  @override
  BackgroundImageState createState() => BackgroundImageState();
}

class BackgroundImageState extends State<BackgroundImage> {
  bool fieldSetup = false;
  bool bottomSheetActive = false;
  List<Player> playersInfield = new List();

  Timer _timer;
  int _start = 90;

  void startTimer(){
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, 
    (Timer timer) => setState((){
      if(_start < 1){
        timer.cancel();
      }else{
        _start = _start - 1;
      }
    }),);
  }

  @override
  void initState() {
    super.initState();
    playersInfield = players.where((x) => x.inField).toList();
  }

  @override
  void dispose(){
    saveTimer();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: new Image.asset(
              'fonts/field.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height - 615,
            ),
            child: Container(
              height: 35,
              width: 64,
              decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87,
                    offset: Offset(1.0, 4.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: FlatButton(
                textColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: fieldSetup ? Text('4-4-2') : Text('4-3-3'),
                onPressed: () => {
                  Vibration.vibrate(duration: 50, amplitude: 125),
                  setState(() {
                    fieldSetup = !fieldSetup;
                  })
                },
              ),
            ),
          ),
          AnimatedContainer(
            child: Container(
              child: Text(''),
              color: Colors.white,)
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height - 618,
              left: MediaQuery.of(context).size.width - 80,
            ),
            child: FlatButton(
              color: Colors.red[900],
              shape: CircleBorder(),
              child: Icon(
                Icons.loop,
                color: Colors.white,
              ),
              onPressed: () => resetField(playersInfield),
            ),
          ),
          DragTargetWidget(
            fieldSetupbool: fieldSetup,
          ),
        ],
      ),
    );
  }

  void resetField(List<Player> item) {
    for (var i = 0; i < item.length; i++) {
      if (item[i].inField == true) {
        setState(() {
          item[i].fieldIndex = null;
          item[i].inField = false;
        });
      }
    }
    saveData();
  }

  void saveData() {
    List<String> stringList =
        players.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('players', stringList);
  }

  void saveTimer(){

  }
}
