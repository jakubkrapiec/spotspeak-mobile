import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:spotspeak_mobile/models/trace_location.dart';

part 'event_location.g.dart';

@JsonSerializable()
class EventLocation {
  EventLocation({
    required this.id,
    required this.longitude,
    required this.latitude,
    required this.name,
    required this.isActive,
    required this.traces,
  }) : radius = traces.isEmpty
            ? 0
            : traces
                .map(
                  (trace) => Geolocator.distanceBetween(
                    latitude.toDouble(),
                    longitude.toDouble(),
                    trace.latitude.toDouble(),
                    trace.longitude.toDouble(),
                  ),
                )
                .reduce((maxDistance, distance) => maxDistance > distance ? maxDistance : distance)
                .toInt();

  factory EventLocation.fromJson(Map<String, Object?> json) => _$EventLocationFromJson(json);

  final int id;
  final num longitude;
  final num latitude;
  final String name;
  final bool isActive;
  final List<TraceLocation> traces;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final int radius;

  Map<String, Object?> toJson() => _$EventLocationToJson(this);

  LatLng get latLng => LatLng(latitude.toDouble(), longitude.toDouble());
}
