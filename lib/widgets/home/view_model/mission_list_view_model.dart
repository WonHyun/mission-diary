import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/models/mission.dart';
import 'package:mission_diary/widgets/mission/repo/mission_repository.dart';

class MissionListViewModel extends AsyncNotifier<List<Mission>> {
  late final MissionRepository _repository;

  @override
  FutureOr<List<Mission>> build() async {
    _repository = ref.read(missionRepo);
    return await _fetchTodayMissions();
  }

  Future<List<Mission>> _fetchTodayMissions() async {
    final missions = await _repository.fetchAllMissions();
    return missions;
  }

  Future<void> refreshMissions() async {
    state = AsyncValue.data(await _fetchTodayMissions());
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

final missionListProvider =
    AsyncNotifierProvider<MissionListViewModel, List<Mission>>(
  () => MissionListViewModel(),
);
