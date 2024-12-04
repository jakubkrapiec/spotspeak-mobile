import 'package:json_annotation/json_annotation.dart';

part 'notification_settings_dto.g.dart';

@JsonSerializable()
class NotificationSettingsDto {
  NotificationSettingsDto({required this.receiveNotifications});

  factory NotificationSettingsDto.fromJson(Map<String, Object?> json) => _$NotificationSettingsDtoFromJson(json);

  final bool receiveNotifications;

  Map<String, Object?> toJson() => _$NotificationSettingsDtoToJson(this);
}
