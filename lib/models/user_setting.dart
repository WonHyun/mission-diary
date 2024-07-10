import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_setting.freezed.dart';
part 'user_setting.g.dart';

@freezed
class UserSetting with _$UserSetting {
  const factory UserSetting({
    required ThemeMode themeMode,
    required String language,
    required bool isAllowNotification,
    required bool isAllowNotificationRing,
  }) = _UserSetting;

  factory UserSetting.fromJson(Map<String, dynamic> json) =>
      _$UserSettingFromJson(json);
}
