import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mission_diary/global/sizes.dart';

class CheckCircle extends StatelessWidget {
  const CheckCircle({
    super.key,
    this.isChecked = false,
    this.size = Sizes.size24,
  });

  final bool isChecked;
  final double size;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isChecked
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface,
      ),
      child: FaIcon(
        FontAwesomeIcons.check,
        size: size / 2,
        color: Colors.white,
      ),
    );
  }
}
