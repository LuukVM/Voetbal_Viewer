import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:voetbal_viewer/Player.dart';

class NewPlayerView extends StatefulWidget {
  final Player item;

  NewPlayerView({this.item});

  @override
  _NewPlayerViewState createState() => _NewPlayerViewState();
}

class _NewPlayerViewState extends State<NewPlayerView> {
  TextEditingController titleController;
  bool _validate = false;

  @override
  void initState() {
    super.initState();
    titleController = new TextEditingController(
        text: widget.item != null ? widget.item.title : null);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: (Text(
        widget.item != null ? 'Speler aanpassen' : 'Nieuwe speler',
        key: Key('new-item-title'),
      )),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: titleController,
              autofocus: true,
              //onSubmitted: (value) => value.isEmpty ?  : submit(),
              decoration: InputDecoration(
                  labelText: 'Naam van de speler',
                  errorText: _validate ? 'Vul een naam in aub' : null,
                  fillColor: Color(0xFF0062A5)),
              textCapitalization: TextCapitalization.words,
            ),
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
                setState((){
                  titleController.text.isEmpty ? _validate = true : _validate = false;
                }),
                _validate ? null : submit(),
                Vibration.vibrate(duration: 50, amplitude: 125),
              },
            )
          ],
        ),
      ),
    );
  }

  void submit() {
    Navigator.of(context).pop(titleController.text);
  }
}
