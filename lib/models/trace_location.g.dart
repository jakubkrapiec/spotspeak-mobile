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
    );

Map<String, dynamic> _$TraceLocationToJson(TraceLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
