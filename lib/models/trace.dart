import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:spotspeak_mobile/models/comment.dart';
import 'package:spotspeak_mobile/models/content_author.dart';
import 'package:spotspeak_mobile/models/tag.dart';
import 'package:spotspeak_mobile/models/trace_type.dart';

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
    required this.createdAt,
    required this.author,
    required this.type,
  });

  factory Trace.fromJson(Map<String, Object?> json) => _$TraceFromJson(json);

  final int id;
  final String? resourceAccessUrl;
  final String description;
  final List<Comment> comments;
  final List<Tag> traceTags;
  final num latitude;
  final num longitude;
  final DateTime createdAt;
  final ContentAuthor author;
  final TraceType type;

  LatLng get location => LatLng(latitude.toDouble(), longitude.toDouble());

  Map<String, Object?> toJson() => _$TraceToJson(this);

  Duration get timeLeft => createdAt.add(Duration(days: 1)).difference(DateTime.now());
}
