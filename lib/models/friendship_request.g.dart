// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendship_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendshipRequest _$FriendshipRequestFromJson(Map<String, dynamic> json) =>
    FriendshipRequest(
      id: (json['id'] as num).toInt(),
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      status: $enumDecode(_$FriendshipRequestStatusEnumMap, json['status']),
      sentAt: DateTime.parse(json['sentAt'] as String),
      acceptedAt: json['acceptedAt'] == null
          ? null
          : DateTime.parse(json['acceptedAt'] as String),
      rejectedAt: json['rejectedAt'] == null
          ? null
          : DateTime.parse(json['rejectedAt'] as String),
    );

Map<String, dynamic> _$FriendshipRequestToJson(FriendshipRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'status': _$FriendshipRequestStatusEnumMap[instance.status]!,
      'sentAt': instance.sentAt.toIso8601String(),
      'acceptedAt': instance.acceptedAt?.toIso8601String(),
      'rejectedAt': instance.rejectedAt?.toIso8601String(),
    };

const _$FriendshipRequestStatusEnumMap = {
  FriendshipRequestStatus.pending: 'PENDING',
  FriendshipRequestStatus.accepted: 'ACCEPTED',
  FriendshipRequestStatus.rejected: 'REJECTED',
};
