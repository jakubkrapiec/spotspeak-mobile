import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:mutex/mutex.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class LocationService {
  bool initialized = false;
  bool hasPermission = false;

  final _initMutex = Mutex();

  /// Return true if the location service is enabled and the app has the necessary permissions.
  /// This method requests a permission from the user, so should not be called automatically at app startup.
  Future<bool> init() async {
    return _initMutex.protect(() async {
      if (initialized) return hasPermission;
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return false;
      }
      final permission = await Geolocator.requestPermission();
      hasPermission = permission == LocationPermission.always || permission == LocationPermission.whileInUse;
      initialized = true;
      return hasPermission;
    });
  }

  Future<Position> getCurrentLocation([LocationSettings? locationSettings]) async {
    final position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
    return position;
  }

  Stream<Position> getLocationStream([LocationSettings? locationSettings]) =>
      Geolocator.getPositionStream(locationSettings: locationSettings).shareValue();
}
