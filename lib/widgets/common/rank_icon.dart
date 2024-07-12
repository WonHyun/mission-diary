import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mission_diary/global/enum.dart';

class RankIcon extends StatelessWidget {
  const RankIcon({
    super.key,
    required this.rank,
    this.size = 30,
  });

  final Rank rank;
  final double size;

  @override
  Widget build(BuildContext context) {
    return const FaIcon(FontAwesomeIcons.circle);
  }
}
