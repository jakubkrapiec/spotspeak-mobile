// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendship_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendshipRequest _$FriendshipRequestFromJson(Map<String, dynamic> json) =>
    FriendshipRequest(
      id: (json['id'] as num).toInt(),
      sender: json['sender'] as String,
      receiver: json['receiver'] as String,
      status: json['status'] as String,
      sentAt: DateTime.parse(json['sentAt'] as String),
      acceptedAt: json['acceptedAt'] == null
          ? null
          : DateTime.parse(json['acceptedAt'] as String),
    );

Map<String, dynamic> _$FriendshipRequestToJson(FriendshipRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'status': instance.status,
      'sentAt': instance.sentAt.toIso8601String(),
      'acceptedAt': instance.acceptedAt?.toIso8601String(),
    };
