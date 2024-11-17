import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spotspeak_mobile/models/comment_author.dart';

part 'comment.g.dart';

@immutable
@JsonSerializable()
class Comment {
  const Comment({
    required this.id,
    required this.author,
    required this.content,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, Object?> json) => _$CommentFromJson(json);

  final int id;
  final CommentAuthor author;
  final String content;
  final DateTime createdAt;

  Map<String, Object?> toJson() => _$CommentToJson(this);

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Comment && other.id == id;
  }
}
