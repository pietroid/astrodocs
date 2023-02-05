// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
      id: json['id'] as String,
      planet: Planet.fromJson(json['planet'] as Map<String, dynamic>),
      name: json['name'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      'id': instance.id,
      'planet': instance.planet,
      'name': instance.name,
      'content': instance.content,
    };
