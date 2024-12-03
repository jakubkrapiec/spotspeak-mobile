import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:spotspeak_mobile/models/ranking_user.dart';

part 'ranking_service.g.dart';

@singleton
@RestApi(baseUrl: '/api/ranking')
// ignore: one_member_abstracts
abstract class RankingService {
  @factoryMethod
  factory RankingService(Dio dio) = _RankingService;

  @GET('')
  Future<List<RankingUser>> getRanking();
}
