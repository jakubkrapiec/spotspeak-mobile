import 'package:injectable/injectable.dart';
import 'package:spotspeak_mobile/models/achievement.dart';
import 'package:spotspeak_mobile/models/achievement_details.dart';
import 'package:spotspeak_mobile/models/other_user.dart';
import 'package:spotspeak_mobile/services/achievement_service.dart';

@test
@Singleton(as: AchievementService)
class AchievementServiceMock implements AchievementService {
  @override
  Future<List<Achievement>> getAchievements(String userId) => throw UnimplementedError();

  @override
  Future<List<Achievement>> getMyAchievements() => throw UnimplementedError();

  @override
  Future<AchievementDetails> getAchievementDetails(int userAchievementId) => throw UnimplementedError();

  @override
  Future<List<OtherUser>> getAchievementFriends(int userAchievementId) => throw UnimplementedError();
}
