import 'package:spotspeak_mobile/models/trace.dart';
import 'package:spotspeak_mobile/models/trace_location.dart';

abstract interface class TraceService {
  Future<Trace> getTrace(int id);
  Future<void> deleteTrace(int id);

  /// Distance is in meters
  Future<List<TraceLocation>> getNearbyTraces(double latitude, double longitude, int distance);

  Future<List<Trace>> getMyTraces();

  Future<Trace> discoverTrace(int traceId, double longitude, double latitude);
}
