import 'package:astrodocs/data/entities/planet_position.dart';

class Document {
  final String id;
  final String personName;
  final String birthday;
  final DateTime dateCreated;
  final List<PlanetPosition> planetPositions;

  Document({
    required this.id,
    required this.personName,
    required this.birthday,
    required this.dateCreated,
    required this.planetPositions,
  });
}
