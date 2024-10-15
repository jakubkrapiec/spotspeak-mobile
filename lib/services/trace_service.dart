import 'package:flutter_map/flutter_map.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:spotspeak_mobile/models/trace.dart';

@singleton
class TraceService {
  Future<Set<Trace>> getTracesFor(LatLngBounds bounds) async {
    return {
      const Trace(location: LatLng(51.11, 17.06)),
      const Trace(location: LatLng(51.112, 17.0599)),
      const Trace(location: LatLng(51.109, 17.058)),
    };
  }
}
