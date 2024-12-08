import 'package:json_annotation/json_annotation.dart';

part 'fcm_token_dto.g.dart';

@JsonSerializable()
class FcmTokenDto {
  FcmTokenDto({required this.fcmToken});

  factory FcmTokenDto.fromJson(Map<String, Object?> json) => _$FcmTokenDtoFromJson(json);

  final String? fcmToken;

  Map<String, Object?> toJson() => _$FcmTokenDtoToJson(this);
}
