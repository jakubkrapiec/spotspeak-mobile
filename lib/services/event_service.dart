import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:spotspeak_mobile/models/event_location.dart';

part 'event_service.g.dart';

@singleton
@RestApi(baseUrl: '/api/events')
// ignore: one_member_abstracts
abstract class EventService {
  @factoryMethod
  factory EventService(Dio dio) = _EventService;

  @GET('/nearby')
  Future<List<EventLocation>> getNearbyEvents({
    @Query('longitude') required double longitude,
    @Query('latitude') required double latitude,
    @Query('distance') required int distance,
  });
}
