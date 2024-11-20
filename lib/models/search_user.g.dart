// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchUser _$SearchUserFromJson(Map<String, dynamic> json) => SearchUser(
      id: json['id'] as String,
      username: json['username'] as String,
      profilePictureUrl: json['profilePictureUrl'] == null
          ? null
          : Uri.parse(json['profilePictureUrl'] as String),
    );

Map<String, dynamic> _$SearchUserToJson(SearchUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'profilePictureUrl': instance.profilePictureUrl?.toString(),
    };
