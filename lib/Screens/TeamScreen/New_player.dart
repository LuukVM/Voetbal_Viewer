import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:vibration/vibration.dart';
import 'package:voetbal_viewer/Persons/Player.dart';
import 'package:voetbal_viewer/Services/database.dart';
import 'package:voetbal_viewer/Shared/constants.dart';
import 'package:voetbal_viewer/Shared/loading.dart';

class NewPlayerView extends StatefulWidget {
  final Player item;

  NewPlayerView({this.item});

  @override
  _NewPlayerViewState createState() => _NewPlayerViewState();
}

class _NewPlayerViewState extends State<NewPlayerView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController;
  String name = '';
  String position = null;
  String secondPosition = null;
  bool loading = false;

  List<DropdownMenuItem<String>> positionsList = [
    DropdownMenuItem(child: Text('Keeper'), value: 'Keeper'),
    DropdownMenuItem(child: Text('Verdediger'), value: 'Verdediger'),
    DropdownMenuItem(child: Text('Middenvelder'), value: 'Middenvelder'),
    DropdownMenuItem(child: Text('Aanvaller'), value: 'Aanvaller'),
  ];

  var uuid = new Uuid();

  @override
  void initState() {
    super.initState();
    if(widget.item != null){
      name = widget.item.title;
      position = widget.item.position;
      secondPosition = widget.item.secondaryPosition;
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: (Text(
          widget.item != null ? 'Speler aanpassen' : 'Nieuwe speler',
          key: Key('new-item-title'),
        )),
        backgroundColor: Color(0xFF0062A5),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 100),
              TextFormField(
                  //initialValue: widget.item != null ? widget.item.title : null,
                  initialValue: name,
                  decoration: textInputDecoration.copyWith(hintText: 'Naam'),
                  validator: (val) => val.isEmpty ? 'Vul een naam in' : null,
                  onChanged: (val) {
                    setState(() => name = val);
                  }),
              SizedBox(
                height: 14.0,
              ),
              DropdownButtonFormField(
                  //value: widget.item != null ? widget.item.position : position,
                  value: position,
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Positie', labelText: 'Positie'),
                  items: positionsList,
                  validator: (val) {
                    if (val == null) {
                      return 'Vul een positie in';
                    } else {
                      null;
                    }
                  },
                  onChanged: (val) {
                    setState(() => position = val);
                  }),
              SizedBox(
                height: 14.0,
              ),
              DropdownButtonFormField(
                  //value: widget.item != null ? widget.item.secondaryPosition : secondPosition,
                  value: secondPosition,
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Tweede positie', labelText: 'Tweede positie'),
                  items: positionsList,
                  validator: (val) {
                    if (val == null) {
                      return 'Vul een tweede positie in';
                    } else {
                      null;
                    }
                  },
                  onChanged: (val) {
                    setState(() => secondPosition = val);
                  }),
              SizedBox(
                height: 14.0,
              ),
              RaisedButton(
                color: Color(0xFF0062A5),
                child: Text(
                  'Opslaan',
                  style: TextStyle(
                      color: Theme.of(context).primaryTextTheme.title.color),
                ),
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                onPressed: () => {
                  if (_formKey.currentState.validate())
                    {
                      setState(() => loading = true),
                      Vibration.vibrate(duration: 50, amplitude: 125),
                    widget.item != null ? editUser() : submitUser(),
                    }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void submitUser() async {
    String id = uuid.v1();
    await DatabaseService(uid: id)
        .updatePlayerData(id, name, false, false, false, null, position, secondPosition);
    Navigator.of(context).pop();
  }

  void editUser() async {
    await DatabaseService(uid: widget.item.id).updatePlayerData(widget.item.id, name, false, false, false, null, position, secondPosition);
    Navigator.of(context).pop();
  }
}
