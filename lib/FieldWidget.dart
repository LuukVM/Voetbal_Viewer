import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: new Image.asset(
              'fonts/field.png',
              width: size.width,
              height: size.height,
              fit: BoxFit.fill,
            ),
          ),
          DragTargetWidget(),
          Align(
            alignment: Alignment(0.95, 0.95),
            child: FloatingActionButton(
              child: Icon(
                Icons.compare_arrows,
                color: Colors.white,
              ),
              backgroundColor: Color(0xFF0062A5),
              onPressed: (bottomSheetActive
                  ? null
                  : () {
                      setState(() {
                        bottomSheetActive = true;
                      });
                      _showBottomSheet(context);
                    }),
            ),
          ),
        ],
      ),
    );
  }

  _showBottomSheet(BuildContext context) {
    showBottomSheet<void>(
        backgroundColor: Colors.blue,
        context: context,
        builder: (context) => BottomSheetSwitch()).closed.whenComplete(
      () {
        if (mounted) {
          setState(
            () {
              bottomSheetActive = false;
            },
          );
        }
      },
    );
  }
}
