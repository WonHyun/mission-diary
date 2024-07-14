import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mission_diary/global/enum.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/global/sizes.dart';
import 'package:mission_diary/util/calculate_util.dart';
import 'package:mission_diary/widgets/common/constrainted_body.dart';
import 'package:mission_diary/widgets/common/rank_icon.dart';
import 'package:mission_diary/widgets/common/rounded_button.dart';
import 'package:mission_diary/widgets/feed/feed_screen.dart';
import 'package:mission_diary/widgets/home/view_model/mission_view_model.dart';
import 'package:mission_diary/widgets/posting/posting_screen.dart';
import 'package:mission_diary/widgets/common/emoji_slider.dart';

class MissionStatusScreen extends ConsumerStatefulWidget {
  const MissionStatusScreen({super.key});

  static const String routePath = "/mission-status";
  static const String routeName = "mission-status";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MissionStatusScreenState();
}

class _MissionStatusScreenState extends ConsumerState<MissionStatusScreen> {
  late double _score;
  late Rank _rank;

  String _getRankFeedback(Rank rank) {
    switch (rank) {
      case Rank.F:
        return "Don't give up!";
      case Rank.D:
        return "Needs improvement. Try more!";
      case Rank.C:
        return "Decent work. You can try more!";
      case Rank.B:
        return "Good Effort!";
      case Rank.A:
        return "Great Job!";
      case Rank.S:
        return "Perfect Day!";
    }
  }

  Future<void> _onTapGotoShare() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PostingScreen(),
      ),
    );
    if (result != null) {
      if (mounted) {
        context.goNamed(FeedScreen.routeName);
        context.pop();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _score = calculateScore(ref.read(missionProvider).value!);
    _rank = getRank(_score);
  }

  @override
  Widget build(BuildContext context) {
    final missions = ref.watch(missionProvider).value!;
    return Scaffold(
      body: ConstraintedBody(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                leading: IconButton(
                  onPressed: () => context.pop(),
                  icon: const FaIcon(
                    FontAwesomeIcons.chevronDown,
                    size: Sizes.size20,
                  ),
                ),
                title: Text(
                  "Mission Status",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Gaps.v20,
              Text(
                "Completed Mission",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Gaps.v5,
              Text(
                "${missions.where((mission) => mission.isCompleted).length} / ${missions.length}",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Gaps.v10,
              Text(
                "Total Score",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Gaps.v5,
              Text(
                "${_score.round()}",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Gaps.v20,
              Text(
                "Today's your Rank is",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Gaps.v16,
              RankIcon(
                rank: _rank,
                useInSurface: true,
              ),
              Gaps.v16,
              Text(
                _getRankFeedback(_rank),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              EmojiSlider(score: _score, height: 150),
              Gaps.v32,
              RoundedButton(
                onTap: _onTapGotoShare,
                text: "Go to Share",
                fontColor: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
