import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/global/sizes.dart';
import 'package:mission_diary/util/calculate_util.dart';
import 'package:mission_diary/util/date_util.dart';
import 'package:mission_diary/widgets/common/constrainted_body.dart';
import 'package:mission_diary/widgets/common/rounded_button.dart';
import 'package:mission_diary/widgets/home/view_model/mission_view_model.dart';
import 'package:mission_diary/widgets/posting/widgets/emoji_slider.dart';

class PostingScreen extends ConsumerStatefulWidget {
  const PostingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostingScreenState();
}

class _PostingScreenState extends ConsumerState<PostingScreen> {
  late double _score;

  @override
  void initState() {
    super.initState();
    _score = calculateScore(ref.read(missionProvider).value!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstraintedBody(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const FaIcon(
                      FontAwesomeIcons.chevronDown,
                      size: Sizes.size20,
                    ),
                  ),
                ],
              ),
              Text(
                getYYYYMMDD(DateTime.now()),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Gaps.v32,
              const Text("Today your Score is"),
              Gaps.v10,
              Text(
                "${_score.round()}",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Gaps.v10,
              const Text("Great Job !"),
              Gaps.v32,
              Text(
                "How satisfied are you today?",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              EmojiSlider(score: _score),
              Gaps.v32,
              RoundedButton(
                onTap: () => {},
                text: "Share",
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
