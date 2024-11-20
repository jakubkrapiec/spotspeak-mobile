// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtherUser _$OtherUserFromJson(Map<String, dynamic> json) => OtherUser(
      id: json['id'] as String,
      username: json['username'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      profilePictureUrl: json['profilePictureUrl'] == null
          ? null
          : Uri.parse(json['profilePictureUrl'] as String),
    );

Map<String, dynamic> _$OtherUserToJson(OtherUser instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'profilePictureUrl': instance.profilePictureUrl?.toString(),
    };
