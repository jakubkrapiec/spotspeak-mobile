// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AchievementDetails _$AchievementDetailsFromJson(Map<String, dynamic> json) =>
    AchievementDetails(
      userAchievementId: (json['userAchievementId'] as num).toInt(),
      achievementName: json['achievementName'] as String,
      achievementDescription: json['achievementDescription'] as String,
      points: (json['points'] as num).toInt(),
      resourceAccessUrl: json['resourceAccessUrl'] as String,
      requiredQuantity: (json['requiredQuantity'] as num).toInt(),
      quantityProgress: (json['quantityProgress'] as num).toInt(),
      currentStreak: (json['currentStreak'] as num).toInt(),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$AchievementDetailsToJson(AchievementDetails instance) =>
    <String, dynamic>{
      'userAchievementId': instance.userAchievementId,
      'achievementName': instance.achievementName,
      'achievementDescription': instance.achievementDescription,
      'points': instance.points,
      'resourceAccessUrl': instance.resourceAccessUrl,
      'requiredQuantity': instance.requiredQuantity,
      'quantityProgress': instance.quantityProgress,
      'currentStreak': instance.currentStreak,
      'endTime': instance.endTime?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
    };
