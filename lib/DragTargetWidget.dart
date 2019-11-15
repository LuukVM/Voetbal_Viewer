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
  final bool fieldSetupbool;
  DragTargetWidget({Key key, @required this.fieldSetupbool}) : super(key: key);

  @override
  DragTargetWidgetState createState() => DragTargetWidgetState();
}

class DragTargetWidgetState extends State<DragTargetWidget> {
  bool accepted = false;
  String name;

  Widget build(BuildContext context) {
    return Container(
      child: fieldSetup(),
    );
  }

  Widget fieldSetup() {
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

  Widget keeper() {
    return Padding(
      padding: EdgeInsets.only(top: 490.0, left: 129.0),
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
              'Stan',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
          ),
          onPressed: () => _showBottomSheet(context),
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
              'Mark',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
          ),
          onPressed: () => _showBottomSheet(context),
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
              'Wesley',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
          ),
          onPressed: () => _showBottomSheet(context),
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
              'Luuk',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
          ),
          onPressed: () => _showBottomSheet(context),
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
              'Emiel',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
          ),
          onPressed: () => _showBottomSheet(context),
        ),
      ),
    );
  }

  Widget middleleft() {
    return Padding(
      padding: EdgeInsets.only(top: 235.0, left: 20.0),
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
              'Sven',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
          ),
          onPressed: () => _showBottomSheet(context),
        ),
      ),
    );
  }

  Widget centralmiddle() {
    return Padding(
      padding: EdgeInsets.only(
          top: 300.0, left: widget.fieldSetupbool ? 60.0 : 129.0),
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
            fit: BoxFit.fitHeight,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Matthijs vd Linden',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              ),
            ),
          ),
          onPressed: () => _showBottomSheet(context),
        ),
      ),
    );
  }

  Widget middleright() {
    return Padding(
      padding: EdgeInsets.only(top: 235.0, left: 240.0),
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
              'Joshua',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
          ),
          onPressed: () => _showBottomSheet(context),
        ),
      ),
    );
  }

  Widget frontleft() {
    return Padding(
      padding: EdgeInsets.only(
          top: widget.fieldSetupbool ? 120.0 : 150.0,
          left: widget.fieldSetupbool ? 60.0 : 20.0),
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
              'Co',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
          ),
          onPressed: () => _showBottomSheet(context),
        ),
      ),
    );
  }

  Widget centralattacker() {
    return Padding(
      padding: EdgeInsets.only(
          top: widget.fieldSetupbool ? 300.0 : 110.0,
          left: widget.fieldSetupbool ? 200.0 : 129.0),
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
              'Matthijs vd Wouw',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
          ),
          onPressed: () => _showBottomSheet(context),
        ),
      ),
    );
  }

  Widget frontright() {
    return Padding(
      padding: EdgeInsets.only(
          top: widget.fieldSetupbool ? 120.0 : 150.0,
          left: widget.fieldSetupbool ? 200.0 : 240.0),
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
              'Joep',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
          ),
          onPressed: () => _showBottomSheet(context),
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => BottomSheetSwitch());
  }

  void saveData() {
    List<String> stringList =
        players.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('players', stringList);
  }
}
