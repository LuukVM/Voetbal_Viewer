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
  int index;
  List<Widget> field = new List<Widget>();

  void initState() {
    super.initState();
    field.add(position(0, occupied, name, 100, 150)); //keeper
    field.add(position(1, occupied, name, 120, 270)); //rightback
    field.add(position(2, occupied, name, 340, 270)); //leftback
    field.add(position(3, occupied, name, 150, 215)); //centraldefender
    field.add(position(4, occupied, name, 310, 215)); //frontstopper
    field.add(position(5, occupied, name, 340, 405)); //middleleft
    field.add(position(6, occupied, name, widget.fieldSetupbool ? 100 : 240,
        340)); //centralmiddle
    field.add(position(7, occupied, name, 120, 405)); //middleright
    field.add(position(8, occupied, name, widget.fieldSetupbool ? 300 : 340,
        widget.fieldSetupbool ? 520 : 490)); //frontleft
    field.add(position(9, occupied, name, widget.fieldSetupbool ? 150 : 100,
        widget.fieldSetupbool ? 340 : 530)); //centralattacker
    field.add(position(10, occupied, name, widget.fieldSetupbool ? 160 : 120,
        widget.fieldSetupbool ? 520 : 490)); //frontright
  }

  Widget build(BuildContext context) {
    return Container(
      child: fieldSetup(index),
    );
  }

  Widget fieldSetup(int _index) {
    return ListView.builder(
        itemCount: field.length,
        itemBuilder: (BuildContext context, int index) {
          return field[index];
        });
  }

  Widget position(
      int _index, bool _occupied, String _name, double x, double y) {
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
              _occupied ? _name : ' ',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
          ),
          onPressed: () => _showBottomSheet(context, _name, _index),
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
          onPressed: () => _showBottomSheet(context, _name, 1),
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

  _showBottomSheet(BuildContext context, currentName, _index) async {
    Vibration.vibrate(duration: 50, amplitude: 125);
    currentName = await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => BottomSheetSwitch(),
    );

    if (currentName != null) {
      setState(() {
        name = currentName;
        occupied = true;
      });
      print(name);
    } else {
      name = '';
      occupied = false;
    }
  }

  void saveData() {
    List<String> stringList =
        players.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('players', stringList);
  }
}
