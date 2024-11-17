import 'package:json_annotation/json_annotation.dart';

part 'add_trace_dto.g.dart';

@JsonSerializable()
class AddTraceDto {
  AddTraceDto(this.longitude, this.latitude, this.description, this.tagIds);

  factory AddTraceDto.fromJson(Map<String, Object?> json) => _$AddTraceDtoFromJson(json);

  final double longitude;
  final double latitude;
  final String description;
  final List<int> tagIds;

  Map<String, Object?> toJson() => _$AddTraceDtoToJson(this);
}
