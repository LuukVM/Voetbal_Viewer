import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';
import 'package:voetbal_viewer/Persons/field.dart';
import 'package:voetbal_viewer/Screens/FieldScreen/FieldLocationWidget.dart';
import 'package:voetbal_viewer/Persons/Player.dart';
import 'package:voetbal_viewer/Services/database.dart';
import 'package:voetbal_viewer/Shared/loading.dart';
import 'package:voetbal_viewer/football_icons.dart';

class BackgroundImage extends StatefulWidget {
  const BackgroundImage({Key key}) : super(key: key);
  @override
  BackgroundImageState createState() => BackgroundImageState();
}

class BackgroundImageState extends State<BackgroundImage> {
  bool fieldSetup = false;
  bool bottomSheetActive = false;
  bool loading = false;
  int retract;
  List<Player> playersInfield = new List();
  List<Player> playersAttack = new List();
  List<Player> playersDefence = new List();
  List<Player> playersMidfield = new List();
  List<Player> playersKeeper = new List();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
    playersAttack = dbPlayers
        .where((x) => x.present && !x.inField && x.position == 'Aanvaller')
        .toList();
    playersMidfield = dbPlayers
        .where((x) => x.present && !x.inField && x.position == 'Middenvelder')
        .toList();
    playersDefence = dbPlayers
        .where((x) => x.present && !x.inField && x.position == 'Verdediger')
        .toList();
    playersKeeper = dbPlayers
        .where((x) => x.present && !x.inField && x.position == 'Keeper')
        .toList();

    return StreamBuilder<Field>(
        stream: DatabaseService(uid: '1').field,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            fieldSetup = snapshot.data.fieldSetup;
          }
          return loading
              ? Loading()
              : Scaffold(
                  key: _scaffoldKey,
                  drawer: Drawer(
                    child: ListView(
                      children: <Widget>[
                        Container(
                          height: 80,
                          child: DrawerHeader(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey, width: 3.0),
                              ),
                              color: Color(0xFF0062A5),
                            ),
                            child: Text(
                                'Wissels: ' +
                                    (playersDefence.length +
                                            playersAttack.length +
                                            playersMidfield.length +
                                            playersKeeper.length)
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 30.0, color: Colors.white)),
                          ),
                        ),
                        ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            'Aanvallers: ' + playersAttack.length.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                          children: <Widget>[
                            Column(
                              children: buildItem(playersAttack),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            'Middenvelders: ' +
                                playersMidfield.length.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                          children: <Widget>[
                            Column(
                              children: buildItem(playersMidfield),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            'Verdedigers: ' + playersDefence.length.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                          children: <Widget>[
                            Column(
                              children: buildItem(playersDefence),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            'Keepers: ' + playersKeeper.length.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                          children: <Widget>[
                            Column(
                              children: buildItem(playersKeeper),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                              setFieldSetup(!fieldSetup),
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.035,
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
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.85,
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
                            color: Colors.grey[350],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Icon(
                              Football.exchange,
                              color: Colors.black,
                            ),
                            onPressed: () => {
                              _scaffoldKey.currentState.openDrawer(),
                              Vibration.vibrate(duration: 50, amplitude: 125),
                            },
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //     top: MediaQuery.of(context).size.height * 0.037,
                      //     left: (MediaQuery.of(context).size.width / 2) - 50,
                      //   ),
                      //   child: Container(
                      //     width: 100.0,
                      //     height: 35.0,
                      //     decoration: BoxDecoration(
                      //       color: Colors.grey[350],
                      //       borderRadius: BorderRadius.circular(10.0),
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Colors.black87,
                      //           offset: Offset(1.0, 4.0),
                      //           blurRadius: 6.0,
                      //         ),
                      //       ],
                      //     ),
                      //     alignment: Alignment.center,
                      //     child: Text(
                      //       "00:00",
                      //       style: TextStyle(
                      //           fontSize: 30.0, fontWeight: FontWeight.w700),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                );
        });
  }

  buildItem(List<Player> item) {
    List<Widget> columnContent = [];

    item.sort((a, b) => a.secondaryPosition.compareTo(b.secondaryPosition));

    for (Player player in item) {
      columnContent.add(
        ListTile(
          title: Text(player.title),
          subtitle: Text('Is ook: ' + player.secondaryPosition),
        ),
      );
    }
    return columnContent;
  }

  void setFieldSetup(bool setup) async {
    await DatabaseService(uid: '1').updateFieldSetup(setup);
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
