// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_user_view.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtherUserView _$OtherUserViewFromJson(Map<String, dynamic> json) =>
    OtherUserView(
      userProfile:
          OtherUser.fromJson(json['userProfile'] as Map<String, dynamic>),
      relationshipStatus:
          $enumDecode(_$FriendshipStatusEnumMap, json['relationshipStatus']),
    );

Map<String, dynamic> _$OtherUserViewToJson(OtherUserView instance) =>
    <String, dynamic>{
      'userProfile': instance.userProfile,
      'relationshipStatus':
          _$FriendshipStatusEnumMap[instance.relationshipStatus]!,
    };

const _$FriendshipStatusEnumMap = {
  FriendshipStatus.friends: 'FRIENDS',
  FriendshipStatus.noRelation: 'NO_RELATION',
  FriendshipStatus.invitationSent: 'INVITATION_SENT',
  FriendshipStatus.invitationReceived: 'INVITATION_RECEIVED',
};
