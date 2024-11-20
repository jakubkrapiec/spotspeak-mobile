// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_user_view.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtherUserView _$OtherUserViewFromJson(Map<String, dynamic> json) =>
    OtherUserView(
      userProfile:
          OtherUser.fromJson(json['userProfile'] as Map<String, dynamic>),
      totalPoints: (json['totalPoints'] as num).toInt(),
      friendshipStatus: json['friendshipStatus'] as String,
    );

Map<String, dynamic> _$OtherUserViewToJson(OtherUserView instance) =>
    <String, dynamic>{
      'userProfile': instance.userProfile,
      'totalPoints': instance.totalPoints,
      'friendshipStatus': instance.friendshipStatus,
    };
