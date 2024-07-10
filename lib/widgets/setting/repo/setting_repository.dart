import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mission_diary/global/enum.dart';

class SettingRepository {
  Future<void> setThemeMode(ThemeMode themeMode) async {
    await Hive.box(BoxName.settings.name).put(
      UserSetting.themeMode.name,
      themeMode.index,
    );
  }

  ThemeMode getThemeMode() {
    final themeModeIndex =
        Hive.box(BoxName.settings.name).get(UserSetting.themeMode.name) ??
            ThemeMode.system.index;
    return ThemeMode.values[themeModeIndex];
  }

  Future<void> setLanguage(String language) async {
    await Hive.box(BoxName.settings.name).put(
      UserSetting.language.name,
      language,
    );
  }

  String getLanguage() {
    return Hive.box(BoxName.settings.name).get(UserSetting.language.name) ??
        "en";
  }

  Future<void> setIsAllowNotification(bool isAllowNotification) async {
    await Hive.box(BoxName.settings.name).put(
      UserSetting.isAllowNotification.name,
      isAllowNotification,
    );
  }

  bool getIsAllowNotification() {
    return Hive.box(BoxName.settings.name)
            .get(UserSetting.isAllowNotification.name) ??
        true;
  }

  Future<void> setIsAllowNotificationRing(bool isAllowNotificationRing) async {
    await Hive.box(BoxName.settings.name).put(
      UserSetting.isAllowNotificationRing.name,
      isAllowNotificationRing,
    );
  }

  bool getIsAllowNotificationRing() {
    return Hive.box(BoxName.settings.name)
            .get(UserSetting.isAllowNotificationRing.name) ??
        true;
  }
}

final settingRepo = Provider((ref) => SettingRepository());
