import 'package:json_annotation/json_annotation.dart';
import 'package:spotspeak_mobile/models/other_user.dart';

part 'other_user_view.g.dart';

@JsonSerializable()
class OtherUserView {
  const OtherUserView({
    required this.userProfile,
    required this.totalPoints,
    required this.friendshipStatus,
  });

  factory OtherUserView.fromJson(Map<String, Object?> json) => _$OtherUserViewFromJson(json);

  final OtherUser userProfile;
  final int totalPoints;
  final String friendshipStatus;

  Map<String, Object?> toJson() => _$OtherUserViewToJson(this);
}
