import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';
import 'package:voetbal_viewer/Screens/FieldScreen/FieldLocationWidget.dart';
import 'package:voetbal_viewer/Persons/Player.dart';
import 'package:voetbal_viewer/GlobalVariable.dart';
import 'package:voetbal_viewer/Services/database.dart';
import 'package:voetbal_viewer/Shared/loading.dart';

class BackgroundImage extends StatefulWidget {
  const BackgroundImage({Key key}) : super(key: key);
  @override
  BackgroundImageState createState() => BackgroundImageState();
}

class BackgroundImageState extends State<BackgroundImage> {
  bool fieldSetup = false;
  bool bottomSheetActive = false;
  bool loading = false;
  List<Player> playersInfield = new List();

  Timer _timer;
  int _start = 90;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(() {
        if (_start < 1) {
          timer.cancel();
        } else {
          _start = _start - 1;
        }
      }),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dbPlayers = Provider.of<List<Player>>(context) ?? [];
    playersInfield = dbPlayers.where((x) => x.inField).toList();
    return loading ? Loading() : Scaffold(
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
              top: MediaQuery.of(context).size.height * 0.035,
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
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: fieldSetup ? Text('4-4-2') : Text('4-3-3'),
                ),
                onPressed: () => {
                  Vibration.vibrate(duration: 50, amplitude: 125),
                  setState(() {
                    fieldSetup = !fieldSetup;
                  })
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.03,
              left: MediaQuery.of(context).size.width * 0.85,
            ),
            child: Container(
              height: 35,
              width: 64,
              decoration: BoxDecoration(
                color: Colors.transparent,
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
                color: Colors.red[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Icon(
                  Icons.loop,
                  color: Colors.white,
                ),
                onPressed: () => {
                  resetField(playersInfield),
                  Vibration.vibrate(duration: 50, amplitude: 125),
                },
              ),
            ),
          ),
          FieldLocationWidget(
            fieldSetupbool: fieldSetup,
          ),
        ],
      ),
    );
  }

  void resetField(List<Player> item) async {
    for (var i = 0; i < item.length; i++) {
      setState(() => loading = true);
      if (item[i].inField == true) {
        await DatabaseService(uid: item[i].id)
            .updatePlayerInField(!item[i].inField);
      }
    }
    setState(() => loading = false);
  }
}
