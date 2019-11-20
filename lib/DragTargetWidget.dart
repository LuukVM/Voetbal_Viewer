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
  bool occupied = false;
  String name;
  int index = 1;
  //List<Widget> field = new List<Widget>();

  // void initState() {
  //   super.initState();
  //   field.add(position(0, occupied, name, 100, 150)); //keeper
  //   field.add(position(1, occupied, name, 120, 270)); //rightback
  //   field.add(position(2, occupied, name, 340, 270)); //leftback
  //   field.add(position(3, occupied, name, 150, 215)); //centraldefender
  //   field.add(position(4, occupied, name, 310, 215)); //frontstopper
  //   field.add(position(5, occupied, name, 340, 405)); //middleleft
  //   field.add(position(6, occupied, name, widget.fieldSetupbool ? 100 : 240,
  //       340)); //centralmiddle
  //   field.add(position(7, occupied, name, 120, 405)); //middleright
  //   field.add(position(8, occupied, name, widget.fieldSetupbool ? 300 : 340,
  //       widget.fieldSetupbool ? 520 : 490)); //frontleft
  //   field.add(position(9, occupied, name, widget.fieldSetupbool ? 150 : 100,
  //       widget.fieldSetupbool ? 340 : 530)); //centralattacker
  //   field.add(position(10, occupied, name, widget.fieldSetupbool ? 160 : 120,
  //       widget.fieldSetupbool ? 520 : 490)); //frontright
  // }

  Widget build(BuildContext context) {
    return Container(
      child: fieldSetup(index, ''),
    );
  }

  Widget fieldSetup(int _index, item) {
    // return ListView.builder(
    //     itemCount: field.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       return field[index];
    //     });
    return IndexedStack(
      index: _index,
      children: <Widget>[
      position(0, occupied, item, 100, 150),  //keeper
      position(1, occupied, item, -50, 215),  //centerdefender
      position(2, occupied, item, 250, 215),  //frontstopper
      position(3, occupied, item, 320, 270),  //leftback
      position(4, occupied, item, -120, 270), //rightback
      position(5, occupied, item, 320, 405),  //middleleft
      position(6, occupied, item, widget.fieldSetupbool ? 240 : 100, 340),  //centermiddle
      position(7, occupied, item, -120, 405), //middleright
      position(8, occupied, item, widget.fieldSetupbool ? 250 : 320, widget.fieldSetupbool ? 520 : 490),  //frontleft
      position(9, occupied, item, widget.fieldSetupbool ? -50 : 100, widget.fieldSetupbool ? 340 : 530),  //centralattacker
      position(10, occupied, item, widget.fieldSetupbool ? -50 : -120, widget.fieldSetupbool ? 520 : 490), //frontright
    ]);
  }

  Widget position(
      int _index, bool _occupied, _item, double x, double y) {
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
              blurRadius: 6.0,
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
          onPressed: () => _showBottomSheet(context, _item, _index, x, y),
        ),
      ),
    );
  }

  Widget rightback(bool _occupied, String _name) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height - 270.0,
          left: MediaQuery.of(context).size.width - 120),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0062A5),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black87,
              offset: Offset(1.0, 4.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        height: 30.0,
        width: 100.0,
        child: FlatButton(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              _occupied ? _name : ' ',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
          ),
          //onPressed: () => _showBottomSheet(context, _name, 1),
        ),
      ),
    );
  }

  // Widget leftback() {
  //   return Padding(
  //     padding: EdgeInsets.only(
  //       top: MediaQuery.of(context).size.height - 270,
  //       left: MediaQuery.of(context).size.width - 340),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Color(0xFF0062A5),
  //         borderRadius: BorderRadius.circular(10.0),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black87,
  //             offset: Offset(1.0, 4.0),
  //             blurRadius: 6.0,
  //           ),
  //         ],
  //       ),
  //       height: 30.0,
  //       width: 100.0,
  //       child: FlatButton(
  //         child: FittedBox(
  //           fit: BoxFit.scaleDown,
  //           child: Text(
  //             ' ',
  //             style: TextStyle(
  //                 fontSize: 16.0,
  //                 fontWeight: FontWeight.w300,
  //                 color: Colors.white),
  //           ),
  //         ),
  //         onPressed: () => _showBottomSheet(context),
  //       ),
  //     ),
  //   );
  // }

  // Widget centraldefender() {
  //   return Padding(
  //     padding: EdgeInsets.only(
  //       top: MediaQuery.of(context).size.height - 215,
  //       left: MediaQuery.of(context).size.width - 150),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Color(0xFF0062A5),
  //         borderRadius: BorderRadius.circular(10.0),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black87,
  //             offset: Offset(1.0, 4.0),
  //             blurRadius: 6.0,
  //           ),
  //         ],
  //       ),
  //       height: 30.0,
  //       width: 100.0,
  //       child: FlatButton(
  //         child: FittedBox(
  //           fit: BoxFit.scaleDown,
  //           child: Text(
  //             ' ',
  //             style: TextStyle(
  //                 fontSize: 16.0,
  //                 fontWeight: FontWeight.w300,
  //                 color: Colors.white),
  //           ),
  //         ),
  //         onPressed: () => _showBottomSheet(context),
  //       ),
  //     ),
  //   );
  // }

  // Widget frontstopper() {
  //   return Padding(
  //     padding: EdgeInsets.only(
  //       top: MediaQuery.of(context).size.height - 215,
  //       left: MediaQuery.of(context).size.width - 310),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Color(0xFF0062A5),
  //         borderRadius: BorderRadius.circular(10.0),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black87,
  //             offset: Offset(1.0, 4.0),
  //             blurRadius: 6.0,
  //           ),
  //         ],
  //       ),
  //       height: 30.0,
  //       width: 100.0,
  //       child: FlatButton(
  //         child: FittedBox(
  //           fit: BoxFit.scaleDown,
  //           child: Text(
  //             ' ',
  //             style: TextStyle(
  //                 fontSize: 16.0,
  //                 fontWeight: FontWeight.w300,
  //                 color: Colors.white),
  //           ),
  //         ),
  //         onPressed: () => _showBottomSheet(context),
  //       ),
  //     ),
  //   );
  // }

  // Widget middleleft() {
  //   return Padding(
  //     padding: EdgeInsets.only(
  //       top: MediaQuery.of(context).size.height - 405,
  //       left: MediaQuery.of(context).size.width - 340),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Color(0xFF0062A5),
  //         borderRadius: BorderRadius.circular(10.0),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black87,
  //             offset: Offset(1.0, 4.0),
  //             blurRadius: 6.0,
  //           ),
  //         ],
  //       ),
  //       height: 30.0,
  //       width: 100.0,
  //       child: FlatButton(
  //         child: FittedBox(
  //           fit: BoxFit.scaleDown,
  //           child: Text(
  //             ' ',
  //             style: TextStyle(
  //                 fontSize: 16.0,
  //                 fontWeight: FontWeight.w300,
  //                 color: Colors.white),
  //           ),
  //         ),
  //         onPressed: () => _showBottomSheet(context),
  //       ),
  //     ),
  //   );
  // }

  // Widget centralmiddle() {
  //   return Padding(
  //     padding: EdgeInsets.only(
  //         top: MediaQuery.of(context).size.height - 340,
  //         left: widget.fieldSetupbool ? (MediaQuery.of(context).size.width - 240) /2
  //           : (MediaQuery.of(context).size.width - 100) /2),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Color(0xFF0062A5),
  //         borderRadius: BorderRadius.circular(10.0),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black87,
  //             offset: Offset(1.0, 4.0),
  //             blurRadius: 6.0,
  //           ),
  //         ],
  //       ),
  //       height: 30.0,
  //       width: 100.0,
  //       child: FlatButton(
  //         child: FittedBox(
  //           fit: BoxFit.fitHeight,
  //           child: FittedBox(
  //             fit: BoxFit.scaleDown,
  //             child: Text(
  //               ' ',
  //               style: TextStyle(
  //                   fontSize: 16.0,
  //                   fontWeight: FontWeight.w300,
  //                   color: Colors.white),
  //             ),
  //           ),
  //         ),
  //         onPressed: () => _showBottomSheet(context),
  //       ),
  //     ),
  //   );
  // }

  // Widget middleright() {
  //   return Padding(
  //     padding: EdgeInsets.only(
  //       top: MediaQuery.of(context).size.height - 405,
  //       left: MediaQuery.of(context).size.width - 120),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Color(0xFF0062A5),
  //         borderRadius: BorderRadius.circular(10.0),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black87,
  //             offset: Offset(1.0, 4.0),
  //             blurRadius: 6.0,
  //           ),
  //         ],
  //       ),
  //       height: 30.0,
  //       width: 100.0,
  //       child: FlatButton(
  //         child: FittedBox(
  //           fit: BoxFit.scaleDown,
  //           child: Text(
  //             ' ',
  //             style: TextStyle(
  //                 fontSize: 16.0,
  //                 fontWeight: FontWeight.w300,
  //                 color: Colors.white),
  //           ),
  //         ),
  //         onPressed: () => _showBottomSheet(context),
  //       ),
  //     ),
  //   );
  // }

  // Widget frontleft() {
  //   return Padding(
  //     padding: EdgeInsets.only(
  //         top: widget.fieldSetupbool ? MediaQuery.of(context).size.height - 520
  //           : MediaQuery.of(context).size.height - 490,
  //         left: widget.fieldSetupbool ? MediaQuery.of(context).size.width - 300
  //           : MediaQuery.of(context).size.width - 340),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Color(0xFF0062A5),
  //         borderRadius: BorderRadius.circular(10.0),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black87,
  //             offset: Offset(1.0, 4.0),
  //             blurRadius: 6.0,
  //           ),
  //         ],
  //       ),
  //       height: 30.0,
  //       width: 100.0,
  //       child: FlatButton(
  //         child: FittedBox(
  //           fit: BoxFit.scaleDown,
  //           child: Text(
  //             ' ',
  //             style: TextStyle(
  //                 fontSize: 16.0,
  //                 fontWeight: FontWeight.w300,
  //                 color: Colors.white),
  //           ),
  //         ),
  //         onPressed: () => _showBottomSheet(context),
  //       ),
  //     ),
  //   );
  // }

  // Widget centralattacker() {
  //   return Padding(
  //     padding: EdgeInsets.only(
  //         top: widget.fieldSetupbool ? MediaQuery.of(context).size.height - 340
  //           : MediaQuery.of(context).size.height - 530,
  //         left: widget.fieldSetupbool ? (MediaQuery.of(context).size.width + 40) /2
  //           : (MediaQuery.of(context).size.width - 100) /2),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Color(0xFF0062A5),
  //         borderRadius: BorderRadius.circular(10.0),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black87,
  //             offset: Offset(1.0, 4.0),
  //             blurRadius: 6.0,
  //           ),
  //         ],
  //       ),
  //       height: 30.0,
  //       width: 100.0,
  //       child: FlatButton(
  //         child: FittedBox(
  //           fit: BoxFit.scaleDown,
  //           child: Text(
  //             ' ',
  //             style: TextStyle(
  //                 fontSize: 16.0,
  //                 fontWeight: FontWeight.w300,
  //                 color: Colors.white),
  //           ),
  //         ),
  //         onPressed: () => _showBottomSheet(context),
  //       ),
  //     ),
  //   );
  // }

  // Widget frontright() {
  //   return Padding(
  //     padding: EdgeInsets.only(
  //         top: widget.fieldSetupbool ? MediaQuery.of(context).size.height - 520
  //           : MediaQuery.of(context).size.height - 490,
  //         left: widget.fieldSetupbool ? MediaQuery.of(context).size.width - 160
  //           : MediaQuery.of(context).size.width - 120),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Color(0xFF0062A5),
  //         borderRadius: BorderRadius.circular(10.0),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black87,
  //             offset: Offset(1.0, 4.0),
  //             blurRadius: 6.0,
  //           ),
  //         ],
  //       ),
  //       height: 30.0,
  //       width: 100.0,
  //       child: FlatButton(
  //         child: FittedBox(
  //           fit: BoxFit.scaleDown,
  //           child: Text(
  //             ' ',
  //             style: TextStyle(
  //                 fontSize: 16.0,
  //                 fontWeight: FontWeight.w300,
  //                 color: Colors.white),
  //           ),
  //         ),
  //         onPressed: () => _showBottomSheet(context),
  //       ),
  //     ),
  //   );
  // }

  _showBottomSheet(BuildContext context, currentName, _index, x, y) async {
    Vibration.vibrate(duration: 50, amplitude: 125);
    Player _item = await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => BottomSheetSwitch(),
    );

    if (_item != null) {
      setState(() {
        position(_index, true, _item, x, y);
      });
      print(name);
    } else {
      position(_index, false, (_index + 1).toString(), x, y);
    }
  }

  void saveData() {
    List<String> stringList =
        players.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('players', stringList);
  }
}
