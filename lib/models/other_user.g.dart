// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtherUser _$OtherUserFromJson(Map<String, dynamic> json) => OtherUser(
      id: json['id'] as String,
      username: json['username'] as String,
      totalPoints: (json['totalPoints'] as num?)?.toInt(),
      profilePictureUrl: json['profilePictureUrl'] == null
          ? null
          : Uri.parse(json['profilePictureUrl'] as String),
    );

Map<String, dynamic> _$OtherUserToJson(OtherUser instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'totalPoints': instance.totalPoints,
      'profilePictureUrl': instance.profilePictureUrl?.toString(),
    };
