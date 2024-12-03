import 'package:json_annotation/json_annotation.dart';
import 'package:spotspeak_mobile/models/friendship_status.dart';
import 'package:spotspeak_mobile/models/other_user.dart';

part 'other_user_view.g.dart';

@JsonSerializable()
class OtherUserView {
  const OtherUserView({
    required this.userProfile,
    required this.relationshipStatus,
  });

  factory OtherUserView.fromJson(Map<String, Object?> json) => _$OtherUserViewFromJson(json);

  final OtherUser userProfile;
  final FriendshipStatus relationshipStatus;

  Map<String, Object?> toJson() => _$OtherUserViewToJson(this);
}
