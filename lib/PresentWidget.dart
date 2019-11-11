import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:voetbal_viewer/Player.dart';
import 'package:voetbal_viewer/GlobalVariable.dart';

class Present extends StatefulWidget {
  const Present({Key key}) : super(key: key);
  @override
  PresentState createState() => PresentState();
}

class PresentState extends State<Present> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Aanwezige spelers',
            key: Key('PresentWidget'),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF0062A5),
        ),
        body: buildListView());
  }

  Widget buildListView() {
    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (BuildContext context, int index) {
        if (players[index].present == true) {
          return buildListTile(players[index], index);
        } else {
          return emptyList();
        }
      },
    );
  }

  Widget emptyList() {
    return Center();
  }

  Widget buildListTile(item, index) {
    return ListTile(
      onTap: () => changeItemCompleteness(item),
      title: 
          Text(
            item.title,
            key: Key('item-$index'),
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: item.present ? Colors.green : Colors.grey[600],
            ),
          ),
      trailing: IconButton(
            icon: Icon(item.hasCar ? Icons.directions_car : Icons.directions_walk,
            key: Key('hasCar-icon-$index'),
            color: item.hasCar ? Colors.deepOrange : Colors.grey[600]),
            onPressed: () => setCarState(item),
            )
    );
  }

  void changeItemCompleteness(Player item) {
    setState(() {
      item.present = !item.present;
    });
    saveData();
  }

  void setCarState(Player item){
    setState(() {
     item.hasCar = !item.hasCar;
    });
    saveData();
  }

  void saveData() {
    List<String> stringList =
        players.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('players', stringList);
  }
}
