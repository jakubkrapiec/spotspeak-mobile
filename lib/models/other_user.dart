import 'package:json_annotation/json_annotation.dart';

part 'other_user.g.dart';

@JsonSerializable()
class OtherUser {
  const OtherUser({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePictureUrl,
  });

  factory OtherUser.fromJson(Map<String, Object?> json) => _$OtherUserFromJson(json);

  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final Uri? profilePictureUrl;

  Map<String, Object?> toJson() => _$OtherUserToJson(this);
}
