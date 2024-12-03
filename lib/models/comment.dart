import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spotspeak_mobile/models/comment_mention.dart';
import 'package:spotspeak_mobile/models/content_author.dart';

part 'comment.g.dart';

@immutable
@JsonSerializable()
class Comment {
  const Comment({
    required this.commentId,
    required this.author,
    required this.content,
    required this.createdAt,
    required this.mentions,
  });

  factory Comment.fromJson(Map<String, Object?> json) => _$CommentFromJson(json);

  final int commentId;
  final ContentAuthor author;
  final String content;
  final DateTime createdAt;
  final List<CommentMention> mentions;

  Map<String, Object?> toJson() => _$CommentToJson(this);

  @override
  int get hashCode => commentId.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Comment && other.commentId == commentId;
  }
}
