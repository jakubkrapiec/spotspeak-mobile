// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: (json['id'] as num).toInt(),
      author: User.fromJson(json['author'] as Map<String, dynamic>),
      trace: Trace.fromJson(json['trace'] as Map<String, dynamic>),
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'trace': instance.trace,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
    };
