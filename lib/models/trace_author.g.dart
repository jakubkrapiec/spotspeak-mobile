// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trace_author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TraceAuthor _$TraceAuthorFromJson(Map<String, dynamic> json) => TraceAuthor(
      id: json['id'] as String,
      username: json['username'] as String,
      profilePictureUrl: json['profilePictureUrl'] as String?,
    );

Map<String, dynamic> _$TraceAuthorToJson(TraceAuthor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'profilePictureUrl': instance.profilePictureUrl,
    };
