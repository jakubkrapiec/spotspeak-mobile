// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_challenge_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordChallengeDto _$PasswordChallengeDtoFromJson(
        Map<String, dynamic> json) =>
    PasswordChallengeDto(
      DateTime.parse(json['issuedAt'] as String),
      json['issuedFor'] as String,
      json['token'] as String,
    );

Map<String, dynamic> _$PasswordChallengeDtoToJson(
        PasswordChallengeDto instance) =>
    <String, dynamic>{
      'issuedAt': instance.issuedAt.toIso8601String(),
      'issuedFor': instance.issuedFor,
      'token': instance.token,
    };
