import 'package:faker/faker.dart';
import 'package:mission_diary/global/enum.dart';
import 'package:mission_diary/models/mission.dart';
import 'package:mission_diary/models/post.dart';
import 'package:mission_diary/util/generate_util.dart';

class MissionMock {
  static final testMissions = List.generate(
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
          "https://picsum.photos/200?random=${faker.randomGenerator.integer(500)}",
        ],
      );
    },
  );
}

class PostMock {
  static final testPosts = List.generate(
    10,
    (index) {
      return Post(
        postId: uuid.v4(),
        authorId: uuid.v4(),
        authorUserName:
            "${capitalizeFirst(faker.color.commonColor())}${capitalizeFirst(faker.animal.name())}",
        authorImgPath: "https://avatars.githubusercontent.com/u/34933982?v=4",
        createdAt: DateTime.now(),
        editAt: DateTime.now(),
        title: faker.food.dish(),
        content: faker.lorem.sentence(),
        likes: faker.randomGenerator.integer(100),
        commentCounts: faker.randomGenerator.integer(100),
        score: faker.randomGenerator.integer(100),
        satisfiedScore: faker.randomGenerator.integer(5).toDouble(),
        mediaUrlList: [
          "https://picsum.photos/200?random=${faker.randomGenerator.integer(500)}",
          "https://picsum.photos/200?random=${faker.randomGenerator.integer(500)}",
          "https://picsum.photos/200?random=${faker.randomGenerator.integer(500)}",
        ],
        commentsIdList: [],
        missionsIdList: [],
      );
    },
  );
}
