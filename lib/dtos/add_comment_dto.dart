import 'package:json_annotation/json_annotation.dart';

part 'add_comment_dto.g.dart';

@JsonSerializable()
class AddCommentDto {
  AddCommentDto(this.content);

  factory AddCommentDto.fromJson(Map<String, Object?> json) => _$AddCommentDtoFromJson(json);

  final String content;

  Map<String, Object?> toJson() => _$AddCommentDtoToJson(this);
}
