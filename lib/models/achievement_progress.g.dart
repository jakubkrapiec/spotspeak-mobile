// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AchievementProgress _$AchievementProgressFromJson(Map<String, dynamic> json) =>
    AchievementProgress(
      id: (json['id'] as num).toInt(),
      user: json['user'] as String,
      achievement:
          Achievement.fromJson(json['achievement'] as Map<String, dynamic>),
      quantityProgress: json['quantityProgress'] as num,
      completedAt: DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$AchievementProgressToJson(
        AchievementProgress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'achievement': instance.achievement,
      'quantityProgress': instance.quantityProgress,
      'completedAt': instance.completedAt.toIso8601String(),
    };
