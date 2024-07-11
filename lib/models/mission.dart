import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mission_diary/global/enum.dart';

part 'mission.freezed.dart';
part 'mission.g.dart';

@freezed
class Mission with _$Mission {
  const factory Mission({
    required String missionId,
    required String userId,
    required DateTime createdAt,
    required MissionType type,
    required bool isCompleted,
    required bool isNeedPhoto,
    required MissionFrequency frequency,
    required String title,
    required String description,
    required DateTime startAt,
    required DateTime endAt,
    required Duration duration,
    required bool isPrivate,
    required List<String> tag,
    required List<String> mediaUrlList,
  }) = _Mission;

  factory Mission.fromJson(Map<String, dynamic> json) =>
      _$MissionFromJson(json);
}
