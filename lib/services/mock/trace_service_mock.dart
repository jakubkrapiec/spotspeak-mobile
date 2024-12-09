import 'package:injectable/injectable.dart';
import 'package:spotspeak_mobile/models/content_author.dart';
import 'package:spotspeak_mobile/models/trace.dart';
import 'package:spotspeak_mobile/models/trace_location.dart';
import 'package:spotspeak_mobile/models/trace_type.dart';
import 'package:spotspeak_mobile/services/trace_service.dart';

@test
@Singleton(as: TraceService)
class TraceServiceMock implements TraceService {
  final _traces = [
    Trace(
      id: 1,
      longitude: 16.9195,
      latitude: 52.4075,
      description: 'Test trace 1',
      type: TraceType.text,
      resourceAccessUrl: Uri.parse('https://picsum.photos/700/700'),
      createdAt: DateTime.now().subtract(const Duration(hours: 4)),
      comments: [],
      author: ContentAuthor(id: '2', username: 'test', profilePictureUrl: Uri.parse('https://picsum.photos/700/700')),
    ),
  ];

  final _traceLocations = [
    TraceLocation(1, 16.9195, 52.4075, false, TraceType.text, DateTime.now().subtract(const Duration(hours: 4))),
  ];

  @override
  Future<Trace> getTrace(int id) => throw UnimplementedError();

  @override
  Future<void> deleteTrace(int id) => throw UnimplementedError();

  /// Distance is in meters
  @override
  Future<List<TraceLocation>> getNearbyTraces(double latitude, double longitude, int distance) async => _traceLocations;

  @override
  Future<List<Trace>> getMyTraces() async => _traces;

  @override
  Future<Trace> discoverTrace(int traceId, double longitude, double latitude) => throw UnimplementedError();
}
