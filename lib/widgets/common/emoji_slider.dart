import 'package:flutter/material.dart';
import 'package:mission_diary/global/enum.dart';
import 'package:mission_diary/util/calculate_util.dart';
import 'package:rive/rive.dart';
import 'package:visibility_detector/visibility_detector.dart';

class EmojiSlider extends StatefulWidget {
  const EmojiSlider({
    super.key,
    required this.score,
    this.height = 200,
  });

  final double score;
  final double height;

  @override
  State<EmojiSlider> createState() => _EmojiSliderState();
}

class _EmojiSliderState extends State<EmojiSlider> {
  final GlobalKey _key = GlobalKey();

  StateMachineController? _controller;
  SMINumber? position;

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

  void _onVisiblityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 0) {
      _controller?.isActive = false;
    } else {
      _controller?.isActive = true;
    }
  }

  void _onInitAnimation(Artboard art) {
    _controller = StateMachineController.fromArtboard(art, "State Machine 1");
    if (_controller != null) {
      _controller!.addEventListener(onChangedEmoji);
      _controller!.isActive = false;
      art.addController(_controller!);

      position = _controller!.findSMI("position");
      position?.value = _getPosition(widget.score);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _key,
      onVisibilityChanged: _onVisiblityChanged,
      child: SizedBox(
        height: widget.height,
        child: RiveAnimation.asset(
          "assets/animations/emoji_satisfaction_meter.riv",
          stateMachines: const ["State Machine 1"],
          onInit: _onInitAnimation,
          fit: BoxFit.contain,
          placeHolder: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
