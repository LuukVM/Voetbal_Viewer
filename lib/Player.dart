class Player {
  String title;
  bool present;
  bool hasCar;
  bool inField;
  int fieldIndex;

  Player({
    this.title,
    this.present = false,
    this.hasCar = false,
    this.inField = false,
    this.fieldIndex,
  });

  Player.fromMap(Map map)
      : title = map['title'],
        present = map['present'],
        hasCar = map['hasCar'],
        inField = map['inField'],
        fieldIndex = map['fieldIndex'];

  Map toMap() {
    return {
      'title': title,
      'present': present,
      'hasCar': hasCar,
      'inField' : inField,
      'fieldIndex' : fieldIndex,
    };
  }
}
