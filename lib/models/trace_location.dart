import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:spotspeak_mobile/models/trace_type.dart';

part 'trace_location.g.dart';

@immutable
@JsonSerializable()
class TraceLocation {
  TraceLocation({
    required this.id,
    required this.longitude,
    required this.latitude,
    required this.hasDiscovered,
    required this.type,
    required DateTime createdAt,
  }) : createdAt = createdAt.subtract(const Duration(hours: 1));

  factory TraceLocation.fromJson(Map<String, Object?> json) => _$TraceLocationFromJson(json);

  final int id;
  final num longitude;
  final num latitude;
  @JsonKey(defaultValue: false)
  final bool hasDiscovered;
  final TraceType type;
  final DateTime createdAt;

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is TraceLocation && other.id == id;

  Map<String, Object?> toJson() => _$TraceLocationToJson(this);

  LatLng toLatLng() => LatLng(latitude.toDouble(), longitude.toDouble());

  double calculateDistance(LatLng currentLocation) {
    return Geolocator.distanceBetween(
      latitude.toDouble(),
      longitude.toDouble(),
      currentLocation.latitude,
      currentLocation.longitude,
    );
  }

  String convertedDistance(LatLng currentLocation) {
    final distance = calculateDistance(currentLocation);
    return distance < 1000 ? '${distance.toInt()} m' : '${(distance / 1000).toStringAsFixed(0)} km';
  }

  Duration get timeLeft => createdAt.add(Duration(days: 1)).difference(DateTime.now());

  String get iconSvgPath {
    if (hasDiscovered) {
      return switch (type) {
        TraceType.text => 'assets/trace_icons_discovered/text_trace.svg',
        TraceType.image => 'assets/trace_icons_discovered/photo_trace.svg',
        TraceType.video => 'assets/trace_icons_discovered/video_trace.svg',
      };
    }
    final randomIndex = id.hashCode % 6;
    return 'assets/trace_icons_hidden/trace_icon_hidden_$randomIndex.svg';
  }
}
