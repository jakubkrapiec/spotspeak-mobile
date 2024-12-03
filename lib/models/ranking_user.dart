import 'package:json_annotation/json_annotation.dart';
import 'package:spotspeak_mobile/models/other_user.dart';

part 'ranking_user.g.dart';

@JsonSerializable()
class RankingUser implements OtherUser {
  const RankingUser({
    required this.rankNumber,
    required this.friendId,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.profilePictureUrl,
    required this.totalPoints,
  });

  factory RankingUser.fromJson(Map<String, Object?> json) => _$RankingUserFromJson(json);

  @override
  String get id => friendId;

  final int rankNumber;
  final String friendId;

  @override
  final String username;
  final String firstName;
  final String lastName;

  @override
  final Uri? profilePictureUrl;

  @override
  final int totalPoints;

  @override
  Map<String, Object?> toJson() => _$RankingUserToJson(this);
}
