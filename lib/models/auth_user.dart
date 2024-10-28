import 'package:json_annotation/json_annotation.dart';

part 'auth_user.g.dart';

@JsonSerializable()
class AuthUser {
  const AuthUser({required this.sub, required this.name, required this.email});

  factory AuthUser.fromJson(Map<String, dynamic> json) => _$AuthUserFromJson(json);

  String get id => sub;
  final String sub;

  final String name;
  final String email;

  Map<String, dynamic> toJson() => _$AuthUserToJson(this);
}
