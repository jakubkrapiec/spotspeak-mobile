import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:spotspeak_mobile/models/trace_type.dart';

part 'trace_location.g.dart';

@JsonSerializable()
class TraceLocation {
  // ignore: avoid_positional_boolean_parameters
  const TraceLocation(this.id, this.longitude, this.latitude, this.hasDiscovered, this.type);

  factory TraceLocation.fromJson(Map<String, Object?> json) => _$TraceLocationFromJson(json);

  final int id;
  final num longitude;
  final num latitude;
  final bool hasDiscovered;
  final TraceType type;

  Map<String, Object?> toJson() => _$TraceLocationToJson(this);

  LatLng toLatLng() => LatLng(latitude.toDouble(), longitude.toDouble());
}