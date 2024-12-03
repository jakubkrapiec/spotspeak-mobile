import 'package:json_annotation/json_annotation.dart';
import 'package:spotspeak_mobile/models/friendship_request_status.dart';

part 'friendship_request.g.dart';

@JsonSerializable()
class FriendshipRequest {
  const FriendshipRequest({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.status,
    required this.sentAt,
    required this.acceptedAt,
    required this.rejectedAt,
  });

  factory FriendshipRequest.fromJson(Map<String, Object?> json) => _$FriendshipRequestFromJson(json);

  final int id;
  final String senderId;
  final String receiverId;
  final FriendshipRequestStatus status;
  final DateTime sentAt;
  final DateTime? acceptedAt;
  final DateTime? rejectedAt;

  Map<String, Object?> toJson() => _$FriendshipRequestToJson(this);
}
