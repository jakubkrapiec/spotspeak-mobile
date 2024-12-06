// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trace _$TraceFromJson(Map<String, dynamic> json) => Trace(
      id: (json['id'] as num).toInt(),
      resourceAccessUrl: json['resourceAccessUrl'] as String?,
      description: json['description'] as String,
      comments: (json['comments'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      latitude: json['latitude'] as num,
      longitude: json['longitude'] as num,
      createdAt: DateTime.parse(json['createdAt'] as String),
      author: ContentAuthor.fromJson(json['author'] as Map<String, dynamic>),
      type: $enumDecode(_$TraceTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$TraceToJson(Trace instance) => <String, dynamic>{
      'id': instance.id,
      'resourceAccessUrl': instance.resourceAccessUrl,
      'description': instance.description,
      'comments': instance.comments,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'createdAt': instance.createdAt.toIso8601String(),
      'author': instance.author,
      'type': _$TraceTypeEnumMap[instance.type]!,
    };

const _$TraceTypeEnumMap = {
  TraceType.text: 'TEXTONLY',
  TraceType.image: 'PHOTO',
  TraceType.video: 'VIDEO',
};
