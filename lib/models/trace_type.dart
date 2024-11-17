import 'package:json_annotation/json_annotation.dart';

enum TraceType {
  @JsonValue('TEXTONLY')
  text,
  @JsonValue('PHOTO')
  image,
  @JsonValue('VIDEO')
  video,
}
