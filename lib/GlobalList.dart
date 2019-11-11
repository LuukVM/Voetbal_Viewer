import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:voetbal_viewer/Player.dart';
import 'package:voetbal_viewer/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StateContainer extends StatefulWidget {
  final List<Player> players;

  StateContainer({@required this.players});

  static StateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(InheritedList)
            as InheritedList)
        .list;
  }

  @override
  StateContainerState createState() => StateContainerState();
}

class StateContainerState extends State<StateContainer> {
  List<Player> players = new List<Player>();
  SharedPreferences sharedPreferences;

  Widget build(BuildContext context) {
    return InheritedList(list: this);
  }
}

class InheritedList extends InheritedWidget {
  final StateContainerState list;

  InheritedList({Key key, @required this.list}) : super(key: key);

  @override
  bool updateShouldNotify(InheritedList oldWidget) {
    return true;
  }
}
