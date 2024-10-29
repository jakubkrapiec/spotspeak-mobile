// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_trace_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddTraceDto _$AddTraceDtoFromJson(Map<String, dynamic> json) => AddTraceDto(
      (json['longitude'] as num).toDouble(),
      (json['latitude'] as num).toDouble(),
      json['description'] as String,
      (json['tagIds'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
    );

Map<String, dynamic> _$AddTraceDtoToJson(AddTraceDto instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'description': instance.description,
      'tagIds': instance.tagIds,
    };
