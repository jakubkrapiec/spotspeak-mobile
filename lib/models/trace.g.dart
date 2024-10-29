// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trace _$TraceFromJson(Map<String, dynamic> json) => Trace(
      id: (json['id'] as num).toInt(),
      resourceAccessUrl: json['resourceAccessUrl'] as String,
      description: json['description'] as String,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      traceTags: (json['traceTags'] as List<dynamic>)
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      latitude: json['latitude'] as num,
      longitude: json['longitude'] as num,
    );

Map<String, dynamic> _$TraceToJson(Trace instance) => <String, dynamic>{
      'id': instance.id,
      'resourceAccessUrl': instance.resourceAccessUrl,
      'description': instance.description,
      'comments': instance.comments,
      'traceTags': instance.traceTags,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
