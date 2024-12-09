import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:spotspeak_mobile/models/trace.dart';
import 'package:spotspeak_mobile/models/trace_location.dart';
import 'package:spotspeak_mobile/services/trace_service.dart';

part 'trace_service_impl.g.dart';

@prod
@Singleton(as: TraceService)
@RestApi(baseUrl: '/api/traces')
abstract class TraceServiceImpl implements TraceService {
  @factoryMethod
  factory TraceServiceImpl(Dio dio) = _TraceServiceImpl;

  @override
  @GET('/{id}')
  Future<Trace> getTrace(@Path() int id);

  @override
  @DELETE('/{id}')
  Future<void> deleteTrace(@Path() int id);

  /// Distance is in meters
  @override
  @GET('/nearby')
  Future<List<TraceLocation>> getNearbyTraces(
    @Query('latitude') double latitude,
    @Query('longitude') double longitude,
    @Query('distance') int distance,
  );

  @override
  @GET('/my')
  Future<List<Trace>> getMyTraces();

  @override
  @GET('/discover/{traceId}')
  Future<Trace> discoverTrace(
    @Path() int traceId,
    @Query('currentLongitude') double longitude,
    @Query('currentLatitude') double latitude,
  );
}
