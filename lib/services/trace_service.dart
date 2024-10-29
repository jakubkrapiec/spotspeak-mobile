import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:spotspeak_mobile/dtos/add_trace_dto.dart';
import 'package:spotspeak_mobile/models/trace.dart';
import 'package:spotspeak_mobile/models/trace_location.dart';

part 'trace_service.g.dart';

@singleton
@RestApi(baseUrl: '/api/traces')
abstract class TraceService {
  @factoryMethod
  factory TraceService(Dio dio) = _TraceService;

  @POST('')
  @MultiPart()
  Future<Trace> addTrace(@Part() File? file, AddTraceDto traceUploadDTO);

  @GET('/{id}')
  Future<Trace> getTrace(@Path() int id);

  @DELETE('/{id}')
  Future<void> deleteTrace(@Path() int id);

  /// Distance is in meters
  @GET('/nearby')
  Future<List<TraceLocation>> getNearbyTraces(
    @Query('latitude') double latitude,
    @Query('longitude') double longitude,
    @Query('distance') int distance,
  );

  @GET('/my')
  Future<List<Trace>> getMyTraces();

  @GET('/discover/{traceId}')
  Future<Trace> getDiscoverState(
    @Path() int id,
    @Query('currentLongitude') double longitude,
    @Query('currentLatitude') double latitude,
  );
}
