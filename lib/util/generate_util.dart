import 'package:uuid/uuid.dart';

const uuid = Uuid();

String capitalizeFirst(String str) {
  if (str.isEmpty) return str;
  return str[0].toUpperCase() + str.substring(1).toLowerCase();
}
