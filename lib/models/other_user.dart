import 'package:json_annotation/json_annotation.dart';
import 'package:spotspeak_mobile/models/content_author.dart';
import 'package:spotspeak_mobile/models/search_user.dart';

part 'other_user.g.dart';

@JsonSerializable()
class OtherUser implements ContentAuthor, SearchUser {
  const OtherUser({
    required this.id,
    required this.username,
    this.totalPoints,
    this.profilePictureUrl,
  });

  factory OtherUser.fromJson(Map<String, Object?> json) => _$OtherUserFromJson(json);

  @override
  final String id;

  @override
  final String username;
  final int? totalPoints;

  @override
  final Uri? profilePictureUrl;

  @override
  Map<String, Object?> toJson() => _$OtherUserToJson(this);
}
