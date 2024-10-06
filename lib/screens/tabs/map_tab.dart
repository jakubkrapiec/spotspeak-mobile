import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/services/location_service.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  late final MapController _mapController;
  final _locationService = getIt<LocationService>();
  StreamSubscription<Position>? _locationStreamSubscription;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _initLocationService();
  }

  @override
  void dispose() {
    _mapController.dispose();
    _locationStreamSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initLocationService() async {
    if (!_locationService.initialized) {
      final hasPermission = await _locationService.init();
      if (!hasPermission) return;
    }
    _locationStreamSubscription = _locationService.getLocationStream().listen(_onLocationUpdate);
  }

  void _onLocationUpdate(Position position) {}

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: const MapOptions(
        maxZoom: 19,
        minZoom: 2,
        interactionOptions: InteractionOptions(rotationThreshold: 60),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          fallbackUrl: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: getIt<Dio>().options.headers[HttpHeaders.userAgentHeader]! as String,
          tileProvider: CancellableNetworkTileProvider(dioClient: getIt()),
          maxZoom: 19,
          minZoom: 2,
        ),
        SimpleAttributionWidget(
          source: const Text('OpenStreetMap'),
          onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
        ),
      ],
    );
  }
}
