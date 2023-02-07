import 'package:json_annotation/json_annotation.dart';

part 'planet.g.dart';

@JsonSerializable()
class Planet {
  final String id;
  final String name;
  final String icon;

  Planet({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory Planet.fromJson(Map<String, dynamic> json) => _$PlanetFromJson(json);

  Map<String, dynamic> toJson() => _$PlanetToJson(this);
}
