import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vibration/vibration.dart';
import 'package:voetbal_viewer/Player.dart';
import 'package:voetbal_viewer/GlobalVariable.dart';

class Present extends StatefulWidget {
  const Present({Key key}) : super(key: key);
  @override
  PresentState createState() => PresentState();
}

class PresentState extends State<Present> with SingleTickerProviderStateMixin {
  List<Player> presentPlayers = new List();

  @override
  void initState() {
    super.initState();
    presentPlayers = players.where((x) => x.present).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Text(
                'Aanwezige spelers',
                key: Key('PresentWidget'),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width - 248),
                child: IconButton(
                    icon: Icon(Icons.loop),
                    onPressed: () => {
                          changeAllItemCompleteness(players),
                          setState(() {
                            presentPlayers =
                                players.where((x) => x.present).toList();
                          }),
                          _vibrate(),
                        }),
              ),
            ],
          ),
          backgroundColor: Color(0xFF0062A5),
        ),
        body: presentPlayers.isEmpty ? emptyList() : buildListView());
  }

  Widget buildListView() {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        height: 0.0,
        color: Colors.black,
      ),
      itemCount: presentPlayers.length,
      itemBuilder: (BuildContext context, int index) {
        return buildListTile(presentPlayers[index], index);
      },
    );
  }

  Widget emptyList() {
    return Center(
      child: Text('Geen spelers aanwezig'),
    );
  }

  Widget buildListTile(item, index) {
    return ListTile(
        onTap: () => {
              _vibrate(),
              changeItemCompleteness(item),
              setState(() {
                presentPlayers = players.where((x) => x.present).toList();
              }),
            },
        title: Text(
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
          onPressed: () => {
            setCarState(item),
            _vibrate(),
          },
        ));
  }

  void changeItemCompleteness(Player item) {
    setState(() {
      item.present = !item.present;
      item.inField = false;
    });
    saveData();
  }

  void changeAllItemCompleteness(List<Player> item) {
    for (var i = 0; i < item.length; i++) {
      if (item[i].present == true) {
        setState(() {
          item[i].present = !item[i].present;
          item[i].inField = false;
        });
      }
    }
    saveData();
  }

  void setCarState(Player item) {
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

  void _vibrate() {
    Vibration.vibrate(duration: 50, amplitude: 125);
  }
}
