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
  bool fieldSetup = true;
  bool bottomSheetActive = false;

  @override
  Widget build(BuildContext context) {   
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: new Image.asset(
              'fonts/field.png',
              width:   MediaQuery.of(context).size.width,
              height:  MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, left: 5),
            child: Container(
              height: 35,
              width: 64,
              decoration: BoxDecoration(
                color: Colors.white,
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
          DragTargetWidget(
            fieldSetupbool: fieldSetup,
          ),
        ],
      ),
    );
  }
}
