import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:voetbal_viewer/Screens/TeamScreen/New_player.dart';
import 'package:voetbal_viewer/Persons/Player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voetbal_viewer/GlobalVariable.dart';
import 'package:voetbal_viewer/Services/auth.dart';
import 'package:provider/provider.dart';
import 'package:voetbal_viewer/Services/database.dart';

class Team extends StatefulWidget {
  const Team({Key key}) : super(key: key);
  @override
  TeamState createState() => TeamState();
}

class TeamState extends State<Team> with SingleTickerProviderStateMixin {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final dbPlayers = Provider.of<List<Player>>(context) ?? [];

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'sv Hillegom Zondag 11',
            key: Key('TeamWidget'),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  signoutMessage();
                }),
            IconButton(
              key: Key('DeselectAll'),
              icon: Icon(Icons.loop),
              onPressed: () => {
                changeAllItemCompleteness(dbPlayers),
                _vibrate(),
              },
            ),
          ],
          backgroundColor: Color(0xFF0062A5),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Color(0xFF0062A5),
          onPressed: () => {
            goToNewItemView(),
            _vibrate(),
          },
        ),
        body: dbPlayers.isEmpty ? emptyList() : buildListView(dbPlayers));
  }

  Widget emptyList() {
    return Center(child: Text('Geen spelers gevonden'));
  }

  Widget buildListView(List _dbPlayers) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        height: 0.0,
        color: Colors.black,
      ),
      itemCount: _dbPlayers.length,
      itemBuilder: (BuildContext context, int index) {
        return buildItem(_dbPlayers[index], index);
      },
    );
  }

  Widget buildItem(Player item, index) {
    return Dismissible(
      key: Key('${item.hashCode}'),
      background: Container(
          color: Colors.red[700],
          child: Icon(Icons.delete, color: Colors.white),
          alignment: Alignment(-0.9, 0.0)),
      onDismissed: (direction) => removeItem(item),
      direction: DismissDirection.startToEnd,
      child: buildListTile(item, index),
    );
  }

  Widget buildListTile(item, index) {
    return ListTile(
      onTap: () => {
        changeItemCompleteness(item),
        _vibrate(),
      },
      onLongPress: () => {
        goToEditItemView(item),
        _vibrate(),
      },
      title: Text(
        item.title,
        key: Key('item-$index'),
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: item.present ? Colors.green : Colors.grey[600],
        ),
      ),
      trailing: Icon(
          item.present ? Icons.check_box : Icons.check_box_outline_blank,
          key: Key('present-icon-$index'),
          color: item.present ? Colors.green : Colors.grey),
    );
  }

  void signoutMessage() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Log out'),
            content: Text('Weet je zeker dat je uit wilt loggen?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Nee'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                color: Color(0xFF0062A5),
                child: Text(
                  'Ja',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _auth.signOut();
                },
              ),
            ],
          );
        });
  }

  void changeAllItemCompleteness(List<Player> item) async {
    for (var i = 0; i < item.length; i++) {
      if (item[i].present == true) {
        await DatabaseService(uid: item[i].id).updatePlayerPresent(!item[i].present);
      }
    }
  }

  void changeItemCompleteness(Player item) async {
    await DatabaseService(uid: item.id).updatePlayerPresent(!item.present);
  }

  void goToNewItemView() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return NewPlayerView();
      }),
    );
  }

  void goToEditItemView(item) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) {
          return NewPlayerView(item: item);
        },
      ),
    );
  }

  void removeItem(Player item) async {
    await DatabaseService(uid: item.id).removePlayerData();
  }

  void _vibrate() {
    Vibration.vibrate(duration: 50, amplitude: 125);
  }
}
