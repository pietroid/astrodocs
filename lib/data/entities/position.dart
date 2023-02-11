import 'package:json_annotation/json_annotation.dart';

part 'position.g.dart';

@JsonSerializable()
class Position {
  final String id;
  final String planetName;
  final String title;
  final String subtitle;
  final String content;

  Position({
    required this.id,
    required this.planetName,
    required this.title,
    required this.subtitle,
    required this.content,
  });

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);

  Map<String, dynamic> toJson() => _$PositionToJson(this);
}
