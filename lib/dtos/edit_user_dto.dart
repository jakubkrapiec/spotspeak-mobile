import 'package:json_annotation/json_annotation.dart';

part 'edit_user_dto.g.dart';

@JsonSerializable()
class EditUserDto {
  EditUserDto({this.passwordChallengeToken, this.firstName, this.lastName, this.email, this.username});

  factory EditUserDto.fromJson(Map<String, Object?> json) => _$EditUserDtoFromJson(json);

  final String? passwordChallengeToken;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? username;

  Map<String, Object?> toJson() => _$EditUserDtoToJson(this);
}
