class Player {
  final String id;
  final String title;
  final bool present;
  final bool hasCar;
  final bool inField;
  final int fieldIndex;
  final String position;
  final String secondaryPosition;

  Player({
    this.id,
    this.title,
    this.present = false,
    this.hasCar = false,
    this.inField = false,
    this.fieldIndex,
    this.position,
    this.secondaryPosition,
  });
}
