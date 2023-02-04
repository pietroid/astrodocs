import 'package:astrodocs/data/entities/planet.dart';
import 'package:astrodocs/data/entities/position.dart';

class PlanetPosition {
  final Planet planet;
  final Position? position;

  PlanetPosition({
    required this.planet,
    this.position,
  });
}
