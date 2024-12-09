import 'package:spotspeak_mobile/models/ranking_user.dart';

// ignore: one_member_abstracts
abstract interface class RankingService {
  Future<List<RankingUser>> getRanking();
}
