import 'package:json_annotation/json_annotation.dart';

part 'achievement_details.g.dart';

@JsonSerializable()
class AchievementDetails {
  const AchievementDetails({
    required this.userAchievementId,
    required this.achievementName,
    required this.achievementDescription,
    required this.points,
    required this.resourceAccessUrl,
    required this.requiredQuantity,
    required this.quantityProgress,
    required this.currentStreak,
    required this.endTime,
    required this.completedAt,
  });

  factory AchievementDetails.fromJson(Map<String, Object?> json) => _$AchievementDetailsFromJson(json);

  final int userAchievementId;
  final String achievementName;
  final String achievementDescription;
  final int points;
  final String resourceAccessUrl;
  final int requiredQuantity;
  final int quantityProgress;
  final int currentStreak;
  final DateTime? endTime;
  final DateTime? completedAt;

  Duration? get timeLeft => endTime?.difference(DateTime.now());

  Map<String, Object?> toJson() => _$AchievementDetailsToJson(this);
}
