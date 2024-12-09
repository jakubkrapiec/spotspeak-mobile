import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:spotspeak_mobile/models/achievement.dart';
import 'package:spotspeak_mobile/models/achievement_details.dart';
import 'package:spotspeak_mobile/models/other_user.dart';
import 'package:spotspeak_mobile/services/achievement_service.dart';

part 'achievement_service_impl.g.dart';

@prod
@Singleton(as: AchievementService)
@RestApi(baseUrl: '/api/achievements')
abstract class AchievementServiceImpl implements AchievementService {
  @factoryMethod
  factory AchievementServiceImpl(Dio dio) = _AchievementServiceImpl;

  @override
  @GET('/{userId}')
  Future<List<Achievement>> getAchievements(@Path() String userId);

  @override
  @GET('/my')
  Future<List<Achievement>> getMyAchievements();

  @override
  @GET('/details/{userAchievementId}')
  Future<AchievementDetails> getAchievementDetails(@Path() int userAchievementId);

  @override
  @GET('/details/{userAchievementId}/friends')
  Future<List<OtherUser>> getAchievementFriends(@Path() int userAchievementId);
}
