import 'package:json_annotation/json_annotation.dart';
import 'package:spotspeak_mobile/models/other_user.dart';

part 'friendship.g.dart';

@JsonSerializable()
class Friendship {
  const Friendship({required this.id, required this.friendInfo, required this.createdAt});

  factory Friendship.fromJson(Map<String, Object?> json) => _$FriendshipFromJson(json);

  final int id;
  final OtherUser friendInfo;
  final DateTime createdAt;

  Map<String, Object?> toJson() => _$FriendshipToJson(this);
}
