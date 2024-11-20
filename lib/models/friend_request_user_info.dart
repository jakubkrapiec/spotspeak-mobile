import 'package:json_annotation/json_annotation.dart';
import 'package:spotspeak_mobile/models/friendship_request_status.dart';
import 'package:spotspeak_mobile/models/search_user.dart';

part 'friend_request_user_info.g.dart';

@JsonSerializable()
class FriendRequestUserInfo {
  const FriendRequestUserInfo({
    required this.id,
    required this.userInfo,
    required this.status,
    required this.sentAt,
    required this.acceptedAt,
    required this.rejectedAt,
  });

  factory FriendRequestUserInfo.fromJson(Map<String, Object?> json) => _$FriendRequestUserInfoFromJson(json);

  final int id;
  final SearchUser userInfo;
  final FriendshipRequestStatus status;
  final DateTime sentAt;
  final DateTime? acceptedAt;
  final DateTime? rejectedAt;

  Map<String, Object?> toJson() => _$FriendRequestUserInfoToJson(this);
}
