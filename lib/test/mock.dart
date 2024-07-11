import 'package:faker/faker.dart';
import 'package:mission_diary/global/enum.dart';
import 'package:mission_diary/models/mission.dart';
import 'package:mission_diary/util/generate_util.dart';

class MissionMock {
  static final testMission = List.generate(
    10,
    (index) {
      return Mission(
        missionId: uuid.v4(),
        userId: uuid.v4(),
        createdAt: DateTime.now(),
        type: MissionType.reading,
        isCompleted: false,
        isNeedPhoto: true,
        frequency: MissionFrequency.once,
        title: faker.sport.name(),
        description: faker.lorem.sentence(),
        startAt: DateTime.now(),
        endAt: DateTime.now(),
        duration: const Duration(minutes: 30),
        isPrivate: false,
        tag: [],
        mediaUrlList: [
          "https://picsum.photos/200?random=${faker.randomGenerator.integer(500)}",
          "https://picsum.photos/200?random=${faker.randomGenerator.integer(500)}",
          "https://picsum.photos/200?random=${faker.randomGenerator.integer(500)}"
        ],
      );
    },
  );
}
