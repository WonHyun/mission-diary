import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum BoxName {
  settings,
}

enum MainNavigatorType {
  home,
  feed,
  activity,
  profile,
}

enum UserSetting {
  language,
  themeMode,
  isAllowNotification,
  isAllowNotificationRing,
}

enum MissionType {
  drink,
  exercise,
  reading,
  meal,
  wakeUp,
  sleep,
  coding,
  etc,
}

enum MissionFrequency {
  once,
  daily,
  weekly,
  monthly,
}

enum UserRank {
  bronze,
  silver,
  gold,
  platinum,
  diamond,
}

enum MediaPathType {
  file,
  url,
}

enum MediaType {
  image,
  video,
}

enum Rank { F, D, C, B, A, S }

enum PopupMenu {
  edit,
  share,
  report,
  delete,
}

extension PopupMenuExtension on PopupMenu {
  IconData get icon {
    switch (this) {
      case PopupMenu.edit:
        return FontAwesomeIcons.pen;
      case PopupMenu.share:
        return FontAwesomeIcons.shareFromSquare;
      case PopupMenu.report:
        return FontAwesomeIcons.flag;
      case PopupMenu.delete:
        return FontAwesomeIcons.trashCan;
    }
  }

  String get text {
    switch (this) {
      case PopupMenu.edit:
        return "Edit";
      case PopupMenu.share:
        return "Share";
      case PopupMenu.report:
        return "Report";
      case PopupMenu.delete:
        return "Delete";
    }
  }
}
