// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventLocation _$EventLocationFromJson(Map<String, dynamic> json) =>
    EventLocation(
      id: (json['id'] as num).toInt(),
      longitude: json['longitude'] as num,
      latitude: json['latitude'] as num,
      name: json['name'] as String,
      isActive: json['isActive'] as bool,
      traces: (json['traces'] as List<dynamic>)
          .map((e) => TraceLocation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventLocationToJson(EventLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'name': instance.name,
      'isActive': instance.isActive,
      'traces': instance.traces,
    };
