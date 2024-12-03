// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentAuthor _$ContentAuthorFromJson(Map<String, dynamic> json) =>
    ContentAuthor(
      id: json['id'] as String,
      username: json['username'] as String,
      profilePictureUrl: json['profilePictureUrl'] == null
          ? null
          : Uri.parse(json['profilePictureUrl'] as String),
    );

Map<String, dynamic> _$ContentAuthorToJson(ContentAuthor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'profilePictureUrl': instance.profilePictureUrl?.toString(),
    };
