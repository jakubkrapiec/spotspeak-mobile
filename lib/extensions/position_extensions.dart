import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

extension PositionExtensions on Position {
  LatLng toLatLng() => LatLng(latitude, longitude);
}
