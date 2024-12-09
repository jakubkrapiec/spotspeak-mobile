import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:spotspeak_mobile/dtos/add_trace_dto.dart';
import 'package:spotspeak_mobile/models/trace.dart';
import 'package:spotspeak_mobile/services/difficult_multipart_service.dart';

@test
@Singleton(as: DifficultMultipartService)
class DifficultMultipartServiceMock implements DifficultMultipartService {
  @override
  Future<PasswordChallengeResult> checkPassword(String password) async => throw UnimplementedError();

  @override
  Future<Trace> addTrace(File? file, AddTraceDto traceUploadDTO) async => throw UnimplementedError();
}
