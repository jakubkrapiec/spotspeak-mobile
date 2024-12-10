import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:spotspeak_mobile/models/comment.dart';
import 'package:spotspeak_mobile/models/content_author.dart';
import 'package:spotspeak_mobile/models/trace_type.dart';

part 'trace.g.dart';

@JsonSerializable()
class Trace {
  Trace({
    required this.id,
    required this.resourceAccessUrl,
    required this.description,
    required this.comments,
    required this.latitude,
    required this.longitude,
    required DateTime createdAt,
    required this.author,
    required this.type,
  }) : createdAt = createdAt.subtract(const Duration(hours: 1));

  factory Trace.fromJson(Map<String, Object?> json) => _$TraceFromJson(json);

  final int id;
  final Uri? resourceAccessUrl;
  final String description;
  final List<Comment> comments;
  final num latitude;
  final num longitude;
  final DateTime createdAt;
  final ContentAuthor author;
  final TraceType type;

  LatLng toLatLng() => LatLng(latitude.toDouble(), longitude.toDouble());

  bool get isActive => timeLeft > Duration.zero;

  double calculateDistance(LatLng currentLocation) => Geolocator.distanceBetween(
        latitude.toDouble(),
        longitude.toDouble(),
        currentLocation.latitude,
        currentLocation.longitude,
      );

  String convertedDistance(LatLng currentLocation) {
    final distance = calculateDistance(currentLocation);
    return distance < 1000 ? '${distance.toInt()} m' : '${(distance / 1000).toStringAsFixed(0)} km';
  }

  Map<String, Object?> toJson() => _$TraceToJson(this);

  Duration get timeLeft => createdAt.add(Duration(days: 1)).difference(DateTime.now());
}
