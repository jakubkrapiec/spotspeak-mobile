// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RankingUser _$RankingUserFromJson(Map<String, dynamic> json) => RankingUser(
      rankNumber: (json['rankNumber'] as num).toInt(),
      friendId: json['friendId'] as String,
      username: json['username'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      profilePictureUrl: json['profilePictureUrl'] == null
          ? null
          : Uri.parse(json['profilePictureUrl'] as String),
      totalPoints: (json['totalPoints'] as num).toInt(),
    );

Map<String, dynamic> _$RankingUserToJson(RankingUser instance) =>
    <String, dynamic>{
      'rankNumber': instance.rankNumber,
      'friendId': instance.friendId,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'profilePictureUrl': instance.profilePictureUrl?.toString(),
      'totalPoints': instance.totalPoints,
    };
