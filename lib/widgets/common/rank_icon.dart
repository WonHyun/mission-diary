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
    this.size = Sizes.size16,
    this.useInSurface = false,
  });

  final Rank rank;
  final double size;
  final bool useInSurface;

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

  Color _getRankColor(BuildContext context, Rank rank) {
    switch (rank) {
      case Rank.F:
        return Colors.red;
      case Rank.D:
      case Rank.C:
        return useInSurface
            ? Theme.of(context).colorScheme.inverseSurface
            : Theme.of(context).colorScheme.surface;
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
      padding: const EdgeInsets.all(Sizes.size12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: Sizes.size3,
          color: _getRankColor(context, rank),
        ),
      ),
      child: Column(
        children: [
          Text(
            "Rank",
            style: TextStyle(
              color: _getRankColor(context, rank),
              fontSize: size,
            ),
          ),
          Gaps.v5,
          Icon(
            _getRankIcon(rank),
            color: _getRankColor(context, rank),
            size: size,
          ),
        ],
      ),
    );
  }
}
