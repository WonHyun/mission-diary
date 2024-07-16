import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum BoxName {
  settings,
  missions,
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
  coding,
  reading,
  meal,
  wakeUp,
  sleep,
  etc,
}

extension MissionTypeExtension on MissionType {
  String get titleText {
    switch (this) {
      case MissionType.drink:
        return "Drink Water";
      case MissionType.exercise:
        return "Exercise";
      case MissionType.reading:
        return "Reading Something";
      case MissionType.meal:
        return "Eat Something";
      case MissionType.wakeUp:
        return "Good morning";
      case MissionType.sleep:
        return "Good Night";
      case MissionType.coding:
        return "Coding";
      case MissionType.etc:
        return "To-do";
    }
  }

  String get guideText {
    switch (this) {
      case MissionType.drink:
        return "Stay splashy! Drink more water.";
      case MissionType.exercise:
        return "Get moving, stay grooving!";
      case MissionType.reading:
        return "Dive into books, broaden your outlook.";
      case MissionType.meal:
        return "Fuel up! It’s meal time.";
      case MissionType.wakeUp:
        return "Rise and shine, it's your time!";
      case MissionType.sleep:
        return "Off to dreamland. Goodnight!";
      case MissionType.coding:
        return "Code a bit, solve a byte!";
      case MissionType.etc:
        return "Tick those boxes, task master!";
    }
  }

  AnimatedEmojiData get emoji {
    switch (this) {
      case MissionType.drink:
        return AnimatedEmojis.droplet;
      case MissionType.exercise:
        return AnimatedEmojis.bicycle;
      case MissionType.reading:
        return AnimatedEmojis.graduationCap;
      case MissionType.meal:
        return AnimatedEmojis.cooking;
      case MissionType.wakeUp:
        return AnimatedEmojis.alarmClock;
      case MissionType.sleep:
        return AnimatedEmojis.yawn;
      case MissionType.coding:
        return AnimatedEmojis.robot;
      case MissionType.etc:
        return AnimatedEmojis.directHit;
    }
  }
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
