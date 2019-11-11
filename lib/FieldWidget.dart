import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:voetbal_viewer/BottomSheet.dart';
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
          Align(
              alignment: Alignment(0.95, 0.95),
              child: FloatingActionButton(
                child: Icon(
                  Icons.compare_arrows,
                  color: Colors.white,
                ),
                backgroundColor: Color(0xFF0062A5),
                onPressed: () {
                  showBottomSheet(
                      context: context,
                      builder: (context) => ConversationBottomSheet()
                  );
                },
              )),
        ],
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Instellingen'),
          )
        ],
      )),
    );
  }

  Widget getList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: players.length,
      itemBuilder: (BuildContext context, int index) {
        if (players[index].present == true && players[index].inField == false) {
          return getDraggable(players[index], index);
        } else {
          return emptyList();
        }
      },
    );
  }

  Widget emptyList() {
    return Center();
  }

  Widget getDraggable(item, index) {
    return Draggable<Player>(
      data: item,
      child: buildContainer(item, index),
      childWhenDragging: buildDraggingContainter(item, index),
      feedback: Container(color: Colors.grey),
    );
  }

  Widget buildContainer(item, index) {
    return Container(
      child: Text(
        item.title,
        key: Key('item-$index'),
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget buildDraggingContainter(item, index) {
    return Container(
      child: Text(
        item.title,
        key: Key('item-$index'),
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
      ),
      color: Color(0xFF0062A5).withOpacity(0.5),
    );
  }

  void getDraggableWidget() {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: false,
        builder: (context) {
          return DraggableWidget();
        },
      ),
    );
  }
}