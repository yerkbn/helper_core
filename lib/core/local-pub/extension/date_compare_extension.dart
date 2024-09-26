import 'package:intl/intl.dart';

extension DateCompareExtenssion on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  String get toCustomString {
    return toUtc().toIso8601String();
  }

  String get onlyDate {
    return DateFormat('dd.MM.yyyy').format(this);
  }
}
