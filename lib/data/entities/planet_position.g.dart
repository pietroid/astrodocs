// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planet_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanetPosition _$PlanetPositionFromJson(Map<String, dynamic> json) =>
    PlanetPosition(
      planet: Planet.fromJson(json['planet'] as Map<String, dynamic>),
      position: json['position'] == null
          ? null
          : Position.fromJson(json['position'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlanetPositionToJson(PlanetPosition instance) =>
    <String, dynamic>{
      'planet': instance.planet,
      'position': instance.position,
    };
