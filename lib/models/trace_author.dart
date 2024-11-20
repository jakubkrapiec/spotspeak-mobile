import 'package:json_annotation/json_annotation.dart';

part 'trace_author.g.dart';

@JsonSerializable()
class TraceAuthor {
  const TraceAuthor({
    required this.id,
    required this.username,
    required this.profilePictureUrl,
  });

  factory TraceAuthor.fromJson(Map<String, Object?> json) => _$TraceAuthorFromJson(json);

  final String id;
  final String username;
  final String? profilePictureUrl;

  Map<String, Object?> toJson() => _$TraceAuthorToJson(this);
}
