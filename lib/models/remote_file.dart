import 'package:json_annotation/json_annotation.dart';

part 'remote_file.g.dart';

@JsonSerializable()
class RemoteFile {
  const RemoteFile({required this.id, required this.resourceKey, required this.fileType, required this.createdAt});

  factory RemoteFile.fromJson(Map<String, Object?> json) => _$RemoteFileFromJson(json);

  final int id;
  final String resourceKey;
  final String fileType;
  final DateTime createdAt;

  Map<String, Object?> toJson() => _$RemoteFileToJson(this);
}
