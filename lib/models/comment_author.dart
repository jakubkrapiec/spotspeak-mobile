import 'package:json_annotation/json_annotation.dart';

part 'comment_author.g.dart';

@JsonSerializable()
class CommentAuthor {
  const CommentAuthor({required this.id, required this.username, this.profilePictureUrl});

  factory CommentAuthor.fromJson(Map<String, Object?> json) => _$CommentAuthorFromJson(json);

  final String id;
  final String username;
  final String? profilePictureUrl;

  Map<String, Object?> toJson() => _$CommentAuthorToJson(this);
}
