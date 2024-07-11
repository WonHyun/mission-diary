import 'package:flutter/material.dart';
import 'package:mission_diary/global/breakpoint.dart';
import 'package:mission_diary/global/sizes.dart';

class ConstraintedBody extends StatelessWidget {
  const ConstraintedBody({
    super.key,
    required this.child,
    this.horizontalPadding = Sizes.size28,
    this.verticalPadding = Sizes.size28,
    this.constraints,
    this.alignment = Alignment.center,
  });

  final Widget child;
  final double horizontalPadding;
  final double verticalPadding;
  final BoxConstraints? constraints;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints:
            constraints ?? const BoxConstraints(maxWidth: ScreenWidth.sm),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: child,
        ),
      ),
    );
  }
}
