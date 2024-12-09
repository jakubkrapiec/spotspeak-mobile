import 'package:injectable/injectable.dart';
import 'package:spotspeak_mobile/models/trace.dart';
import 'package:spotspeak_mobile/models/trace_location.dart';
import 'package:spotspeak_mobile/services/trace_service.dart';

@test
@Singleton(as: TraceService)
class TraceServiceMock implements TraceService {
  @override
  Future<Trace> getTrace(int id) => throw UnimplementedError();

  @override
  Future<void> deleteTrace(int id) => throw UnimplementedError();

  /// Distance is in meters
  @override
  Future<List<TraceLocation>> getNearbyTraces(double latitude, double longitude, int distance) =>
      throw UnimplementedError();

  @override
  Future<List<Trace>> getMyTraces() => throw UnimplementedError();

  @override
  Future<Trace> discoverTrace(int traceId, double longitude, double latitude) => throw UnimplementedError();
}
