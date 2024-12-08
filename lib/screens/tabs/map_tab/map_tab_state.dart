import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spotspeak_mobile/models/event_location.dart';
import 'package:spotspeak_mobile/models/trace_location.dart';

part 'map_tab_state.freezed.dart';

@freezed
class MapTabState with _$MapTabState {
  const factory MapTabState({
    required bool isAddingTrace,
    required Position? lastLocation,
    required List<TraceLocation> traces,
    required List<EventLocation> events,
  }) = _MapTabState;

  factory MapTabState.initial() => MapTabState(isAddingTrace: false, lastLocation: null, traces: [], events: []);
}
