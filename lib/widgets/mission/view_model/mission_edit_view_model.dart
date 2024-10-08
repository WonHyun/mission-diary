import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/global/enum.dart';
import 'package:mission_diary/models/mission.dart';
import 'package:mission_diary/util/date_util.dart';
import 'package:mission_diary/util/generate_util.dart';
import 'package:mission_diary/widgets/home/view_model/mission_list_view_model.dart';
import 'package:mission_diary/widgets/mission/repo/mission_repository.dart';
import 'package:mission_diary/widgets/user_profile/view_model/user_profile_view_model.dart';

class MissionEditViewModel
    extends AutoDisposeFamilyAsyncNotifier<Mission, MissionType> {
  late final MissionRepository _repository;

  static const minuteInterval = 5;
  static const minDuration = Duration(minutes: 5);

  @override
  FutureOr<Mission> build(MissionType arg) {
    final user = ref.read(profileProvider).value;
    _repository = ref.read(missionRepo);

    return Mission(
      missionId: uuid.v4(),
      userId: user!.userId,
      createdAt: DateTime.now(),
      type: arg,
      isCompleted: false,
      isNeedPhoto: false,
      isAllDay: false,
      frequency: MissionFrequency.once,
      title: "",
      description: "",
      startAt: adjustMinute(DateTime.now(), minuteInterval),
      endAt: adjustMinute(DateTime.now().add(minDuration), minuteInterval),
      duration: minDuration,
      isPrivate: false,
      tag: [],
      mediaList: [],
    );
  }

  void updateTitle(String title) {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(title: title));
  }

  void updateDescriptiong(String description) {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(description: description));
  }

  void updateStartAt(DateTime startAt) {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(startAt: startAt));
  }

  void updateEndAt(DateTime endAt) {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(endAt: endAt));
  }

  void updateDuration(Duration duration) {
    if (state.value == null) return;
    state = AsyncValue.data(
      state.value!.copyWith(
          duration: duration,
          startAt: adjustMinute(DateTime.now(), minuteInterval),
          endAt: adjustMinute(DateTime.now().add(duration), minuteInterval)),
    );
  }

  void updateIsNeedPhoto(bool isNeedPhoto) {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(isNeedPhoto: isNeedPhoto));
  }

  void updateIsPrivate(bool isPrivate) {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(isPrivate: isPrivate));
  }

  void updateIsAllDay(bool isAllDay) {
    if (state.value == null) return;
    if (isAllDay) {
      final now = DateTime.now();
      state = AsyncValue.data(
        state.value!.copyWith(
          isAllDay: isAllDay,
          startAt: DateTime(now.year, now.month, now.day),
          endAt: DateTime(now.year, now.month, now.day, 23, 59, 59),
        ),
      );
    } else {
      state = AsyncValue.data(
        state.value!.copyWith(
            isAllDay: isAllDay,
            startAt: adjustMinute(DateTime.now(), minuteInterval),
            endAt: adjustMinute(
                DateTime.now().add(state.value!.duration), minuteInterval)),
      );
    }
  }

  void updateFrequency(MissionFrequency frequency) {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(frequency: frequency));
  }

  Future<String?> createNewMission() async {
    final user = ref.read(profileProvider).value;
    if (user == null || state.value == null) {
      return "Unknown Exception during create mission, please try later.";
    }

    final now = DateTime.now();
    if (!state.value!.isAllDay &&
        state.value!.startAt.isBefore(
            DateTime(now.year, now.month, now.day, now.hour, now.minute, 59))) {
      state = AsyncValue.data(
        state.value!.copyWith(
            startAt: adjustMinute(DateTime.now(), minuteInterval),
            endAt: adjustMinute(
                DateTime.now().add(state.value!.duration), minuteInterval)),
      );
      return "The start date cannot be later than the current date. It will be adjusted automatically.";
    }

    state = await AsyncValue.guard(
      () async {
        await _repository.saveMission(state.value!);
        ref.read(missionListProvider.notifier).refreshMissions();
        return state.value!;
      },
    );
    if (state.hasError) {
      if (state.error != null) {
        return state.error.toString();
      } else {
        return "Unknown Exception during create mission, please try later.";
      }
    }
    return null;
  }
}

final missionEditProvider = AsyncNotifierProvider.family
    .autoDispose<MissionEditViewModel, Mission, MissionType>(
  () => MissionEditViewModel(),
);
