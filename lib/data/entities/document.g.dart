// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) => Document(
      id: json['id'] as String,
      personName: json['personName'] as String,
      birthday: json['birthday'] as String,
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      planetPositions: (json['planetPositions'] as List<dynamic>)
          .map((e) => PlanetPosition.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastFileId: json['lastFileId'] as String?,
    );

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'id': instance.id,
      'personName': instance.personName,
      'birthday': instance.birthday,
      'dateCreated': instance.dateCreated.toIso8601String(),
      'planetPositions': instance.planetPositions,
      'lastFileId': instance.lastFileId,
    };
