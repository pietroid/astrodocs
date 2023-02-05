import 'package:astrodocs/data/entities/planet.dart';
import 'package:astrodocs/data/entities/position.dart';
import 'package:json_annotation/json_annotation.dart';

part 'planet_position.g.dart';

@JsonSerializable()
class PlanetPosition {
  final Planet planet;
  final Position? position;

  PlanetPosition({
    required this.planet,
    this.position,
  });

  factory PlanetPosition.fromJson(Map<String, dynamic> json) =>
      _$PlanetPositionFromJson(json);

  Map<String, dynamic> toJson() => _$PlanetPositionToJson(this);
}
