import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class IntroAnimation extends StatelessWidget {
  const IntroAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      "assets/animations/intro_animation.riv",
      fit: BoxFit.fitHeight,
      placeHolder: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
