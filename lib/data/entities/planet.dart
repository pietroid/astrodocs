import 'package:json_annotation/json_annotation.dart';

part 'planet.g.dart';

@JsonSerializable()
class Planet {
  final String id;
  final String name;
  final String icon;
  final int orderNumber;

  Planet({
    required this.id,
    required this.name,
    required this.icon,
    required this.orderNumber,
  });

  factory Planet.fromJson(Map<String, dynamic> json) => _$PlanetFromJson(json);

  Map<String, dynamic> toJson() => _$PlanetToJson(this);
}
