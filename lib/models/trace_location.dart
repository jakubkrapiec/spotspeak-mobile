import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'trace_location.g.dart';

@JsonSerializable()
class TraceLocation {
  const TraceLocation(this.id, this.longitude, this.latitude);

  factory TraceLocation.fromJson(Map<String, Object?> json) => _$TraceLocationFromJson(json);

  final int id;
  final num longitude;
  final num latitude;

  Map<String, Object?> toJson() => _$TraceLocationToJson(this);

  LatLng toLatLng() => LatLng(latitude.toDouble(), longitude.toDouble());
}
