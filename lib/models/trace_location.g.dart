// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trace_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TraceLocation _$TraceLocationFromJson(Map<String, dynamic> json) =>
    TraceLocation(
      id: (json['id'] as num).toInt(),
      longitude: json['longitude'] as num,
      latitude: json['latitude'] as num,
      hasDiscovered: json['hasDiscovered'] as bool? ?? false,
      type: $enumDecode(_$TraceTypeEnumMap, json['type']),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$TraceLocationToJson(TraceLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'hasDiscovered': instance.hasDiscovered,
      'type': _$TraceTypeEnumMap[instance.type]!,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$TraceTypeEnumMap = {
  TraceType.text: 'TEXTONLY',
  TraceType.image: 'PHOTO',
  TraceType.video: 'VIDEO',
};
