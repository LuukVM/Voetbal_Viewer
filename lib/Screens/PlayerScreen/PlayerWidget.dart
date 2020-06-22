import 'package:flutter/material.dart';
import 'package:voetbal_viewer/Persons/field.dart';
import 'package:voetbal_viewer/Screens/PlayerScreen/PlayerField.dart';
import 'package:voetbal_viewer/Services/database.dart';

class PlayerPage extends StatefulWidget {
  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Field>(
      stream: DatabaseService(uid: '1').field,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF0062A5),
            title: Text(
              'Opstelling',
              style: TextStyle(fontSize: 25),
            ),
            centerTitle: true,
          ),
          body: Stack(
            children: <Widget>[
              Center(
                child: new Image.asset(
                  'fonts/field.png',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.fill,
                ),
              ),
              PlayerField(fieldSetup_: snapshot.data.fieldSetup,),
            ],
          ),
        );
      }
    );
  }
}
