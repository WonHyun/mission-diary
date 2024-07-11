import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/models/mission.dart';
import 'package:mission_diary/test/mock.dart';

class MissionViewModel extends AsyncNotifier<List<Mission>> {
  @override
  FutureOr<List<Mission>> build() {
    return MissionMock.testMission;
  }

  Future<List<Mission>> fetchTodayMissions() async {
    //TODO: will be fetch from firebase or hive
    return [];
  }

  Future<void> updateIsCompleted({
    required String missionId,
    required bool isCompleted,
  }) async {
    if (state.value == null) return;
    state = AsyncValue.data(
      state.value!.map(
        (mission) {
          if (mission.missionId == missionId) {
            return mission.copyWith(
              isCompleted: isCompleted,
            );
          }
          return mission;
        },
      ).toList(),
    );
  }
}

final missionProvider = AsyncNotifierProvider<MissionViewModel, List<Mission>>(
  () => MissionViewModel(),
);
