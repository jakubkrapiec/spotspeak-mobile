import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';

abstract interface class LocationService {
  bool initialized = false;
  bool hasPermission = false;

  /// Return true if the location service is enabled and the app has the necessary permissions.
  /// This method requests a permission from the user, so should not be called automatically at app startup.
  Future<bool> init();

  Future<Position> getCurrentLocation([LocationSettings? locationSettings]);

  ValueStream<Position> getLocationStream([LocationSettings? locationSettings]);
}
