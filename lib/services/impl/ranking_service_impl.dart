import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:spotspeak_mobile/models/ranking_user.dart';
import 'package:spotspeak_mobile/services/ranking_service.dart';

part 'ranking_service_impl.g.dart';

@Singleton(as: RankingService)
@RestApi(baseUrl: '/api/ranking')
// ignore: one_member_abstracts
abstract class RankingServiceImpl implements RankingService {
  @factoryMethod
  factory RankingServiceImpl(Dio dio) = _RankingServiceImpl;

  @override
  @GET('')
  Future<List<RankingUser>> getRanking();
}
