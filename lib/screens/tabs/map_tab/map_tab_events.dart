import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/new_trace_dialog.dart';

abstract class MapTabEvent {
  const MapTabEvent();
}

class AddTraceEvent extends MapTabEvent {
  AddTraceEvent({required this.location, required this.traceDialogResult});

  final LatLng location;
  final TraceDialogResult traceDialogResult;
}

class RequestMapUpdateEvent extends MapTabEvent {
  const RequestMapUpdateEvent({required this.bounds});

  final LatLngBounds bounds;
}

class UpdateLocationEvent extends MapTabEvent {
  const UpdateLocationEvent(this.location);

  final Position location;
}
