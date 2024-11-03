import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:spotspeak_mobile/models/comment.dart';
import 'package:spotspeak_mobile/models/tag.dart';

part 'trace.g.dart';

@JsonSerializable()
class Trace {
  const Trace({
    required this.id,
    required this.resourceAccessUrl,
    required this.description,
    required this.comments,
    required this.traceTags,
    required this.latitude,
    required this.longitude,
  });

  factory Trace.fromJson(Map<String, Object?> json) => _$TraceFromJson(json);

  final int id;
  final String? resourceAccessUrl;
  final String description;
  final List<Comment>? comments;
  final List<Tag> traceTags;
  final num latitude;
  final num longitude;

  LatLng get location => LatLng(latitude.toDouble(), longitude.toDouble());

  Map<String, Object?> toJson() => _$TraceToJson(this);
}
