import 'package:json_annotation/json_annotation.dart';

part 'password_challenge_dto.g.dart';

@JsonSerializable()
class PasswordChallengeDto {
  PasswordChallengeDto(this.issuedAt, this.issuedFor, this.token);

  factory PasswordChallengeDto.fromJson(Map<String, Object?> json) => _$PasswordChallengeDtoFromJson(json);

  final DateTime issuedAt;
  final String issuedFor;
  final String token;

  Map<String, Object?> toJson() => _$PasswordChallengeDtoToJson(this);
}
