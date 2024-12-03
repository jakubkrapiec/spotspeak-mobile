// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_comment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCommentDto _$AddCommentDtoFromJson(Map<String, dynamic> json) =>
    AddCommentDto(
      json['content'] as String,
      (json['mentions'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AddCommentDtoToJson(AddCommentDto instance) =>
    <String, dynamic>{
      'content': instance.content,
      'mentions': instance.mentions,
    };
