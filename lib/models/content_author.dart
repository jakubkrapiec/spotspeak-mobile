import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'content_author.g.dart';

@immutable
@JsonSerializable()
class ContentAuthor {
  const ContentAuthor({
    required this.id,
    required this.username,
    required this.profilePictureUrl,
  });

  factory ContentAuthor.fromJson(Map<String, Object?> json) => _$ContentAuthorFromJson(json);

  final String id;
  final String username;
  final Uri? profilePictureUrl;

  Map<String, Object?> toJson() => _$ContentAuthorToJson(this);

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ContentAuthor && other.id == id;
  }
}
