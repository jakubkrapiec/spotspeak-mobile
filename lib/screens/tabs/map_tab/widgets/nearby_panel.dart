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
import 'package:spotspeak_mobile/models/trace_type.dart';
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

  List<TraceLocation> _nearbyTracesCopy = [];

  bool _isFirstSync = true;

  bool _fromClosest = true;

  bool _nonDiscoveredOnly = false;

  static const _defaultZoom = 16.5;

  @override
  void initState() {
    super.initState();
    _initLocationService();
    _refreshStreamSubscription = widget.refreshStream.listen((_) async {
      _nearbyTraces =
          await _traceService.getNearbyTraces(_lastCoordinatesSync!.latitude, _lastCoordinatesSync!.longitude, 1000);
      _nearbyTracesCopy = List.from(_nearbyTraces!);
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
      _nearbyTracesCopy.sort(
        (a, b) => a.calculateDistance(_lastCoordinatesSync!).compareTo(b.calculateDistance(_lastCoordinatesSync!)),
      );
    } else {
      _nearbyTracesCopy.sort(
        (a, b) => b.calculateDistance(_lastCoordinatesSync!).compareTo(a.calculateDistance(_lastCoordinatesSync!)),
      );
    }
  }

  void _selectNonDiscoveredTraces(bool nonDiscoveredOnly) {
    if (nonDiscoveredOnly) {
      _nearbyTracesCopy = [];
      _nearbyTracesCopy = _nearbyTraces!.where((trace) => !trace.hasDiscovered).toList();
      _sortTraces(_fromClosest);
    } else {
      _nearbyTracesCopy = List.from(_nearbyTraces!);
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
      _nearbyTracesCopy = List.from(_nearbyTraces!);
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

  @override
  void dispose() {
    _locationStreamSubscription?.cancel();
    widget.mapController.dispose();
    _refreshStreamSubscription.cancel();
    super.dispose();
  }

  String _getUndiscoveredTraceIconPath(int id) {
    final randomIndex = id.hashCode % 6;
    return 'assets/trace_icons_hidden/trace_icon_hidden_$randomIndex.svg';
  }

  String _getDiscoveredTraceIconPath(TraceType type) => switch (type) {
        TraceType.text => 'assets/trace_icons_discovered/text_trace.svg',
        TraceType.image => 'assets/trace_icons_discovered/photo_trace.svg',
        TraceType.video => 'assets/trace_icons_discovered/video_trace.svg',
      };

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
                child: Icon(
                  Icons.swap_vert,
                  size: 28,
                ),
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
                itemCount: _nearbyTracesCopy.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return NearbyTile(
                    trace: _nearbyTracesCopy[index],
                    currentPostion: _lastCoordinatesSync!,
                    onTapFunction: () => _onMoveToTraceLocation(_nearbyTraces![index]),
                    traceIconPath: _nearbyTracesCopy[index].hasDiscovered
                        ? _getDiscoveredTraceIconPath(_nearbyTracesCopy[index].type)
                        : _getUndiscoveredTraceIconPath(_nearbyTracesCopy[index].id),
                  );
                },
              ),
            ),
        },
      ],
    );
  }
}
