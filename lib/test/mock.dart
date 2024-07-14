import 'package:faker/faker.dart';
import 'package:mission_diary/global/enum.dart';
import 'package:mission_diary/models/media_item.dart';
import 'package:mission_diary/models/mission.dart';
import 'package:mission_diary/models/post.dart';
import 'package:mission_diary/util/calculate_util.dart';
import 'package:mission_diary/util/generate_util.dart';

class MockGenerater {
  static List<MediaItem> generateRandomMediaItem({
    int count = 3,
    int width = 160,
    int height = 100,
  }) {
    return List.generate(
      count,
      (index) {
        return MediaItem(
          mediaId: uuid.v4(),
          mediaType: MediaType.image,
          mediaPathType: MediaPathType.url,
          path:
              "https://picsum.photos/$width/$height/?random=${faker.randomGenerator.integer(500)}",
          metadata: {},
        );
      },
    );
  }

  static List<String> generateRandomMediaUrl({
    int count = 3,
    int width = 160,
    int height = 100,
  }) {
    return List.generate(
      count,
      (index) {
        return "https://picsum.photos/$width/$height/?random=${faker.randomGenerator.integer(500)}";
      },
    );
  }

  static List<Mission> generateRandomMission({
    int count = 10,
  }) {
    return List.generate(
      count,
      (index) {
        return Mission(
          missionId: uuid.v4(),
          userId: uuid.v4(),
          createdAt: DateTime.now(),
          type: MissionType
              .values[faker.randomGenerator.integer(MissionType.values.length)],
          isCompleted: faker.randomGenerator.boolean(),
          isNeedPhoto: faker.randomGenerator.boolean(),
          frequency: MissionFrequency.values[
              faker.randomGenerator.integer(MissionFrequency.values.length)],
          title: faker.sport.name(),
          description: faker.lorem.sentence(),
          startAt: DateTime.now(),
          endAt: DateTime.now(),
          duration: Duration(
              hours: faker.randomGenerator.boolean() ? 0 : 1,
              minutes: faker.randomGenerator.integer(60, min: 15)),
          isPrivate: faker.randomGenerator.boolean(),
          tag: [],
          mediaList: generateRandomMediaItem(
            count: faker.randomGenerator.integer(2, min: 1),
          ),
        );
      },
    );
  }

  static List<Post> generateRandomPost({
    int count = 10,
  }) {
    return List.generate(
      count,
      (index) {
        final missions = generateRandomMission(count: 5);
        final missionStatusSummary = {
          for (var mission in missions) mission.title: mission.isCompleted
        };

        double score = calculateScore(missions);

        return Post(
          postId: uuid.v4(),
          authorId: uuid.v4(),
          authorUserName:
              "${capitalizeFirst(faker.color.commonColor())}${capitalizeFirst(faker.animal.name())}",
          authorImgPath:
              "https://picsum.photos/100/100/?random=${faker.randomGenerator.integer(500)}",
          createdAt: DateTime.now(),
          editAt: DateTime.now(),
          content: faker.lorem.sentence(),
          likes: faker.randomGenerator.integer(100),
          commentCounts: faker.randomGenerator.integer(100),
          score: score,
          isReported: false,
          mediaUrlList: generateRandomMediaUrl(
            count: faker.randomGenerator.integer(4),
          ),
          commentsIdList: [],
          missionStatusSummary: missionStatusSummary,
        );
      },
    );
  }
}

class MissionMock {
  static final testMissions = MockGenerater.generateRandomMission(
    count: 10,
  );
}

class PostMock {
  static final testPosts = MockGenerater.generateRandomPost(
    count: 10,
  );
}
