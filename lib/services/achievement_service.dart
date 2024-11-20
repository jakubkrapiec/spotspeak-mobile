import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:spotspeak_mobile/models/achievement.dart';
import 'package:spotspeak_mobile/models/achievement_details.dart';
import 'package:spotspeak_mobile/models/other_user.dart';

part 'achievement_service.g.dart';

@singleton
@RestApi(baseUrl: '/api/achievements')
abstract class AchievementService {
  @factoryMethod
  factory AchievementService(Dio dio) = _AchievementService;

  @GET('/{userId}')
  Future<List<Achievement>> getAchievements(@Path() String userId);

  @GET('/my')
  Future<List<Achievement>> getUsersAchievements();

  @GET('/details/{userAchievementId}')
  Future<AchievementDetails> getAchievementDetails(@Path() int userAchievementId);

  @GET('/details/{userAchievementId}/friends')
  Future<List<OtherUser>> getAchievementFriends(@Path() int userAchievementId);
}
