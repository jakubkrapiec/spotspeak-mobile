import 'package:json_annotation/json_annotation.dart';

part 'comment_mention.g.dart';

@JsonSerializable()
class CommentMention {
  const CommentMention({
    required this.mentionedUserId,
    required this.username,
  });

  factory CommentMention.fromJson(Map<String, Object?> json) => _$CommentMentionFromJson(json);

  final String mentionedUserId;
  final String username;

  Map<String, Object?> toJson() => _$CommentMentionToJson(this);
}
