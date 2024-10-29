import 'package:json_annotation/json_annotation.dart';
import 'package:spotspeak_mobile/models/achievement.dart';

part 'achievement_progress.g.dart';

@JsonSerializable()
class AchievementProgress {
  const AchievementProgress({
    required this.id,
    required this.user,
    required this.achievement,
    required this.quantityProgress,
    required this.completedAt,
  });

  factory AchievementProgress.fromJson(Map<String, Object?> json) => _$AchievementProgressFromJson(json);

  final int id;
  final String user;
  final Achievement achievement;
  final num quantityProgress;
  final DateTime completedAt;

  Map<String, Object?> toJson() => _$AchievementProgressToJson(this);
}
