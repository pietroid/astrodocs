import 'package:astrodocs/data/entities/planet_position.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document.g.dart';

@JsonSerializable()
class Document {
  final String id;
  final String personName;
  final String birthday;
  final DateTime dateCreated;
  final List<PlanetPosition> planetPositions;
  String? lastFileId;

  Document({
    required this.id,
    required this.personName,
    required this.birthday,
    required this.dateCreated,
    required this.planetPositions,
    this.lastFileId,
  });

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentToJson(this);
}
