// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Planet _$PlanetFromJson(Map<String, dynamic> json) => Planet(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      orderNumber: json['orderNumber'] as int,
    );

Map<String, dynamic> _$PlanetToJson(Planet instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'orderNumber': instance.orderNumber,
    };
