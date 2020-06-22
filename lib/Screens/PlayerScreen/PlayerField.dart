import 'package:flutter/material.dart';
import 'package:voetbal_viewer/Persons/Player.dart';
import 'package:voetbal_viewer/Services/database.dart';

class PlayerField extends StatefulWidget {
  final bool fieldSetup_;
  PlayerField({Key key, this.fieldSetup_}) : super(key: key);

  @override
  PlayerFieldState createState() => PlayerFieldState();
}

class PlayerFieldState extends State<PlayerField> {
  String name;
  int index;
  List<Player> _playersInfield = new List<Player>();

  @override
  void initState() {
    super.initState();
    //playersInfield = players.where((x) => x.inField).toList();
    // _playersInfield = widget.playersInfield;
  }

  Widget build(BuildContext context) {
    return StreamBuilder<List<Player>>(
        stream: DatabaseService().players,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _playersInfield = snapshot.data.where((x) => x.inField).toList();
          }
          return Container(
            child: test(),
          );
        });
  }

  Widget test() {
    return Stack(
      children: <Widget>[
        fieldSetup('unoccupied', false),
        _playersInfield.isNotEmpty ? getPresetPlayers() : Center(),
      ],
    );
  }

  Widget fieldSetup(item, _occupied) {
    return Stack(
      children: <Widget>[
        position(0, _occupied, item, 0.50, 0.77), //keeper
        position(1, _occupied, item, 0.75, 0.69), //centerdefender
        position(2, _occupied, item, 0.25, 0.69), //frontstopper
        position(3, _occupied, item, 0.05, 0.60), //leftback
        position(4, _occupied, item, 0.95, 0.60), //rightback
        position(5, _occupied, item, 0.15, 0.40), //middleleft
        position(6, _occupied, item, widget.fieldSetup_ ? 0.25 : 0.50,
            0.50), //centermiddle
        position(7, _occupied, item, 0.85, 0.40), //middleright
        position(8, _occupied, item, widget.fieldSetup_ ? 0.25 : 0.05,
            0.25), //frontleft
        position(9, _occupied, item, widget.fieldSetup_ ? 0.75 : 0.5,
            widget.fieldSetup_ ? 0.50 : 0.15), //centralattacker
        position(10, _occupied, item, widget.fieldSetup_ ? 0.75 : 0.95,
            0.25), //frontright
      ],
    );
  }

  Widget getPresetPlayers() {
    return Stack(children: <Widget>[
      for (Player players in _playersInfield)
        rebuildSetup(players.fieldIndex, players, true),
    ]);
  }

  Widget rebuildSetup(int _index, item, _occupied) {
    return IndexedStack(
      index: _index,
      children: <Widget>[
        position(0, _occupied, item, 0.50, 0.77), //keeper
        position(1, _occupied, item, 0.75, 0.69), //centerdefender
        position(2, _occupied, item, 0.25, 0.69), //frontstopper
        position(3, _occupied, item, 0.05, 0.60), //leftback
        position(4, _occupied, item, 0.95, 0.60), //rightback
        position(5, _occupied, item, 0.15, 0.40), //middleleft
        position(6, _occupied, item, widget.fieldSetup_ ? 0.25 : 0.50,
            0.50), //centermiddle
        position(7, _occupied, item, 0.85, 0.40), //middleright
        position(8, _occupied, item, widget.fieldSetup_ ? 0.25 : 0.05,
            0.25), //frontleft
        position(9, _occupied, item, widget.fieldSetup_ ? 0.75 : 0.5,
            widget.fieldSetup_ ? 0.50 : 0.15), //centralattacker
        position(10, _occupied, item, widget.fieldSetup_ ? 0.75 : 0.95,
            0.25), //frontright
      ],
    );
  }

  Widget position(int _index, bool _occupied, _item, double x, double y) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * y,
          left: (MediaQuery.of(context).size.width - 100) * x),
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
      ),
    );
  }
}
