import 'package:spotspeak_mobile/models/event_location.dart';

// ignore: one_member_abstracts
abstract interface class EventService {
  Future<List<EventLocation>> getNearbyEvents({
    required double longitude,
    required double latitude,
    required int distance,
  });
}
