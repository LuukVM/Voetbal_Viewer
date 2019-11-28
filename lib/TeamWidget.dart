import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:voetbal_viewer/New_player.dart';
import 'package:voetbal_viewer/Player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voetbal_viewer/GlobalVariable.dart';

class Team extends StatefulWidget {
  const Team({Key key}) : super(key: key);
  @override
  TeamState createState() => TeamState();
}

class TeamState extends State<Team> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    loadSharedPreferencesAndData();
    super.initState();
  }

  void loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Text(
                'sv Hillegom Zondag 11',
                key: Key('TeamWidget'),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.32,
                ),
                child: IconButton(
                  key: Key('DeselectAll'),
                  icon: Icon(Icons.loop),
                  onPressed: () => {
                    changeAllItemCompleteness(players),
                    _vibrate(),
                  },
                ),
              ),
            ],
          ),
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
        body: players.isEmpty ? emptyList() : buildListView());
  }

  Widget emptyList() {
    return Center(child: Text('Geen spelers gevonden'));
  }

  Widget buildListView() {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        height: 0.0,
        color: Colors.black,
      ),
      itemCount: players.length,
      itemBuilder: (BuildContext context, int index) {
        return buildItem(players[index], index);
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

  void changeItemCompleteness(Player item) {
    setState(() {
      item.present = !item.present;
      item.inField = false;
    });
    saveData();
  }

  void goToNewItemView() {
    // Here we are pushing the new view into the Navigator stack. By using a
    // MaterialPageRoute we get standard behaviour of a Material app, which will
    // show a back button automatically for each platform on the left top corner
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return NewPlayerView();
    })).then((title) {
      if (title != null) {
        addItem(Player(title: title));
      }
    });
  }

  void addItem(Player item) {
    // Insert an item into the top of our list, on index zero
    players.insert(0, item);
    saveData();
  }

  void goToEditItemView(item) {
    // We re-use the NewPlayerView and push it to the Navigator stack just like
    // before, but now we send the title of the item on the class constructor
    // and expect a new title to be returned so that we can edit the item
    Navigator.of(context)
        .push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) {
              return NewPlayerView(item: item);
            }))
        .then((title) {
      if (title != null) {
        editItem(item, title);
      }
    });
  }

  void editItem(Player item, String title) {
    item.title = title;
    saveData();
  }

  void removeItem(Player item) {
    players.remove(item);
    saveData();
  }

  void loadData() {
    List<String> listString = sharedPreferences.getStringList('players');
    if (listString != null) {
      players =
          listString.map((item) => Player.fromMap(json.decode(item))).toList();
      setState(() {});
    }
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
