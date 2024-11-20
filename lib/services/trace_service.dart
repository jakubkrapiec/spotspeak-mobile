import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';
import 'package:retrofit/retrofit.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/dtos/add_trace_dto.dart';
import 'package:spotspeak_mobile/models/tag.dart';
import 'package:spotspeak_mobile/models/trace.dart';
import 'package:spotspeak_mobile/models/trace_location.dart';

part 'trace_service.g.dart';

@singleton
@RestApi(baseUrl: '/api/traces')
abstract class TraceService {
  @factoryMethod
  factory TraceService(Dio dio) = _TraceService;

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
  Future<Trace> discoverTrace(
    @Path() int traceId,
    @Query('currentLongitude') double longitude,
    @Query('currentLatitude') double latitude,
  );

  @GET('/tags')
  Future<List<Tag>> getTags();
}

extension TraceServiceExtensions on TraceService {
  // don't even ask me why this method is here...
  Future<Trace> addTrace(File? file, AddTraceDto traceUploadDTO) async {
    final dio = getIt<Dio>();
    final data = FormData();
    if (file != null) {
      final multipartMediaFile = await MultipartFile.fromFile(
        file.path,
        filename: file.path.split(Platform.pathSeparator).last,
        contentType: MediaType.parse(lookupMimeType(file.path)!),
      );
      data.files.add(MapEntry('file', multipartMediaFile));
    }
    final dtoMultipartFile = MultipartFile.fromString(
      jsonEncode(traceUploadDTO.toJson()),
      filename: 'traceUploadDTO',
      contentType: MediaType('application', 'json'),
    );
    data.files.add(MapEntry('traceUploadDTO', dtoMultipartFile));
    final result = await dio.post<Map<String, Object?>>('/traces', data: data);
    return Trace.fromJson(result.data!);
  }
}
