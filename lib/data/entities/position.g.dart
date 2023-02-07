// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
      id: json['id'] as String,
      planetName: json['planetName'] as String,
      name: json['name'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      'id': instance.id,
      'planetName': instance.planetName,
      'name': instance.name,
      'content': instance.content,
    };
