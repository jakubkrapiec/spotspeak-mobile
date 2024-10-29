// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      profilePicture:
          RemoteFile.fromJson(json['profilePicture'] as Map<String, dynamic>),
      traces: (json['traces'] as List<dynamic>)
          .map((e) => Trace.fromJson(e as Map<String, dynamic>))
          .toList(),
      achievements: (json['achievements'] as List<dynamic>)
          .map((e) => Achievement.fromJson(e as Map<String, dynamic>))
          .toList(),
      sentRequests: (json['sentRequests'] as List<dynamic>)
          .map((e) => FriendshipRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      receivedRequests: (json['receivedRequests'] as List<dynamic>)
          .map((e) => FriendshipRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      registeredAt: DateTime.parse(json['registeredAt'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'username': instance.username,
      'email': instance.email,
      'profilePicture': instance.profilePicture,
      'traces': instance.traces,
      'achievements': instance.achievements,
      'sentRequests': instance.sentRequests,
      'receivedRequests': instance.receivedRequests,
      'registeredAt': instance.registeredAt.toIso8601String(),
    };
