import 'package:astrodocs/data/entities/planet.dart';
import 'package:json_annotation/json_annotation.dart';

part 'position.g.dart';

@JsonSerializable()
class Position {
  final String id;
  final String planetName;
  final String name;
  final String content;

  Position({
    required this.id,
    required this.planetName,
    required this.name,
    required this.content,
  });

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);

  Map<String, dynamic> toJson() => _$PositionToJson(this);
}
