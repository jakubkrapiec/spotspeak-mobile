import 'package:json_annotation/json_annotation.dart';

part 'friendship_request.g.dart';

@JsonSerializable()
class FriendshipRequest {
  const FriendshipRequest({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.status,
    required this.sentAt,
    required this.acceptedAt,
  });

  factory FriendshipRequest.fromJson(Map<String, Object?> json) => _$FriendshipRequestFromJson(json);

  final int id;
  final String sender;
  final String receiver;
  // TODO: replace with enum
  final String status;
  final DateTime sentAt;
  final DateTime? acceptedAt;

  Map<String, Object?> toJson() => _$FriendshipRequestToJson(this);
}
