import 'package:json_annotation/json_annotation.dart';

part 'achievement.g.dart';

@JsonSerializable()
class Achievement {
  const Achievement({
    required this.userAchievementId,
    required this.achievementName,
    required this.resourceAccessUrl,
    required this.completedAt,
  });

  factory Achievement.fromJson(Map<String, Object?> json) => _$AchievementFromJson(json);

  final int userAchievementId;
  final String achievementName;
  final String resourceAccessUrl;
  final DateTime? completedAt;

  Map<String, Object?> toJson() => _$AchievementToJson(this);
}
