import 'package:json_annotation/json_annotation.dart';
import 'package:spotspeak_mobile/models/achievement.dart';
import 'package:spotspeak_mobile/models/friendship_request.dart';
import 'package:spotspeak_mobile/models/remote_file.dart';
import 'package:spotspeak_mobile/models/trace.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.profilePicture,
    required this.traces,
    required this.achievements,
    required this.sentRequests,
    required this.receivedRequests,
    required this.registeredAt,
  });

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);

  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final RemoteFile profilePicture;
  final List<Trace> traces;
  final List<Achievement> achievements;
  final List<FriendshipRequest> sentRequests;
  final List<FriendshipRequest> receivedRequests;
  final DateTime registeredAt;

  Map<String, Object?> toJson() => _$UserToJson(this);
}
