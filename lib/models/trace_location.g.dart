// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trace_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TraceLocation _$TraceLocationFromJson(Map<String, dynamic> json) =>
    TraceLocation(
      (json['id'] as num).toInt(),
      json['longitude'] as num,
      json['latitude'] as num,
      json['hasDiscovered'] as bool,
      $enumDecode(_$TraceTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$TraceLocationToJson(TraceLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'hasDiscovered': instance.hasDiscovered,
      'type': _$TraceTypeEnumMap[instance.type]!,
    };

const _$TraceTypeEnumMap = {
  TraceType.text: 'TEXTONLY',
  TraceType.image: 'PHOTO',
  TraceType.video: 'VIDEO',
};
