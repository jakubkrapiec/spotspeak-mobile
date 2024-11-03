import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.profilePictureUrl,
  });

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);

  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String? profilePictureUrl;

  Map<String, Object?> toJson() => _$UserToJson(this);
}
