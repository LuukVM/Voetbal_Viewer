import 'package:flutter/material.dart';
import 'package:voetbal_viewer/FieldWidget.dart';
import 'package:voetbal_viewer/football_icons.dart';
import 'TeamWidget.dart';
import 'package:voetbal_viewer/PresentWidget.dart';
import 'package:voetbal_viewer/GlobalVariable.dart';
import 'package:voetbal_viewer/Player.dart';

class DraggableWidget extends StatefulWidget {
  const DraggableWidget({Key key}) : super(key: key);
  @override
  DraggableWidgetState createState() => DraggableWidgetState();
}


class DraggableWidgetState extends State<DraggableWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: players.length,
      itemBuilder: (BuildContext context, int index) {
        if (players[index].present == true && players[index].inField == false) {
          return getDraggable(players[index], index);
        } else {
          return emptyList();
        }
      },
    );
  }

  Widget emptyList(){
    return Center();
  }


  Widget getDraggable(item, index) {
    return ListTile(title: Draggable<Player>(
      data: item,
      child: buildContainer(item, index),
      childWhenDragging: buildDraggingContainter(item, index),
      feedback: Container(color: Colors.grey),
    ),
    );
  }

  Widget buildContainer(item, index) {
    return Container(
      child: Text(
        item.title,
        key: Key('item-$index'),
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget buildDraggingContainter(item, index){
    return Container(
      child: Text(
        item.title,
        key: Key('item-$index'),
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
      ),
      color: Color(0xFF0062A5).withOpacity(0.5),
    );
  }
}
