import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SatisfiedEmoji extends StatelessWidget {
  const SatisfiedEmoji({
    super.key,
    required this.satisfiedScore,
    this.size = 30,
  });

  final double satisfiedScore;
  final double size;

  @override
  Widget build(BuildContext context) {
    return const FaIcon(FontAwesomeIcons.circle);
  }
}
