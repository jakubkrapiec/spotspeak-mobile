import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spotspeak_mobile/services/location_service.dart';

@test
@Singleton(as: LocationService)
class LocationServiceMock implements LocationService {
  @override
  bool initialized = false;

  @override
  bool hasPermission = false;

  @override
  Future<bool> init() async {
    initialized = true;
    return true;
  }

  final _location = Position(
    latitude: 52.407,
    longitude: 16.919,
    timestamp: DateTime.now().subtract(const Duration(hours: 4)),
    accuracy: 5,
    altitude: 50,
    heading: 16,
    speed: 0,
    speedAccuracy: 0,
    altitudeAccuracy: 0,
    headingAccuracy: 0,
  );

  @override
  Future<Position> getCurrentLocation([LocationSettings? locationSettings]) async => _location;

  @override
  ValueStream<Position> getLocationStream([LocationSettings? locationSettings]) =>
      Stream<Position>.periodic(const Duration(seconds: 2), (index) => _location).shareValue();
}
