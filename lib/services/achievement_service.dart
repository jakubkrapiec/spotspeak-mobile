import 'package:spotspeak_mobile/models/achievement.dart';
import 'package:spotspeak_mobile/models/achievement_details.dart';
import 'package:spotspeak_mobile/models/other_user.dart';

abstract interface class AchievementService {
  Future<List<Achievement>> getAchievements(String userId);
  Future<List<Achievement>> getMyAchievements();
  Future<AchievementDetails> getAchievementDetails(int userAchievementId);
  Future<List<OtherUser>> getAchievementFriends(int userAchievementId);
}
