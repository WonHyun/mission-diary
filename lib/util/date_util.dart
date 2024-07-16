import 'package:intl/intl.dart';

String getTimeString(int time) {
  return time.toString().padLeft(2, "0");
}

String getYYYYMMDD(DateTime time) {
  return DateFormat("yyyy-MM-dd").format(time);
}

String getHHMM(DateTime time) {
  return DateFormat("HH:mm").format(time);
}

String getHHMMapm(DateTime time) {
  return DateFormat("hh:mm a").format(time);
}

String getTimeAgoFormat(DateTime? time) {
  if (time == null) return "";
  final diff = DateTime.now().difference(time);

  if (diff.inDays >= 365) {
    int years = (diff.inDays / 365).floor();
    return '${years}y';
  } else if (diff.inDays >= 30) {
    int months = (diff.inDays / 30).floor();
    return '${months}month';
  } else if (diff.inDays >= 1) {
    return '${diff.inDays}d';
  } else if (diff.inHours >= 1) {
    return '${diff.inHours}h';
  } else if (diff.inMinutes >= 1) {
    return '${diff.inMinutes}m';
  } else {
    return 'now';
  }
}

DateTime adjustMinute(DateTime now, int minuteInterval) {
  int roundedMinutes = ((now.minute / minuteInterval).ceil()) * minuteInterval;

  if (roundedMinutes == 60 ||
      (now.hour == 23 && now.minute >= 60 - minuteInterval)) {
    return DateTime(now.year, now.month, now.day + 1, 0, 0);
  }
  return DateTime(now.year, now.month, now.day, now.hour, roundedMinutes);
}
