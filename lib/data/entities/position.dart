import 'package:astrodocs/data/entities/planet.dart';

class Position {
  final String id;
  final Planet planet;
  final String name;
  final String content;

  Position({
    required this.id,
    required this.planet,
    required this.name,
    required this.content,
  });
}
