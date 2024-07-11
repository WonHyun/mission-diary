import 'package:flutter/material.dart';
import 'package:mission_diary/global/color.dart';
import 'package:mission_diary/global/sizes.dart';
import 'package:mission_diary/global/value.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.iconSize = Sizes.size18,
  });

  final Function() onTap;
  final IconData icon;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context)
                .colorScheme
                .primary
                .withOpacity(isDarkMode(context) ? 1.0 : 0.5),
          ],
          stops: const [0.5, 1.0],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: ThemeColors.slateDarkBlue.withOpacity(0.5),
          borderRadius: BorderRadius.circular(360),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(Sizes.size12),
            child: Icon(
              icon,
              color: Colors.white,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
