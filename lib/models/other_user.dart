import 'package:json_annotation/json_annotation.dart';

part 'other_user.g.dart';

@JsonSerializable()
class OtherUser {
  const OtherUser({
    required this.id,
    required this.username,
    this.profilePictureUrl,
  });

  factory OtherUser.fromJson(Map<String, Object?> json) => _$OtherUserFromJson(json);

  final String id;
  final String username;
  final String? profilePictureUrl;

  Map<String, Object?> toJson() => _$OtherUserToJson(this);
}
