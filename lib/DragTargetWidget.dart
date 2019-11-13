import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:voetbal_viewer/FieldWidget.dart';
import 'package:voetbal_viewer/football_icons.dart';
import 'TeamWidget.dart';
import 'package:voetbal_viewer/PresentWidget.dart';
import 'package:voetbal_viewer/GlobalVariable.dart';
import 'package:voetbal_viewer/Player.dart';
import 'package:voetbal_viewer/bottom_modal.dart';

class DragTargetWidget extends StatefulWidget {
  DragTargetWidget({Key key}) : super(key: key);

  @override
  DragTargetWidgetState createState() => DragTargetWidgetState();
}

class DragTargetWidgetState extends State<DragTargetWidget> {
  bool accepted = false;
  bool fieldSetup = false;
  String name;

  Widget build(BuildContext context) {
    fieldSetup = false;
    return Container(
      child: fieldSetup ? fourFourTwo() : fourThreeThree(),
    );
  }

  Widget fourThreeThree() {
    return Stack(
      children: <Widget>[
        frontleft(),
        centralattacker(),
        frontright(),
        middleleft(),
        centralmiddle(),
        middleright(),
        leftback(),
        rightback(),
        frontstopper(),
        centraldefender(),
        keeper(),
      ],
    );
  }

  Widget fourFourTwo() {
    return Stack(
      children: <Widget>[
        frontleft(),
        frontright(),
        middleleft(),
        middleright(),
        centralmiddle(),
        centralmiddelright(),
        leftback(),
        rightback(),
        frontstopper(),
        centraldefender(),
        keeper(),
      ],
    );
  }

  Widget keeper() {
    return Padding(
      padding: EdgeInsets.only(top: 490.0, left: 129.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0062A5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 30.0,
        width: 100.0,
        child: DragTarget(
          onWillAccept: (data) {
            if (data == Player) {
              return true;
            } else {
              return false;
            }
          },
          onAccept: (Player data) {
            setState(() {
              accepted = true;
              name = data.title;
            });
            saveData();
          },
          builder: (BuildContext context, List<Player> acceptedlist, rejectedlist) {
            if (accepted) {
              return Center(
                child: Text(name),
              );
            } else {
              return Center(
                child: Text('keeper'),
              );
            }
          },
        ),
      ),
    );
  }

  Widget rightback() {
    return Padding(
      padding: EdgeInsets.only(top: 370.0, left: 240.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0062A5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 30.0,
        width: 100.0,
        child: DragTarget(
          builder: (context, List<Player> candidateData, rejectedData) {
            return Center(child: Text('rightback'));
          },
        ),
      ),
    );
  }

  Widget leftback() {
    return Padding(
      padding: EdgeInsets.only(top: 370.0, left: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0062A5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 30.0,
        width: 100.0,
        child: DragTarget(
          builder: (context, List<Player> candidateData, rejectedData) {
            return Center(child: Text('leftback'));
          },
        ),
      ),
    );
  }

  Widget centraldefender() {
    return Padding(
      padding: EdgeInsets.only(top: 425.0, left: 200.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0062A5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 30.0,
        width: 100.0,
        child: DragTarget(
          builder: (context, List<Player> candidateData, rejectedData) {
            return Center(child: Text('centraldefender'));
          },
        ),
      ),
    );
  }

  Widget frontstopper() {
    return Padding(
      padding: EdgeInsets.only(top: 425.0, left: 60.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0062A5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 30.0,
        width: 100.0,
        child: DragTarget(
          builder: (context, List<Player> candidateData, rejectedData) {
            return Center(child: Text('frontstopper'));
          },
        ),
      ),
    );
  }

  Widget middleleft() {
    return Padding(
      padding: EdgeInsets.only(top: 250.0, left: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0062A5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 30.0,
        width: 100.0,
        child: DragTarget(
          builder: (context, List<Player> candidateData, rejectedData) {
            return Center(child: Text('middleleft'));
          },
        ),
      ),
    );
  }

  Widget centralmiddle() {
    return Padding(
      padding: EdgeInsets.only(top: 320.0, left: fieldSetup ? 60.0 : 129.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0062A5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 30.0,
        width: 100.0,
        child: DragTarget(
          builder: (context, List<Player> candidateData, rejectedData) {
            return Center(child: Text('centralmiddle'));
          },
        ),
      ),
    );
  }

  Widget middleright() {
    return Padding(
      padding: EdgeInsets.only(top: 250.0, left: 240.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0062A5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 30.0,
        width: 100.0,
        child: DragTarget(
          builder: (context, List<Player> candidateData, rejectedData) {
            return Center(child: Text('middleright'));
          },
        ),
      ),
    );
  }

  Widget frontleft() {
    return Padding(
      padding: EdgeInsets.only(
          top: fieldSetup ? 120.0 : 150.0, left: fieldSetup ? 60.0 : 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0062A5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 30.0,
        width: 100.0,
        child: DragTarget(
          builder: (context, List<Player> candidateData, rejectedData) {
            return Center(child: Text('frontleft'));
          },
        ),
      ),
    );
  }

  Widget centralattacker() {
    return Padding(
      padding: EdgeInsets.only(top: 110.0, left: 129.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0062A5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 30.0,
        width: 100.0,
        child: DragTarget(
          builder: (context, List<Player> candidateData, rejectedData) {
            return Center(child: Text('centralattacker'));
          },
        ),
      ),
    );
  }

  Widget frontright() {
    return Padding(
      padding: EdgeInsets.only(
          top: fieldSetup ? 120.0 : 150.0, left: fieldSetup ? 200.0 : 240.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0062A5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 30.0,
        width: 100.0,
        child: DragTarget(
          builder: (context, List<Player> candidateData, rejectedData) {
            return Center(child: Text('frontright'));
          },
        ),
      ),
    );
  }

  Widget centralmiddelright() {
    return Padding(
      padding: EdgeInsets.only(top: 320.0, left: 200.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0062A5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 30.0,
        width: 100.0,
        child: DragTarget(
          builder: (context, List<Player> candidateData, rejectedData) {
            return Center(child: Text('centremiddleright'));
          },
        ),
      ),
    );
  }

  void saveData() {
    List<String> stringList =
        players.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('players', stringList);
  }
}
