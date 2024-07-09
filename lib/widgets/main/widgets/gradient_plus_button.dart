import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mission_diary/global/color.dart';
import 'package:mission_diary/global/sizes.dart';

class GradientPlusButton extends StatelessWidget {
  const GradientPlusButton({
    super.key,
    required this.onTap,
  });

  final Function() onTap;

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
            Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ],
          stops: const [0.5, 1.0],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: ThemeColors.slateDarkBlue.withOpacity(0.5),
          borderRadius: BorderRadius.circular(360),
          onTap: () => {},
          child: const Padding(
            padding: EdgeInsets.all(Sizes.size10),
            child: Icon(
              FontAwesomeIcons.plus,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
