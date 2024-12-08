import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:side_effect_bloc/side_effect_bloc.dart';
import 'package:spotspeak_mobile/dtos/add_trace_dto.dart';
import 'package:spotspeak_mobile/models/event_location.dart';
import 'package:spotspeak_mobile/models/trace_location.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/map_tab_events.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/map_tab_side_effect.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/map_tab_state.dart';
import 'package:spotspeak_mobile/services/event_service.dart';
import 'package:spotspeak_mobile/services/trace_service.dart';

@injectable
class MapTabBloc extends Bloc<MapTabEvent, MapTabState>
    with SideEffectBlocMixin<MapTabEvent, MapTabState, MapTabSideEffect> {
  MapTabBloc(this._traceService, this._eventService) : super(MapTabState.initial()) {
    on<AddTraceEvent>(_onAddTraceEvent);
    on<RequestMapUpdateEvent>(_onRequestMapUpdateEvent);
    on<UpdateLocationEvent>(_onUpdateLocationEvent);
  }

  final StreamController<void> _refreshPanelController = StreamController<void>.broadcast();
  StreamSubscription<Position>? _locationStreamSubscription;

  @override
  Future<void> close() async {
    await Future.wait<void>([
      _refreshPanelController.close(),
      if (_locationStreamSubscription != null) _locationStreamSubscription!.cancel(),
    ]);
    await super.close();
  }

  Future<void> _onAddTraceEvent(AddTraceEvent event, Emitter<MapTabState> emit) async {
    emit(state.copyWith(isAddingTrace: true));
    final dto = AddTraceDto(event.location.longitude, event.location.latitude, event.traceDialogResult.description, []);

    try {
      await _traceService.addTrace(event.traceDialogResult.media, dto);
      _refreshPanelController.add(null);
      produceSideEffect(const ShouldRequestUpdateSideEffect());
    } catch (e, st) {
      if (!isClosed) {
        produceSideEffect(ErrorSideEffect('Nie udało się dodać śladu'));
      }
      debugPrint('Failed to add trace: $e\n$st');
    } finally {
      if (!isClosed) {
        emit(state.copyWith(isAddingTrace: false));
      }
    }
  }

  Future<void> _onUpdateLocationEvent(UpdateLocationEvent event, Emitter<MapTabState> emit) async {
    emit(state.copyWith(lastLocation: event.location));
  }

  Future<void> _onRequestMapUpdateEvent(RequestMapUpdateEvent event, Emitter<MapTabState> emit) async {
    final (traces, events) = await _getVisibleTracesAndEvents(event.bounds);
    emit(state.copyWith(traces: traces, events: events));
  }

  final TraceService _traceService;
  final EventService _eventService;

  Future<(List<TraceLocation>, List<EventLocation>)> _getVisibleTracesAndEvents(LatLngBounds bounds) async {
    _refreshPanelController.add(null);
    final center = bounds.center;
    final corner = bounds.northEast;
    final radius = Geolocator.distanceBetween(center.latitude, center.longitude, corner.latitude, corner.longitude);
    final tracesAndEvents = await Future.wait([
      _traceService.getNearbyTraces(center.latitude, center.longitude, radius.toInt() + 100),
      _eventService.getNearbyEvents(
        latitude: center.latitude,
        longitude: center.longitude,
        distance: radius.toInt() + 100,
      ),
    ]);
    final traces = tracesAndEvents[0] as List<TraceLocation>;
    final events = tracesAndEvents[1] as List<EventLocation>;
    final eventTraces = events.expand((event) => event.traces).toSet();
    traces.removeWhere(eventTraces.contains);
    return (traces, events);
  }
}
