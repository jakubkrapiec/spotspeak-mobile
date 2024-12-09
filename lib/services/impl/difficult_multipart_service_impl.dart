import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';
import 'package:spotspeak_mobile/dtos/add_trace_dto.dart';
import 'package:spotspeak_mobile/dtos/password_challenge_dto.dart';
import 'package:spotspeak_mobile/models/trace.dart';
import 'package:spotspeak_mobile/services/difficult_multipart_service.dart';

@Singleton(as: DifficultMultipartService)
class DifficultMultipartServiceImpl implements DifficultMultipartService {
  DifficultMultipartServiceImpl(this._dio);

  final Dio _dio;

  @override
  Future<PasswordChallengeResult> checkPassword(String password) async {
    try {
      final response = await _dio.post<Map<String, Object?>>(
        '/users/me/generate-challenge',
        data: jsonEncode({'password': password}),
      );
      if (response.statusCode == 200) {
        final dto = PasswordChallengeDto.fromJson(response.data!);
        return PasswordChallengeSuccess(dto.token);
      } else if (response.data?['message'] == 'Failed to validate password') {
        return PasswordChallengeFailedWrongPassword();
      } else {
        return PasswordChallengeFailedOtherError();
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        return PasswordChallengeFailedWrongPassword();
      }
      return PasswordChallengeFailedOtherError();
    }
  }

  @override
  Future<Trace> addTrace(File? file, AddTraceDto traceUploadDTO) async {
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
    final result = await _dio.post<Map<String, Object?>>('/traces', data: data);
    return Trace.fromJson(result.data!);
  }
}
