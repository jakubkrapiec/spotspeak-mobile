import 'package:json_annotation/json_annotation.dart';
import 'package:spotspeak_mobile/models/remote_file.dart';

part 'achievement.g.dart';

@JsonSerializable()
class Achievement {
  const Achievement({
    required this.id,
    required this.name,
    required this.description,
    required this.points,
    required this.iconUrl,
    required this.createdAt,
  });

  factory Achievement.fromJson(Map<String, Object?> json) => _$AchievementFromJson(json);

  final int id;
  final String name;
  final String description;
  final int points;
  final RemoteFile iconUrl;
  final DateTime createdAt;

  Map<String, Object?> toJson() => _$AchievementToJson(this);
}
