import 'package:json_annotation/json_annotation.dart';

part 'add_comment_dto.g.dart';

@JsonSerializable()
class AddCommentDto {
  AddCommentDto(this.content, this.mentions);

  factory AddCommentDto.fromJson(Map<String, Object?> json) => _$AddCommentDtoFromJson(json);

  final String content;
  final List<String> mentions;

  Map<String, Object?> toJson() => _$AddCommentDtoToJson(this);
}
