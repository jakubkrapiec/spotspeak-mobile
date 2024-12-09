import 'package:injectable/injectable.dart';
import 'package:spotspeak_mobile/models/ranking_user.dart';
import 'package:spotspeak_mobile/services/ranking_service.dart';

@test
@Singleton(as: RankingService)
// ignore: one_member_abstracts
class RankingServiceMock implements RankingService {
  @override
  Future<List<RankingUser>> getRanking() => throw UnimplementedError();
}
