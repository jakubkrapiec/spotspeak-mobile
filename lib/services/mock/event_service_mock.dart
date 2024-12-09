import 'package:injectable/injectable.dart';
import 'package:spotspeak_mobile/models/event_location.dart';
import 'package:spotspeak_mobile/services/event_service.dart';

@test
@Singleton(as: EventService)
class EventServiceMock implements EventService {
  @override
  Future<List<EventLocation>> getNearbyEvents({
    required double longitude,
    required double latitude,
    required int distance,
  }) =>
      throw UnimplementedError();
}
