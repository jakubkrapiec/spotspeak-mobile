// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteFile _$RemoteFileFromJson(Map<String, dynamic> json) => RemoteFile(
      id: (json['id'] as num).toInt(),
      resourceKey: json['resourceKey'] as String,
      fileType: json['fileType'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$RemoteFileToJson(RemoteFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'resourceKey': instance.resourceKey,
      'fileType': instance.fileType,
      'createdAt': instance.createdAt.toIso8601String(),
    };
