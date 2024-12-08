import 'dart:async';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor_db_store/dio_cache_interceptor_db_store.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_map_polywidget/flutter_map_polywidget.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:side_effect_bloc/side_effect_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:spotspeak_mobile/di/custom_instance_names.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/extensions/position_extensions.dart';
import 'package:spotspeak_mobile/models/trace.dart';
import 'package:spotspeak_mobile/models/trace_location.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/event_marker.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/map_tab_bloc.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/map_tab_events.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/map_tab_side_effect.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/map_tab_state.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/new_trace_dialog.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/trace_dialog.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/trace_marker.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/widgets/nearby_panel.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/services/authentication_service.dart';
import 'package:spotspeak_mobile/services/location_service.dart';
import 'package:spotspeak_mobile/services/trace_service.dart';
import 'package:spotspeak_mobile/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class MapTab extends StatefulWidget {
  const MapTab({@QueryParam('traceId') this.traceId, super.key});

  final int? traceId;
  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> with TickerProviderStateMixin {
  late final AnimatedMapController _mapController;

  StreamSubscription<Position>? _locationStreamSubscription;
  StreamSubscription<MapEvent>? _mapEventSubscription;
  late final Timer _refreshTimer;
  late final StreamController<void> _refreshPanelController;
  bool _isWaitingForFirstLocation = true;

  static const _defaultZoom = 16.5;
  static const _maxZoom = 19.0;

  late final PanelController _panelController;

  final _bloc = getIt<MapTabBloc>();
  final _appService = getIt<AppService>();
  final _dio = getIt<Dio>();
  final _dioForOSM = getIt<Dio>(instanceName: dioForOSMInstanceName);
  final _dbCacheStore = getIt<DbCacheStore>();
  final _locationService = getIt<LocationService>();
  final _traceService = getIt<TraceService>();
  final _authService = getIt<AuthenticationService>();

  @override
  void initState() {
    super.initState();
    _mapController = AnimatedMapController(vsync: this);
    _panelController = PanelController();
    _refreshPanelController = StreamController<void>.broadcast();
    _initLocationService();
    _mapEventSubscription = _mapController.mapController.mapEventStream.listen((event) {
      if (event is MapEventMove) {
        _onMapScrolled(_mapController.mapController.camera.visibleBounds);
      }
    });
    if (widget.traceId != null) {
      _showTraceFromNotification();
    }
    _refreshTimer = Timer.periodic(
      const Duration(minutes: 1),
      (_) => _bloc.add(RequestMapUpdateEvent(bounds: _mapController.mapController.camera.visibleBounds)),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    _mapEventSubscription?.cancel();
    _locationStreamSubscription?.cancel();
    _panelController.close();
    _refreshTimer.cancel();
    _bloc.close();
    _refreshPanelController.close();
    super.dispose();
  }

  void _onMoveToUserLocation(LatLng? location) {
    if (location != null) {
      _mapController.animateTo(dest: location, zoom: _defaultZoom);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Brak dostępu do lokalizacji')));
    }
  }

  Future<void> _onAddTrace(LatLng? lastLocation) async {
    if (lastLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Brak dostępu do lokalizacji')));
      return;
    }
    if (_authService.userTypeNotifier.value == UserType.guest) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Zaloguj się, aby dodać ślad')));
      return;
    }
    final result = await showDialog<TraceDialogResult?>(context: context, builder: (context) => const NewTraceDialog());
    if (result == null || !mounted) return;
    _bloc.add(AddTraceEvent(location: lastLocation, traceDialogResult: result));
  }

  Future<void> _initLocationService() async {
    try {
      if (!_locationService.initialized) {
        final hasPermission = await _locationService.init();
        if (!hasPermission) return;
      }
      _locationStreamSubscription = _locationService.getLocationStream().listen(_onLocationUpdate);
    } catch (e, st) {
      debugPrint('Failed to initialize location service: $e\n$st');
    }
  }

  void _onLocationUpdate(Position position) {
    _bloc.add(UpdateLocationEvent(position));
    if (_isWaitingForFirstLocation) {
      _mapController.animateTo(dest: position.toLatLng(), zoom: _defaultZoom);
      _isWaitingForFirstLocation = false;
    }
  }

  void _onMapScrolled(LatLngBounds bounds) {
    EasyDebounce.debounce(
      'get-traces',
      const Duration(milliseconds: 200),
      () => _bloc.add(RequestMapUpdateEvent(bounds: bounds)),
    );
  }

  Future<void> _showTraceFromNotification() async {
    final trace = await _traceService.getTrace(widget.traceId!);
    if (trace.isActive && mounted) {
      _onMoveToTraceLocation(trace);
      await showDialog<void>(context: context, builder: (context) => TraceDialog(trace: trace));
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ślad nie jest już aktywny')));
    }
  }

  void _onMoveToTraceLocation(Trace trace) {
    _mapController.animateTo(dest: trace.location, zoom: _defaultZoom);
  }

  void _sideEffectListener(BuildContext context, MapTabSideEffect sideEffect) {
    switch (sideEffect) {
      case final ErrorSideEffect e:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      case final ShouldRequestUpdateSideEffect _:
        _bloc.add(RequestMapUpdateEvent(bounds: _mapController.mapController.camera.visibleBounds));
        _refreshPanelController.add(null);
    }
  }

  Future<void> _onTapTrace(TraceLocation traceLocation) async {
    final location = _bloc.state.lastLocation;
    if (location == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Brak dostępu do lokalizacji')));
      return;
    }
    try {
      final Trace trace;
      if (traceLocation.hasDiscovered) {
        trace = await _traceService.getTrace(traceLocation.id);
      } else {
        trace = await _traceService.discoverTrace(traceLocation.id, location.longitude, location.latitude);
      }
      if (!mounted) return;
      final shouldDelete = await showDialog<bool>(context: context, builder: (context) => TraceDialog(trace: trace));
      if (shouldDelete ?? false) {
        await _traceService.deleteTrace(traceLocation.id);
      }
      _bloc.add(RequestMapUpdateEvent(bounds: _mapController.mapController.camera.visibleBounds));
    } catch (e, st) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Podejdź bliżej do śladu')));
        debugPrint('Failed to load trace: $e\n$st');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocSideEffectListener<MapTabBloc, MapTabSideEffect>(
      listener: _sideEffectListener,
      bloc: _bloc,
      child: BlocBuilder<MapTabBloc, MapTabState>(
        bloc: _bloc,
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: _FloatingActionButtons(
              onTapMoveToUserLocation: () => _onMoveToUserLocation(state.lastLocation?.toLatLng()),
              onTapAddTrace: () => _onAddTrace(state.lastLocation?.toLatLng()),
              addingTrace: state.isAddingTrace,
            ),
            body: SlidingUpPanel(
              controller: _panelController,
              panelBuilder: (scrollController) => NearbyPanel(
                scrollController: scrollController,
                mapController: _mapController,
                panelController: _panelController,
                refreshStream: _refreshPanelController.stream,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              color: _appService.isDarkMode(context) ? CustomColors.grey5 : CustomColors.blue1,
              body: Portal(
                debugName: 'map_portal',
                child: FlutterMap(
                  mapController: _mapController.mapController,
                  options: const MapOptions(
                    maxZoom: _maxZoom,
                    minZoom: 2,
                    interactionOptions: InteractionOptions(flags: ~InteractiveFlag.rotate),
                    initialCenter: LatLng(52, 19),
                    initialZoom: 5.5,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: _dio.options.headers[HttpHeaders.userAgentHeader]! as String,
                      tileProvider:
                          CachedTileProvider(dio: _dioForOSM, store: _dbCacheStore, maxStale: Duration(days: 30)),
                      maxZoom: _maxZoom,
                      minZoom: 2,
                      retinaMode: false,
                    ),
                    PolyWidgetLayer(
                      polyWidgets: [
                        if (state.lastLocation != null)
                          PolyWidget(
                            center: state.lastLocation!.toLatLng(),
                            widthInMeters: 100,
                            heightInMeters: 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withOpacity(0.3),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    ),
                    MarkerClusterLayerWidget(
                      options: MarkerClusterLayerOptions(
                        //maxClusterRadius: 80,
                        //size: const Size(40, 40),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(50),
                        maxZoom: _maxZoom,
                        markers: [
                          for (final trace in state.traces)
                            Marker(
                              point: trace.toLatLng(),
                              child: TraceMarker(
                                trace: trace,
                                currentUserLocation: state.lastLocation?.toLatLng(),
                                onRefreshTraces: () => _bloc.add(
                                  RequestMapUpdateEvent(bounds: _mapController.mapController.camera.visibleBounds),
                                ),
                              ),
                              height: TraceMarker.dimens,
                              width: TraceMarker.dimens,
                            ),
                        ],
                        builder: (context, markers) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Center(
                            child: Text(
                              markers.length.toString(),
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    PolyWidgetLayer(
                      polyWidgets: [
                        for (final event in state.events)
                          PolyWidget(
                            center: event.latLng,
                            widthInMeters: event.radius.clamp(100, 500),
                            heightInMeters: event.radius.clamp(100, 500),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: EventMarker(
                                event: event,
                                userLocation: state.lastLocation?.toLatLng(),
                                onTapTrace: _onTapTrace,
                              ),
                            ),
                          ),
                      ],
                    ),
                    CurrentLocationLayer(
                      style: LocationMarkerStyle(marker: Opacity(opacity: 0.8, child: DefaultLocationMarker())),
                      positionStream: _locationService.getLocationStream().map(
                            (position) => LocationMarkerPosition(
                              latitude: position.latitude,
                              longitude: position.longitude,
                              accuracy: position.accuracy,
                            ),
                          ),
                      headingStream: _locationService.getLocationStream().map(
                            (position) =>
                                LocationMarkerHeading(heading: position.heading, accuracy: position.headingAccuracy),
                          ),
                    ),
                    SimpleAttributionWidget(
                      source: const Text('OpenStreetMap'),
                      onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                      alignment: Alignment.topLeft,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FloatingActionButtons extends StatelessWidget {
  const _FloatingActionButtons({
    required this.onTapMoveToUserLocation,
    required this.onTapAddTrace,
    required this.addingTrace,
  });

  final VoidCallback onTapMoveToUserLocation;
  final VoidCallback onTapAddTrace;
  final bool addingTrace;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: onTapMoveToUserLocation,
              heroTag: 'go_to_user_location',
              child: const Icon(Icons.near_me),
            ),
            const Gap(8),
            FloatingActionButton(
              onPressed: addingTrace ? null : onTapAddTrace,
              heroTag: 'add_trace',
              child: addingTrace ? const CircularProgressIndicator() : const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
