import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/extensions/position_extensions.dart';
import 'package:spotspeak_mobile/models/trace_location.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/trace_dialog.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/widgets/nearby_tile.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/services/location_service.dart';
import 'package:spotspeak_mobile/services/trace_service.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

class NearbyPanel extends StatefulWidget {
  const NearbyPanel({
    required this.scrollController,
    required this.mapController,
    required this.panelController,
    required this.refreshStream,
    super.key,
  });

  final ScrollController scrollController;
  final AnimatedMapController mapController;
  final PanelController panelController;

  final Stream<void> refreshStream;

  @override
  State<NearbyPanel> createState() => _NearbyPanelState();
}

class _NearbyPanelState extends State<NearbyPanel> {
  final _traceService = getIt<TraceService>();
  final _locationService = getIt<LocationService>();
  final _appService = getIt<AppService>();

  StreamSubscription<Position>? _locationStreamSubscription;

  late final StreamSubscription<void> _refreshStreamSubscription;

  LatLng? _lastCoordinatesSync;

  List<TraceLocation>? _nearbyTraces = [];

  List<TraceLocation> _nearbyTracesFiltered = [];

  bool _isFirstSync = true;

  bool _fromClosest = true;

  bool _nonDiscoveredOnly = false;

  static const _defaultZoom = 16.5;

  @override
  void initState() {
    super.initState();
    _initLocationService();
    _refreshStreamSubscription = widget.refreshStream.listen((_) async {
      if (_lastCoordinatesSync == null) return;
      _nearbyTraces =
          await _traceService.getNearbyTraces(_lastCoordinatesSync!.latitude, _lastCoordinatesSync!.longitude, 1000);
      _nearbyTracesFiltered = List.from(_nearbyTraces!);
      _sortTraces(_fromClosest);
    });
  }

  Future<void> _initLocationService() async {
    if (!_locationService.initialized) {
      final hasPermission = await _locationService.init();
      if (!hasPermission) return;
    }
    _locationStreamSubscription = _locationService.getLocationStream().listen(_onLocationChanged);
  }

  void _sortTraces(bool isFromClosest) {
    if (isFromClosest) {
      _nearbyTracesFiltered.sort(
        (a, b) => a.calculateDistance(_lastCoordinatesSync!).compareTo(b.calculateDistance(_lastCoordinatesSync!)),
      );
    } else {
      _nearbyTracesFiltered.sort(
        (a, b) => b.calculateDistance(_lastCoordinatesSync!).compareTo(a.calculateDistance(_lastCoordinatesSync!)),
      );
    }
  }

  void _selectNonDiscoveredTraces(bool nonDiscoveredOnly) {
    if (nonDiscoveredOnly) {
      _nearbyTracesFiltered = [];
      _nearbyTracesFiltered = _nearbyTraces!.where((trace) => !trace.hasDiscovered).toList();
      _sortTraces(_fromClosest);
    } else {
      _nearbyTracesFiltered = List.from(_nearbyTraces!);
      _sortTraces(_fromClosest);
    }
  }

  Future<void> _onLocationChanged(Position position) async {
    _lastCoordinatesSync ??= position.toLatLng();
    final distance = Geolocator.distanceBetween(
      _lastCoordinatesSync!.latitude,
      _lastCoordinatesSync!.longitude,
      position.latitude,
      position.longitude,
    );
    if (distance < 50 && !_isFirstSync) return;
    final traces = await _traceService.getNearbyTraces(position.latitude, position.longitude, 1000);
    if (!mounted) return;
    setState(() {
      _nearbyTraces = traces;
      _nearbyTracesFiltered = List.from(_nearbyTraces!);
      _sortTraces(_fromClosest);
    });
    _lastCoordinatesSync = position.toLatLng();
    _isFirstSync = false;
  }

  void _onMoveToTraceLocation(TraceLocation trace) {
    widget.mapController.animateTo(dest: trace.toLatLng(), zoom: _defaultZoom);
    if (mounted) {
      widget.panelController.close();
    }
  }

  Future<void> _openTraceDialog(int traceId) async {
    final trace = await _traceService.getTrace(traceId);
    if (!mounted) return;
    final shouldDelete = await showDialog<bool>(
          context: context,
          builder: (context) => TraceDialog(trace: trace),
        ) ??
        false;
    if (shouldDelete) {
      await _traceService.deleteTrace(traceId);
      setState(() {
        _nearbyTracesFiltered.removeWhere((t) => t.id == traceId);
      });
    }
  }

  @override
  void dispose() {
    _locationStreamSubscription?.cancel();
    widget.mapController.dispose();
    _refreshStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Gap(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 5,
              decoration: _appService.themeMode == ThemeMode.light
                  ? CustomTheme.lightSliderButton
                  : CustomTheme.darkSliderButton,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                'Ślady w pobliżu',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.left,
              ),
              Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _nonDiscoveredOnly = !_nonDiscoveredOnly;
                    _selectNonDiscoveredTraces(_nonDiscoveredOnly);
                  });
                },
                child: Icon(
                  _nonDiscoveredOnly ? Icons.visibility_off : Icons.visibility,
                  size: 28,
                ),
              ),
              Gap(8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _fromClosest = !_fromClosest;
                    _sortTraces(_fromClosest);
                  });
                },
                child: Icon(Icons.swap_vert, size: 28),
              ),
            ],
          ),
        ),
        switch (_nearbyTraces) {
          null => CircularProgressIndicator(),
          [] => Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'W twoim pobliżu nie ma żadnych śladów :(',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
          _ => Expanded(
              child: ListView.builder(
                controller: widget.scrollController,
                itemCount: _nearbyTracesFiltered.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => NearbyTile(
                  trace: _nearbyTracesFiltered[index],
                  currentPostion: _lastCoordinatesSync!,
                  onTapFunction: () {
                    _onMoveToTraceLocation(_nearbyTracesFiltered[index]);
                    if (_nearbyTracesFiltered[index].hasDiscovered) {
                      _openTraceDialog(_nearbyTracesFiltered[index].id);
                    }
                  },
                  traceIconPath: _nearbyTracesFiltered[index].iconSvgPath,
                ),
              ),
            ),
        },
      ],
    );
  }
}
