import 'dart:async';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor_db_store/dio_cache_interceptor_db_store.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_map_polywidget/flutter_map_polywidget.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:spotspeak_mobile/di/custom_instance_names.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/dtos/add_trace_dto.dart';
import 'package:spotspeak_mobile/extensions/position_extensions.dart';
import 'package:spotspeak_mobile/models/event_location.dart';
import 'package:spotspeak_mobile/models/trace.dart';
import 'package:spotspeak_mobile/models/trace_location.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/event_marker.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/new_trace_dialog.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/trace_dialog.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/trace_marker.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/widgets/nearby_panel.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/services/event_service.dart';
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
  final _locationService = getIt<LocationService>();
  final _traceService = getIt<TraceService>();
  final _appService = getIt<AppService>();
  final _eventService = getIt<EventService>();
  final _dio = getIt<Dio>();
  final _dioForOSM = getIt<Dio>(instanceName: dioForOSMInstanceName);
  final _dbCacheStore = getIt<DbCacheStore>();
  StreamSubscription<Position>? _locationStreamSubscription;
  StreamSubscription<MapEvent>? _mapEventSubscription;
  bool _waitingForFirstLocation = true;
  bool _addingTrace = false;
  late final Timer _refreshTimer;

  late final StreamController<void> _refreshPanelController;

  Position? _lastLocation;
  List<TraceLocation> _traces = [];
  List<EventLocation> _events = [];
  static const _defaultZoom = 16.5;
  static const _maxZoom = 19.0;

  late final PanelController _panelController;

  @override
  void initState() {
    super.initState();
    _mapController = AnimatedMapController(vsync: this);
    _panelController = PanelController();
    _refreshPanelController = StreamController();
    _initLocationService();
    _mapEventSubscription = _mapController.mapController.mapEventStream.listen((event) {
      if (event is MapEventMove) {
        _onMapScrolled(_mapController.mapController.camera.visibleBounds);
      }
    });
    if (widget.traceId != null) {
      _showTraceFromNotification();
    }
    // _refreshTimer = Timer.periodic(const Duration(seconds: 15), (_) => _getVisibleTracesAndEvents());
  }

  @override
  void dispose() {
    _mapController.dispose();
    _mapEventSubscription?.cancel();
    _locationStreamSubscription?.cancel();
    _refreshPanelController.close();
    _panelController.close();
    _refreshTimer.cancel();
    super.dispose();
  }

  void _onMoveToUserLocation() {
    if (_lastLocation != null) {
      _mapController.animateTo(dest: _lastLocation?.toLatLng(), zoom: _defaultZoom);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Brak dostępu do lokalizacji')));
    }
  }

  Future<void> _onAddTrace() async {
    if (_lastLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Brak dostępu do lokalizacji')));
      return;
    }
    final location = _lastLocation;
    final result = await showDialog<TraceDialogResult?>(context: context, builder: (context) => const NewTraceDialog());
    if (result == null) return;
    final dto = AddTraceDto(location!.longitude, location.latitude, result.description, []);
    setState(() {
      _addingTrace = true;
    });
    try {
      await _traceService.addTrace(result.media, dto);
      _refreshPanelController.add(null);
      await _getVisibleTracesAndEvents();
    } catch (e, st) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nie udało się dodać śladu')));
      }
      debugPrint('Failed to add trace: $e\n$st');
    } finally {
      if (mounted) {
        setState(() {
          _addingTrace = false;
        });
      }
    }
  }

  Future<void> _initLocationService() async {
    if (!_locationService.initialized) {
      final hasPermission = await _locationService.init();
      if (!hasPermission) return;
    }
    _locationStreamSubscription = _locationService.getLocationStream().listen(_onLocationUpdate);
  }

  void _onLocationUpdate(Position position) {
    setState(() {
      _lastLocation = position;
    });
    if (_waitingForFirstLocation) {
      _mapController.animateTo(dest: _lastLocation?.toLatLng(), zoom: _defaultZoom);
      _waitingForFirstLocation = false;
    }
  }

  Future<void> _onMapScrolled(LatLngBounds bounds) async {
    EasyDebounce.debounce('get-traces', const Duration(milliseconds: 200), _getVisibleTracesAndEvents);
  }

  Future<void> _getVisibleTracesAndEvents() async {
    _refreshPanelController.add(null);
    final bounds = _mapController.mapController.camera.visibleBounds;
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
    //traces.removeWhere((trace) => )
    if (mounted) {
      setState(() {
        _traces = traces;
        _events = events;
      });
    }
  }

  Future<void> _showTraceFromNotification() async {
    final trace = await _traceService.getTrace(widget.traceId!);
    if (trace.isActive && mounted) {
      _onMoveToTraceLocation(trace);
      await showDialog<void>(context: context, builder: (context) => TraceDialog(trace: trace));
    } else {
      await Fluttertoast.showToast(
        msg: 'Ślad nie jest już aktywny',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        fontSize: 18,
        backgroundColor: CustomColors.grey1,
        textColor: CustomColors.grey6,
      );
    }
  }

  void _onMoveToTraceLocation(Trace trace) {
    _mapController.animateTo(dest: trace.location, zoom: _defaultZoom);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _FloatingActionButtons(
        onTapMoveToUserLocation: _onMoveToUserLocation,
        onTapAddTrace: _onAddTrace,
        addingTrace: _addingTrace,
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
                tileProvider: CachedTileProvider(dio: _dioForOSM, store: _dbCacheStore, maxStale: Duration(days: 30)),
                maxZoom: _maxZoom,
                minZoom: 2,
                retinaMode: false,
              ),
              PolyWidgetLayer(
                polyWidgets: [
                  if (_lastLocation != null)
                    PolyWidget(
                      center: _lastLocation!.toLatLng(),
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
                    for (final trace in _traces)
                      Marker(
                        point: trace.toLatLng(),
                        child: TraceMarker(
                          trace: trace,
                          currentUserLocation: _lastLocation?.toLatLng(),
                          onRefreshTraces: _getVisibleTracesAndEvents,
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
                  for (final event in _events)
                    PolyWidget(
                      center: event.latLng,
                      widthInMeters: event.radius.clamp(100, 500),
                      heightInMeters: event.radius.clamp(100, 500),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: EventMarker(
                          event: event,
                          userLocation: _lastLocation?.toLatLng(),
                          // TODO change
                          onTapTrace: (_) async {},
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
