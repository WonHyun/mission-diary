import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mission_diary/global/color.dart';
import 'package:mission_diary/global/enum.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/global/sizes.dart';

class RankIcon extends StatelessWidget {
  const RankIcon({
    super.key,
    required this.rank,
    this.size = Sizes.size24,
  });

  final Rank rank;
  final double size;

  IconData _getRankIcon(Rank rank) {
    switch (rank) {
      case Rank.F:
        return FontAwesomeIcons.f;
      case Rank.D:
        return FontAwesomeIcons.d;
      case Rank.C:
        return FontAwesomeIcons.c;
      case Rank.B:
        return FontAwesomeIcons.b;
      case Rank.A:
        return FontAwesomeIcons.a;
      case Rank.S:
        return FontAwesomeIcons.s;
    }
  }

  Color _getRankColor(Rank rank) {
    switch (rank) {
      case Rank.F:
        return Colors.red;
      case Rank.D:
      case Rank.C:
        return Colors.white;
      case Rank.B:
      case Rank.A:
        return ThemeColors.lightGreen;
      case Rank.S:
        return Colors.amber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(Sizes.size14),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: Sizes.size3,
          color: _getRankColor(rank),
        ),
      ),
      child: Column(
        children: [
          Text(
            "Rank",
            style: TextStyle(color: _getRankColor(rank)),
          ),
          Gaps.v5,
          Icon(
            _getRankIcon(rank),
            color: _getRankColor(rank),
            size: size,
          ),
        ],
      ),
    );
  }
}
