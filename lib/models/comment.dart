import 'package:json_annotation/json_annotation.dart';
import 'package:spotspeak_mobile/models/trace.dart';
import 'package:spotspeak_mobile/models/user.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  const Comment({
    required this.id,
    required this.author,
    required this.trace,
    required this.content,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, Object?> json) => _$CommentFromJson(json);

  final int id;
  final User author;
  final Trace trace;
  final String content;
  final DateTime createdAt;

  Map<String, Object?> toJson() => _$CommentToJson(this);
}
