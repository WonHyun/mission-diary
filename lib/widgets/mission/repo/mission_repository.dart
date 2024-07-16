import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mission_diary/global/enum.dart';
import 'package:mission_diary/models/mission.dart';

class MissionRepository {
  Future<void> saveMission(Mission mission) async {
    await Hive.box(BoxName.missions.name).put(
      mission.missionId,
      mission.toJson(),
    );
  }

  Future<void> updateMission(String missionId) async {}

  Future<Mission?> fetchMission(String missionId) async {
    return await Hive.box(BoxName.missions.name).get(missionId);
  }

  Future<List<Mission>> fetchAllMissions() async {
    List<Mission> list = [];
    final box = Hive.box(BoxName.missions.name);

    final keys = box.keys;
    for (final key in keys) {
      final data = await box.get(key);
      if (data != null && data is Map) {
        final Map<String, dynamic> json = data.map((key, value) {
          if (key is String) {
            return MapEntry(key, value);
          } else {
            return MapEntry(key.toString(), value);
          }
        });
        list.add(Mission.fromJson(json));
      }
    }
    return list;
  }
}

final missionRepo = Provider((ref) => MissionRepository());
