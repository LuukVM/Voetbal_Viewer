class Player {
  String title;
  bool present;
  bool hasCar;
  bool inField;

  Player({
    this.title,
    this.present = false,
    this.hasCar = false,
    this.inField = false,
  });

  Player.fromMap(Map map)
      : title = map['title'],
        present = map['present'],
        hasCar = map['hasCar'],
        inField = map['inField'];

  Map toMap() {
    return {
      'title': title,
      'present': present,
      'hasCar': hasCar,
      'inField' : inField,
    };
  }
}
