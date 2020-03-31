import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:voetbal_viewer/Screens/FieldScreen/FieldWidget.dart';
import 'package:voetbal_viewer/football_icons.dart';
import 'package:voetbal_viewer/Screens/TeamScreen/TeamWidget.dart';
import 'package:voetbal_viewer/Screens/PresentScreen/PresentWidget.dart';

class BottomNavigator extends StatefulWidget {
  BottomNavigator({Key key}) : super(key: key);

  @override
  _BottomNavigator createState() => _BottomNavigator();
}

class _BottomNavigator extends State<BottomNavigator> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Team(),
    BackgroundImage(),
    Present(),
  ];

  void _onItemTapped(int index) {
    Vibration.vibrate(duration: 50, amplitude: 125);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Football.player),
            title: Text('Team'),
          ),
          BottomNavigationBarItem(
            icon: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Football.field)),
            title: Text('Veld'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Football.football),
            title: Text('Aanwezig'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF0062A5),
        onTap: _onItemTapped,
      ),
    );
  }
}
