// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Achievement _$AchievementFromJson(Map<String, dynamic> json) => Achievement(
      userAchievementId: (json['userAchievementId'] as num).toInt(),
      achievementName: json['achievementName'] as String,
      resourceAccessUrl: json['resourceAccessUrl'] as String,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$AchievementToJson(Achievement instance) =>
    <String, dynamic>{
      'userAchievementId': instance.userAchievementId,
      'achievementName': instance.achievementName,
      'resourceAccessUrl': instance.resourceAccessUrl,
      'completedAt': instance.completedAt?.toIso8601String(),
    };
