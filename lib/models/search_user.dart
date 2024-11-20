import 'package:json_annotation/json_annotation.dart';

part 'search_user.g.dart';

@JsonSerializable()
class SearchUser {
  SearchUser({required this.id, required this.username, this.profilePictureUrl});

  factory SearchUser.fromJson(Map<String, Object?> json) => _$SearchUserFromJson(json);

  final String id;
  final String username;
  final Uri? profilePictureUrl;

  Map<String, Object?> toJson() => _$SearchUserToJson(this);

  @override
  String toString() => 'SearchUser{id: $id, username: $username, profilePictureUrl: $profilePictureUrl}';
}
