import 'package:freezed_annotation/freezed_annotation.dart';

enum FriendshipRequestStatus {
  @JsonValue('PENDING')
  pending,

  @JsonValue('ACCEPTED')
  accepted,

  @JsonValue('REJECTED')
  rejected,
}
