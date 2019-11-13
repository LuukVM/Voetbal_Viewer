import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voetbal_viewer/GlobalVariable.dart';
import 'package:voetbal_viewer/Player.dart';
import 'package:voetbal_viewer/TeamWidget.dart';

class BottomSheetSwitch extends StatefulWidget {
  BottomSheetSwitch({Key key}) : super(key: key);

  @override
  _BottomSheetSwitch createState() => _BottomSheetSwitch();
}

class _BottomSheetSwitch extends State<BottomSheetSwitch> {
  PageController _pageController;
  List<Player> presentPlayers = new List();

  @override
  void initState() {
    super.initState();
    presentPlayers = players.where((x) => x.present && !x.inField).toList();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.4);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      child: PageView.builder(
        controller: _pageController,
        itemCount: presentPlayers.length,
        itemBuilder: (BuildContext context, int index) {
          return _coffeeShopList(presentPlayers[index], index);
        },
      ),
    );
  }

  _coffeeShopList(item, index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: Draggable<Player>(
          data: item,
          onDragCompleted: () => setInfield(item),
          childWhenDragging: Container(),
          feedback: buildDraggingContainter(item, index),
          child: buildContainer(item, index)),
    );
  }

  Widget buildContainer(item, index) {
    return Stack(
      children: [
        Center(
          child: Container(
            height: 30.0,
            width: 140.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87,
                    offset: Offset(0.0, 5.0),
                    blurRadius: 8.0,
                  ),
                ]),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Row(
                  children: [
                    Container(
                      height: 50.0,
                      width: 10.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0)),
                      ),
                    ),
                    SizedBox(width: 3.0),
                    Text(
                      presentPlayers[index].title,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDraggingContainter(item, index) {
    return Stack(
      children: [
        Center(
          child: Container(
            height: 30.0,
            width: 100.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFF0062A5).withOpacity(0.9),
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Row(
                  children: [
                    Container(
                      height: 50.0,
                      width: 10.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0)),
                      ),
                    ),
                    SizedBox(width: 3.0),
                    Text(
                      presentPlayers[index].title,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void setInfield(Player item) {
    setState(() {
      item.inField = !item.inField;
    });
    saveData();
  }

  void saveData() {
    List<String> stringList =
        players.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('players', stringList);
  }
}
