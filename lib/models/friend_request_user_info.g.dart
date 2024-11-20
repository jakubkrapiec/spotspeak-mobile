// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_request_user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendRequestUserInfo _$FriendRequestUserInfoFromJson(
        Map<String, dynamic> json) =>
    FriendRequestUserInfo(
      id: (json['id'] as num).toInt(),
      userInfo: SearchUser.fromJson(json['userInfo'] as Map<String, dynamic>),
      status: $enumDecode(_$FriendshipRequestStatusEnumMap, json['status']),
      sentAt: DateTime.parse(json['sentAt'] as String),
      acceptedAt: json['acceptedAt'] == null
          ? null
          : DateTime.parse(json['acceptedAt'] as String),
      rejectedAt: json['rejectedAt'] == null
          ? null
          : DateTime.parse(json['rejectedAt'] as String),
    );

Map<String, dynamic> _$FriendRequestUserInfoToJson(
        FriendRequestUserInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userInfo': instance.userInfo,
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
