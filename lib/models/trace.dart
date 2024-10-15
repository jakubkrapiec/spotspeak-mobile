import 'package:latlong2/latlong.dart';

class Trace {
  const Trace({
    required this.location,
  });

  final LatLng location;

  @override
  String toString() => 'Trace{location: $location}';
}
