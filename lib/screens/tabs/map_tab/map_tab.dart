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
import 'package:flutter_map_polywidget/flutter_map_polywidget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:spotspeak_mobile/di/custom_instance_names.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/dtos/add_trace_dto.dart';
import 'package:spotspeak_mobile/extensions/position_extensions.dart';
import 'package:spotspeak_mobile/models/trace.dart';
import 'package:spotspeak_mobile/models/trace_location.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/new_trace_dialog.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/trace_dialog.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/trace_marker.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/widgets/nearby_panel.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
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
  final _dio = getIt<Dio>();
  final _dioForOSM = getIt<Dio>(instanceName: dioForOSMInstanceName);
  final _dbCacheStore = getIt<DbCacheStore>();
  StreamSubscription<Position>? _locationStreamSubscription;
  StreamSubscription<MapEvent>? _mapEventSubscription;
  bool _waitingForFirstLocation = true;
  bool _addingTrace = false;

  late final StreamController<void> _refreshPanelController;

  Position? _lastLocation;
  List<TraceLocation> _traces = [];
  static const _defaultZoom = 16.5;

  final PanelController _panelController = PanelController();

  @override
  void initState() {
    super.initState();
    _mapController = AnimatedMapController(vsync: this);
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
  }

  @override
  void dispose() {
    _mapController.dispose();
    _mapEventSubscription?.cancel();
    _locationStreamSubscription?.cancel();
    _refreshPanelController.close();

    super.dispose();
  }

  void _onMoveToUserLocation() {
    if (_lastLocation != null) {
      _mapController.animateTo(dest: _lastLocation?.toLatLng(), zoom: _defaultZoom);
    }
  }

  Future<void> _onAddTrace() async {
    final result = await showDialog<TraceDialogResult?>(context: context, builder: (context) => const NewTraceDialog());
    if (result == null || _lastLocation == null) return;
    final dto = AddTraceDto(_lastLocation!.longitude, _lastLocation!.latitude, result.description, []);
    setState(() {
      _addingTrace = true;
    });
    try {
      await _traceService.addTrace(result.media, dto);
      _refreshPanelController.add(null);
      await _getVisibleTraces();
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
    EasyDebounce.debounce('get-traces', const Duration(milliseconds: 200), _getVisibleTraces);
  }

  Future<void> _getVisibleTraces() async {
    final bounds = _mapController.mapController.camera.visibleBounds;
    final center = bounds.center;
    final corner = bounds.northEast;
    final radius = Geolocator.distanceBetween(center.latitude, center.longitude, corner.latitude, corner.longitude);
    final traces = await _traceService.getNearbyTraces(center.latitude, center.longitude, radius.toInt());
    if (mounted) {
      setState(() {
        _traces = traces;
      });
    }
  }

  Future<void> _showTraceFromNotification() async {
    final trace = await _traceService.getTrace(widget.traceId!);
    if (trace.isActive() && mounted) {
      _onMoveToTraceLocation(trace);
      await showDialog<void>(context: context, builder: (context) => TraceDialog(trace: trace));
    } else {
      await Fluttertoast.showToast(
        msg: 'Ślad nie jest już aktywny',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        fontSize: 18,
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
        body: FlutterMap(
          mapController: _mapController.mapController,
          options: const MapOptions(
            maxZoom: 19,
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
              maxZoom: 19,
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
            CurrentLocationLayer(
              positionStream: _locationService.getLocationStream().map(
                    (position) => LocationMarkerPosition(
                      latitude: position.latitude,
                      longitude: position.longitude,
                      accuracy: position.accuracy,
                    ),
                  ),
              headingStream: _locationService.getLocationStream().map(
                    (position) => LocationMarkerHeading(heading: position.heading, accuracy: position.headingAccuracy),
                  ),
            ),
            // Traces layer
            MarkerLayer(
              markers: [
                for (final trace in _traces)
                  Marker(
                    point: trace.toLatLng(),
                    child: TraceMarker(
                      trace: trace,
                      currentUserLocation: _lastLocation?.toLatLng(),
                      onRefreshTraces: _getVisibleTraces,
                    ),
                    height: TraceMarker.dimens,
                    width: TraceMarker.dimens,
                  ),
              ],
            ),
            SimpleAttributionWidget(
              source: const Text('OpenStreetMap'),
              onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              alignment: Alignment.topLeft,
            ),
          ],
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
