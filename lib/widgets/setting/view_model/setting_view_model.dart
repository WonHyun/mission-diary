import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/models/user_setting.dart';
import 'package:mission_diary/widgets/setting/repo/setting_repository.dart';

class SettingViewModel extends Notifier<UserSetting> {
  late final SettingRepository _repository;

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    if (state.themeMode != themeMode) {
      await _repository.setThemeMode(themeMode);
      state = state.copyWith(themeMode: themeMode);
    }
  }

  Future<void> updateLanguage(String language) async {
    if (state.language != language) {
      await _repository.setLanguage(language);
      state = state.copyWith(language: language);
    }
  }

  Future<void> updateIsAllowNotification(bool isAllowNotification) async {
    if (state.isAllowNotification != isAllowNotification) {
      await _repository.setIsAllowNotification(isAllowNotification);
      state = state.copyWith(isAllowNotification: isAllowNotification);
    }
  }

  Future<void> updateIsAllowNotificationRing(
      bool isAllowNotificationRing) async {
    if (state.isAllowNotificationRing != isAllowNotificationRing) {
      await _repository.setIsAllowNotificationRing(isAllowNotificationRing);
      state = state.copyWith(isAllowNotificationRing: isAllowNotificationRing);
    }
  }

  @override
  UserSetting build() {
    _repository = ref.read(settingRepo);
    return UserSetting(
      themeMode: _repository.getThemeMode(),
      language: _repository.getLanguage(),
      isAllowNotification: _repository.getIsAllowNotification(),
      isAllowNotificationRing: _repository.getIsAllowNotificationRing(),
    );
  }
}

final settingProvider = NotifierProvider<SettingViewModel, UserSetting>(
  () => SettingViewModel(),
);
