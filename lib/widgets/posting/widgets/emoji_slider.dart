import 'package:flutter/material.dart';
import 'package:mission_diary/global/enum.dart';
import 'package:mission_diary/util/calculate_util.dart';
import 'package:rive/rive.dart';

class EmojiSlider extends StatefulWidget {
  const EmojiSlider({
    super.key,
    required this.score,
  });

  final double score;

  @override
  State<EmojiSlider> createState() => _EmojiSliderState();
}

class _EmojiSliderState extends State<EmojiSlider> {
  late final StateMachineController _controller;
  late final SMINumber position;

  late double _selectedEmoji = _getPosition(widget.score);

  double _getPosition(double score) {
    Rank rank = getRank(score);
    switch (rank) {
      case Rank.F:
        return 0;
      case Rank.D:
        return 1;
      case Rank.C:
        return 2;
      case Rank.B:
        return 3;
      case Rank.A:
      case Rank.S:
        return 4;
    }
  }

  void onChangedEmoji(RiveEvent event) {
    final index = event.properties["position"];
    if (index != null) {
      _selectedEmoji = index;
    }
    print(_selectedEmoji);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: RiveAnimation.asset(
        "assets/animations/emoji_satisfaction_meter.riv",
        stateMachines: const ["State Machine 1"],
        onInit: (art) {
          _controller =
              StateMachineController.fromArtboard(art, "State Machine 1")!;
          _controller.addEventListener(onChangedEmoji);
          art.addController(_controller);

          position = _controller.findSMI("position");
          position.value = _getPosition(widget.score);
        },
        fit: BoxFit.contain,
        placeHolder: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
