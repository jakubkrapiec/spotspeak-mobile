import 'package:json_annotation/json_annotation.dart';

enum FriendshipStatus {
  @JsonValue('FRIENDS')
  friends,
  @JsonValue('NO_RELATION')
  noRelation,
  @JsonValue('INVITATION_SENT')
  invitationSent,
  @JsonValue('INVITATION_RECEIVED')
  invitationReceived,
}
