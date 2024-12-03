// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_mention.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentMention _$CommentMentionFromJson(Map<String, dynamic> json) =>
    CommentMention(
      mentionedUserId: json['mentionedUserId'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$CommentMentionToJson(CommentMention instance) =>
    <String, dynamic>{
      'mentionedUserId': instance.mentionedUserId,
      'username': instance.username,
    };
