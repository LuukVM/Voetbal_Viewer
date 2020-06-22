import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';
import 'package:voetbal_viewer/Persons/Player.dart';
import 'package:voetbal_viewer/Services/database.dart';
import 'package:voetbal_viewer/Shared/loading.dart';

class Present extends StatefulWidget {
  const Present({Key key}) : super(key: key);
  @override
  PresentState createState() => PresentState();
}

class PresentState extends State<Present> with SingleTickerProviderStateMixin {
  List<Player> presentPlayers = new List();
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dbPlayers = Provider.of<List<Player>>(context) ?? [];
    presentPlayers = dbPlayers.where((x) => x.present).toList();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Aanwezige spelers : ' + presentPlayers.length.toString(),
            key: Key('PresentWidget'),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.loop),
                onPressed: () => {
                      changeAllItemCompleteness(dbPlayers),
                      _vibrate(),
                    }),
          ],
          backgroundColor: Color(0xFF0062A5),
        ),
        body: loading ? Loading() : (presentPlayers.isEmpty
            ? emptyList()
            : buildListView(presentPlayers)));
  }

  Widget buildListView(List _dbPlayers) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        height: 0.0,
        color: Colors.black,
      ),
      itemCount: _dbPlayers.length,
      itemBuilder: (BuildContext context, int index) {
        return buildListTile(_dbPlayers[index], index);
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

  void changeAllItemCompleteness(List<Player> item) async {
    for (var i = 0; i < item.length; i++) {
            setState(() => loading = true);
      if (item[i].present == true) {
        await DatabaseService(uid: item[i].id).updatePlayerPresent(!item[i].present);
      }
    }
    setState(() => loading = false);
  }

  void changeItemCompleteness(Player item) async {
    await DatabaseService(uid: item.id).updatePlayerPresent(!item.present);
  }

  void setCarState(Player item) async {
    await DatabaseService(uid: item.id).updatePlayerHasCar(!item.hasCar);
  }

  void _vibrate() {
    Vibration.vibrate(duration: 50, amplitude: 125);
  }
}
