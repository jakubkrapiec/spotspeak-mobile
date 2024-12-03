// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      commentId: (json['commentId'] as num).toInt(),
      author: ContentAuthor.fromJson(json['author'] as Map<String, dynamic>),
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      mentions: (json['mentions'] as List<dynamic>)
          .map((e) => CommentMention.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'commentId': instance.commentId,
      'author': instance.author,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'mentions': instance.mentions,
    };
