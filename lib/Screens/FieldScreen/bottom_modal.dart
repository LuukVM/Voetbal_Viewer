import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:voetbal_viewer/GlobalVariable.dart';
import 'package:voetbal_viewer/Persons/Player.dart';
import 'package:voetbal_viewer/Services/database.dart';

class BottomSheetSwitch extends StatefulWidget {
  final playerlist;
  final index;
  BottomSheetSwitch({Key key, this.playerlist, this.index}) : super(key: key);

  @override
  _BottomSheetSwitch createState() => _BottomSheetSwitch();
}

class _BottomSheetSwitch extends State<BottomSheetSwitch> {
  PageController _pageController;
  List<Player> presentPlayers = new List();

  @override
  void initState() {
    super.initState();
    presentPlayers = widget.playerlist.where((x) => x.present && !x.inField).toList();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.4);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
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
      child: FlatButton(
        child: buildContainer(item, index),
        onPressed: () => {
          setInfield(item),
          submit(item),
          Vibration.vibrate(duration: 50, amplitude: 125),
        },
      ),
    );
  }

  Widget buildContainer(item, index) {
    return Stack(
      children: [
        Center(
          child: Container(
            height: 50.0,
            width: 170.0,
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
                  color: Color(0xFF0062A5)),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  children: [
                    Container(
                      height: 30.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0)),
                      ),
                    ),
                    Text(
                      item.title,
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
  
  void submit(Player item){
    Navigator.pop(context, item);
  }

  void setInfield(Player item) async {
    await DatabaseService(uid: item.id).updatePlayerInField(!item.inField);
  }
}