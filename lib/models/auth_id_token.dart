import 'package:json_annotation/json_annotation.dart';

part 'auth_id_token.g.dart';

@JsonSerializable()
class AuthIdToken {
  const AuthIdToken({
    required this.email,
    required this.exp,
    required this.iat,
    required this.iss,
    required this.sub,
    required this.aud,
    this.authTime,
  });

  factory AuthIdToken.fromJson(Map<String, dynamic> json) => _$AuthIdTokenFromJson(json);

  final String email;

  final String iss;
  final String sub;
  final String aud;

  final int exp;
  final int iat;

  final int? authTime;

  Map<String, dynamic> toJson() => _$AuthIdTokenToJson(this);
}
