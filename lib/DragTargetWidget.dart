import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:voetbal_viewer/FieldWidget.dart';
import 'package:voetbal_viewer/football_icons.dart';
import 'TeamWidget.dart';
import 'package:voetbal_viewer/PresentWidget.dart';
import 'package:voetbal_viewer/GlobalVariable.dart';
import 'package:voetbal_viewer/Player.dart';
import 'package:voetbal_viewer/bottom_modal.dart';

class DragTargetWidget extends StatefulWidget {
  final bool fieldSetupbool;
  DragTargetWidget({Key key, @required this.fieldSetupbool}) : super(key: key);

  @override
  DragTargetWidgetState createState() => DragTargetWidgetState();
}

class DragTargetWidgetState extends State<DragTargetWidget> {
  String name;
  int index;
  List<Player> playersInfield = new List<Player>();

  @override
  void initState() {
    super.initState();
    playersInfield = players.where((x) => x.inField).toList();
  }

  Widget build(BuildContext context) {
    return Container(
      child: test(),
    );
  }

  Widget test() {
    return Stack(
      children: <Widget>[
        fieldSetup('unoccupied', false),
        playersInfield.isNotEmpty ? getPresetPlayers() : Center(),
      ],
    );
  }

  Widget fieldSetup(item, _occupied) {
    return Stack(
      children: <Widget>[
        position(0, _occupied, item, 100, 150), //keeper
        position(1, _occupied, item, -50, 215), //centerdefender
        position(2, _occupied, item, 250, 215), //frontstopper
        position(3, _occupied, item, 320, 270), //leftback
        position(4, _occupied, item, -120, 270), //rightback
        position(5, _occupied, item, 320, 405), //middleleft
        position(6, _occupied, item, widget.fieldSetupbool ? 240 : 100,
            340), //centermiddle
        position(7, _occupied, item, -120, 405), //middleright
        position(8, _occupied, item, widget.fieldSetupbool ? 250 : 320,
            widget.fieldSetupbool ? 520 : 490), //frontleft
        position(9, _occupied, item, widget.fieldSetupbool ? -50 : 100,
            widget.fieldSetupbool ? 340 : 530), //centralattacker
        position(10, _occupied, item, widget.fieldSetupbool ? -50 : -120,
            widget.fieldSetupbool ? 520 : 490), //frontright
      ],
    );
  }

  Widget getPresetPlayers() {
    return Stack(children: <Widget>[
      for(Player players in playersInfield) rebuildSetup(players.fieldIndex, players, true),
    ]);
  }

  Widget rebuildSetup(int _index, item, _occupied) {
    return IndexedStack(
      index: _index,
      children: <Widget>[
        position(0, _occupied, item, 100, 150), //keeper
        position(1, _occupied, item, -50, 215), //centerdefender
        position(2, _occupied, item, 250, 215), //frontstopper
        position(3, _occupied, item, 320, 270), //leftback
        position(4, _occupied, item, -120, 270), //rightback
        position(5, _occupied, item, 320, 405), //middleleft
        position(6, _occupied, item, widget.fieldSetupbool ? 240 : 100,
            340), //centermiddle
        position(7, _occupied, item, -120, 405), //middleright
        position(8, _occupied, item, widget.fieldSetupbool ? 250 : 320,
            widget.fieldSetupbool ? 520 : 490), //frontleft
        position(9, _occupied, item, widget.fieldSetupbool ? -50 : 100,
            widget.fieldSetupbool ? 340 : 530), //centralattacker
        position(10, _occupied, item, widget.fieldSetupbool ? -50 : -120,
            widget.fieldSetupbool ? 520 : 490), //frontright
      ],
    );
  }

  Widget position(int _index, bool _occupied, _item, double x, double y) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height - y,
          left: (MediaQuery.of(context).size.width - x) / 2),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0062A5),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black87,
              offset: Offset(1.0, 4.0),
              blurRadius: 3.0,
            ),
          ],
        ),
        height: 30.0,
        width: 100.0,
        child: FlatButton(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              _occupied ? _item.title : (_index + 1).toString(),
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
          ),
          onPressed: () => _showBottomSheet(context, _item, _index, _occupied),
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context, currentName, _index, _occupied) async {
    Vibration.vibrate(duration: 50, amplitude: 125);
    Player _item = await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => BottomSheetSwitch(),
    );

    if (_item != null) {
      setState(() {
        _item.fieldIndex = _index;
        _occupied ? setPlayeroutField(currentName) : null;
        saveData();
        rebuildSetup(_index, _item, true);
        playersInfield = players.where((x) => x.inField).toList();
      });
    } else {
      rebuildSetup(_index, (_index + 1).toString(), false);
    }
  }

  void saveData() {
    List<String> stringList =
        players.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('players', stringList);
  }

  void setPlayeroutField(Player item) {
    setState(() {
      item.inField = false;
      item.fieldIndex = null;
      saveData();
    });
  }
}
