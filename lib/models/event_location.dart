import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:spotspeak_mobile/models/trace_location.dart';

part 'event_location.g.dart';

@JsonSerializable()
class EventLocation {
  const EventLocation({
    required this.id,
    required this.longitude,
    required this.latitude,
    required this.name,
    required this.isActive,
    required this.traces,
  });

  factory EventLocation.fromJson(Map<String, Object?> json) => _$EventLocationFromJson(json);

  final int id;
  final num longitude;
  final num latitude;
  final String name;
  final bool isActive;
  final List<TraceLocation> traces;

  Map<String, Object?> toJson() => _$EventLocationToJson(this);

  LatLng get latLng => LatLng(latitude.toDouble(), longitude.toDouble());
}
