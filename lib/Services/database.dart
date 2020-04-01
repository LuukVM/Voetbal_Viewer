import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voetbal_viewer/Persons/Player.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference playerInstance =
      Firestore.instance.collection('player');
  final CollectionReference user = Firestore.instance.collection('user');

  Future updateUserData(String name) async {
    return await user.document(uid).setData({
      'name': name,
    });
  }

  Future updatePlayerData(
      String id,
      String name,
      bool present,
      bool inField,
      bool hasCar,
      dynamic fieldIndex,
      String position,
      String secondaryPosition) async {
    return await playerInstance.document(uid).setData({
      'id': id,
      'name': name,
      'present': present,
      'hasCar': hasCar,
      'inField': inField,
      'fieldIndex': fieldIndex,
      'position': position,
      'secondaryPosition': secondaryPosition,
    });
  }

  Future removePlayerData() async {
    return await playerInstance.document(uid).delete();
  }

  Future updatePlayerPresent(bool present) async {
    if (present == true) {
      return await playerInstance.document(uid).updateData({
        'present': present,
      });
    }
    else{
      return await playerInstance.document(uid).updateData({
        'inField': present,
        'present': present,
        'fieldIndex': null,
      });
    }
  }

  Future updatePlayerInField(bool inField) async {
    if (inField == true) {
      return await playerInstance.document(uid).updateData({
        'inField': inField,
      });
    } else {
      return await playerInstance.document(uid).updateData({
        'inField': inField,
        'fieldIndex': null,
      });
    }
  }

  Future updatePlayerHasCar(bool hasCar) async{
    return await playerInstance.document(uid).updateData({
      'hasCar': hasCar,
    });
  }

  Future updatePlayerFieldIndex(int index) async{
    return await playerInstance.document(uid).updateData({
      'fieldIndex': index,
    });
  }

  // player list from snapshot
  List<Player> _playerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Player(
        id: doc.data['id'] ?? '',
        title: doc.data['name'] ?? '',
        present: doc.data['present'] ?? false,
        hasCar: doc.data['hasCar'] ?? false,
        inField: doc.data['inField'] ?? false,
        fieldIndex: doc.data['fieldIndex'] ?? null,
        position: doc.data['position'] ?? '',
        secondaryPosition: doc.data['secondaryPosition'] ?? '',
      );
    }).toList();
  }

  // get player stream
  Stream<List<Player>> get players {
    return playerInstance.snapshots().map(_playerListFromSnapshot);
  }
}
