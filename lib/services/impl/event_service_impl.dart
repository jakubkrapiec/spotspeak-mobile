import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:spotspeak_mobile/models/event_location.dart';
import 'package:spotspeak_mobile/services/event_service.dart';

part 'event_service_impl.g.dart';

@Singleton(as: EventService)
@RestApi(baseUrl: '/api/events')
// ignore: one_member_abstracts
abstract class EventServiceImpl implements EventService {
  @factoryMethod
  factory EventServiceImpl(Dio dio) = _EventServiceImpl;

  @override
  @GET('/nearby')
  Future<List<EventLocation>> getNearbyEvents({
    @Query('longitude') required double longitude,
    @Query('latitude') required double latitude,
    @Query('distance') required int distance,
  });
}
