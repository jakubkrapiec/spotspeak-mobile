import 'dart:io';

import 'package:spotspeak_mobile/dtos/add_trace_dto.dart';
import 'package:spotspeak_mobile/models/trace.dart';

/// Don't even ask...
abstract interface class DifficultMultipartService {
  Future<PasswordChallengeResult> checkPassword(String password);
  Future<Trace> addTrace(File? file, AddTraceDto traceUploadDTO);
}

abstract class PasswordChallengeResult {}

class PasswordChallengeFailedWrongPassword extends PasswordChallengeResult {}

class PasswordChallengeFailedOtherError extends PasswordChallengeResult {}

class PasswordChallengeSuccess extends PasswordChallengeResult {
  PasswordChallengeSuccess(this.token);
  final String token;
}
