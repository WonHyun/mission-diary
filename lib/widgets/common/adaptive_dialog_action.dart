import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdaptiveDialogAction extends StatelessWidget {
  const AdaptiveDialogAction({
    super.key,
    required this.context,
    required this.onPressed,
    required this.child,
  });

  final BuildContext context;
  final Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    if (kIsWeb) {
      return TextButton(onPressed: onPressed, child: child);
    } else {
      switch (theme.platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          return TextButton(onPressed: onPressed, child: child);
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          return CupertinoDialogAction(onPressed: onPressed, child: child);
      }
    }
  }
}
