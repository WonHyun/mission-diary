import 'package:mission_diary/global/enum.dart';
import 'package:mission_diary/models/mission.dart';

double calculateScore(List<Mission> missions) {
  double score = 0;
  for (var mission in missions) {
    if (mission.isCompleted) {
      double addScore = 100 / missions.length;
      switch (mission.frequency) {
        case MissionFrequency.once:
          addScore = addScore * 1.0;
        case MissionFrequency.daily:
          addScore = addScore * 0.98;
        case MissionFrequency.weekly:
        case MissionFrequency.monthly:
          addScore = addScore * 0.95;
      }

      final duration = mission.duration > const Duration(minutes: 15)
          ? mission.duration
          : mission.startAt.difference(mission.endAt);

      switch (duration) {
        case >= const Duration(minutes: 15) && < const Duration(minutes: 30):
          addScore = addScore * 0.9;
        case >= const Duration(minutes: 30) && < const Duration(minutes: 60):
          addScore = addScore * 0.95;
        case > const Duration(minutes: 60):
          addScore = addScore * 1.0;
      }

      score = score + addScore;
    }
  }
  return missions.lastIndexWhere((mission) => !mission.isCompleted) < 0
      ? 100
      : score;
}

Rank getRank(double score) {
  switch (score) {
    case >= 100:
      return Rank.S;
    case >= 70 && < 100:
      return Rank.A;
    case >= 50 && < 70:
      return Rank.B;
    case >= 30 && < 50:
      return Rank.C;
    case >= 10 && < 30:
      return Rank.D;
    case >= 0 && < 10:
    default:
      return Rank.F;
  }
}
