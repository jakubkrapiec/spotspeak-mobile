import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/extensions/position_extensions.dart';
import 'package:spotspeak_mobile/models/trace_location.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/widgets/nearby_tile.dart';
import 'package:spotspeak_mobile/services/location_service.dart';
import 'package:spotspeak_mobile/services/trace_service.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

class NearbyPanel extends StatefulWidget {
  const NearbyPanel({required this.scrollController, super.key});

  final ScrollController scrollController;

  @override
  State<NearbyPanel> createState() => _NearbyPanelState();
}

class _NearbyPanelState extends State<NearbyPanel> {
  final _traceService = getIt<TraceService>();

  final _locationService = getIt<LocationService>();

  StreamSubscription<Position>? _locationStreamSubscription;

  LatLng? _lastCoordinatesSync;

  List<TraceLocation>? _nearbyTraces;

  bool _isFirstSync = true;

  @override
  void initState() {
    super.initState();
    _initLocationService();
  }

  Future<void> _initLocationService() async {
    if (!_locationService.initialized) {
      final hasPermission = await _locationService.init();
      if (!hasPermission) return;
    }
    _locationStreamSubscription = _locationService.getLocationStream().listen(_onLocationChanged);
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
    });
    _lastCoordinatesSync = position.toLatLng();
    _isFirstSync = false;
  }

  @override
  void dispose() {
    _locationStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 5,
              decoration: MediaQuery.platformBrightnessOf(context) == Brightness.light
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
                'Ślady w pobliżu:',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.left,
              ),
              Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.visibility,
                  size: 28,
                ),
              ),
              Gap(8),
              GestureDetector(
                onTap: () {},
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
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'W twoim pobliżu nie ma żadnych śladów :(',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
          _ => Expanded(
              child: ListView.builder(
                controller: widget.scrollController,
                itemCount: _nearbyTraces!.length,
                itemBuilder: (context, index) {
                  return NearbyTile(trace: _nearbyTraces![index]);
                },
              ),
            ),
        },
      ],
    );
  }
}
