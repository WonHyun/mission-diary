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
        type: MissionType
            .values[faker.randomGenerator.integer(MissionType.values.length)],
        isCompleted: false,
        isNeedPhoto: true,
        frequency: MissionFrequency.values[
            faker.randomGenerator.integer(MissionFrequency.values.length)],
        title: faker.sport.name(),
        description: faker.lorem.sentence(),
        startAt: DateTime.now(),
        endAt: DateTime.now(),
        duration: Duration(
            hours: faker.randomGenerator.boolean() ? 0 : 1,
            minutes: faker.randomGenerator.integer(60)),
        isPrivate: faker.randomGenerator.boolean(),
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
