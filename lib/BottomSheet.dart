import 'package:flutter/material.dart';
import 'package:voetbal_viewer/GlobalVariable.dart';
import 'package:voetbal_viewer/Player.dart';

class ConversationBottomSheet extends StatefulWidget {
  const ConversationBottomSheet({Key key}) : super(key: key);
  @override
  _ConversationBottomSheetState createState() =>
      _ConversationBottomSheetState();
}

class _ConversationBottomSheetState extends State<ConversationBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.blue,
           height: 200,       
          child:            
            PageView.builder(
              
             
                 itemCount: players.length,
                 itemBuilder: (BuildContext context, int index) {
                  if (players[index].present == true &&
                      players[index].inField == false) {
                    return getDraggable(players[index], index);
                  } else {
                    return emptyList();
                  }
                })
          
        ),
      ),
    );
  }

  Widget emptyList() {
    return Center();
  }

  Widget getDraggable(item, index) {
    return Container(
      padding: EdgeInsets.only(top: 50),
      // height: 70.0,
      // width: 70.0,
      child: Draggable<Player>(
        data: item,
        child: buildContainer(item, index),
        childWhenDragging: Container(color: Colors.grey),
        feedback: buildDraggingContainter(item, index),
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

  Widget buildDraggingContainter(item, index) {
    return Container(
      child: Text(
        item.title,
        key: Key('item-$index'),
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
      ),
      color: Color(0xFF0062A5).withOpacity(0.7),
    );
  }
}
