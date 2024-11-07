import 'package:json_annotation/json_annotation.dart';

part 'update_password_dto.g.dart';

@JsonSerializable()
class UpdatePasswordDto {
  UpdatePasswordDto(this.currentPassword, this.newPassword);

  factory UpdatePasswordDto.fromJson(Map<String, Object?> json) => _$UpdatePasswordDtoFromJson(json);

  final String currentPassword;
  final String newPassword;

  Map<String, Object?> toJson() => _$UpdatePasswordDtoToJson(this);
}
