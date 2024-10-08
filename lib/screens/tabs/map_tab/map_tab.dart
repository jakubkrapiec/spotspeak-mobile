import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/location_marker.dart';
import 'package:spotspeak_mobile/services/location_service.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> with TickerProviderStateMixin {
  late final AnimatedMapController _mapController;
  final _locationService = getIt<LocationService>();
  StreamSubscription<Position>? _locationStreamSubscription;
  bool _waitingForFirstLocation = true;
  LatLng? _lastLocation;

  @override
  void initState() {
    super.initState();
    _mapController = AnimatedMapController(vsync: this);
    _initLocationService();
  }

  @override
  void dispose() {
    _mapController.dispose();
    _locationStreamSubscription?.cancel();
    super.dispose();
  }

  void _onMoveToUserLocation() {
    if (_lastLocation != null) {
      _mapController.animateTo(dest: _lastLocation, zoom: 15);
    }
  }

  void _onAddTrace() {}

  Future<void> _initLocationService() async {
    if (!_locationService.initialized) {
      final hasPermission = await _locationService.init();
      if (!hasPermission) return;
    }
    _locationStreamSubscription = _locationService.getLocationStream().listen(_onLocationUpdate);
  }

  void _onLocationUpdate(Position position) {
    setState(() {
      _lastLocation = LatLng(position.latitude, position.longitude);
    });
    if (_waitingForFirstLocation) {
      _mapController.animateTo(dest: _lastLocation, zoom: 15);
      _waitingForFirstLocation = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _FloatingActionButtons(
        onTapMoveToUserLocation: _onMoveToUserLocation,
        onTapAddTrace: _onAddTrace,
      ),
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
            fallbackUrl: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: getIt<Dio>().options.headers[HttpHeaders.userAgentHeader]! as String,
            tileProvider: CancellableNetworkTileProvider(dioClient: getIt()),
            maxZoom: 19,
            minZoom: 2,
            retinaMode: false,
          ),
          MarkerLayer(
            markers: [
              if (_lastLocation != null)
                Marker(
                  point: _lastLocation!,
                  child: const LocationMarker(),
                  height: LocationMarker.dimens,
                  width: LocationMarker.dimens,
                ),
            ],
          ),
          SimpleAttributionWidget(
            source: const Text('OpenStreetMap'),
            onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
            alignment: Alignment.bottomLeft,
          ),
        ],
      ),
    );
  }
}

class _FloatingActionButtons extends StatelessWidget {
  const _FloatingActionButtons({required this.onTapMoveToUserLocation, required this.onTapAddTrace});

  final VoidCallback onTapMoveToUserLocation;
  final VoidCallback onTapAddTrace;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: onTapMoveToUserLocation,
          child: const Icon(Icons.near_me),
        ),
        const Gap(8),
        FloatingActionButton(
          onPressed: onTapAddTrace,
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
