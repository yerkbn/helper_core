import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

mixin Normalizer {
  /// It will normalize long numbers to string
  /// with ends like K,M,B
  String normalizeNumber(num? val) {
    if (val == null) return '';
    if (val < 1000) {
      return "${val.toInt()}";
    }
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 2,
      locale: 'en-US',
      symbol:
          '', // if you want to add currency symbol then pass that in this else leave it empty.
    ).format(val);
    return formattedNumber;
  }

  /// This will cut text in given range
  /// maxLength - required to set. by defult it is equal to 10
  String normalizeString(
    String? text, {
    int maxLength = 10,
    bool withDots = false,
  }) {
    if (text == null || text.isEmpty) return 'EMPTY';
    if (text.length < maxLength) return text;
    return text.substring(0, maxLength) + (withDots ? '...' : '');
  }

  String htmlNormalizer(String html) {
    int perHeight = 20;
    String result = html.replaceAll(RegExp(r"mtag='1'"), 'height="$perHeight"');
    result =
        result.replaceAll(RegExp(r"mtag='2'"), 'height="${perHeight * 2}"');
    result =
        result.replaceAll(RegExp(r"mtag='3'"), 'height="${perHeight * 3}"');
    result =
        result.replaceAll(RegExp(r"mtag='4'"), 'height="${perHeight * 4}"');
    return result;
  }

  String getDatePretty(DateTime date) =>
      formatDate(date, [MM, ' ', d, ', ', yyyy]);

  String getDateTimePretty(DateTime date) =>
      formatDate(date, [MM, ' ', d, ', ', yyyy, ' ', HH, ':', nn]);

  void printWrapped(String text) {
    print('\n-------\n');
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  void printFormattedJson(dynamic json) {
    if (json is Map) {
      const JsonEncoder encoder =
          JsonEncoder.withIndent('  '); // 2 spaces for indentation
      String prettyPrint = encoder.convert(json);
      printWrapped(prettyPrint);
    } else {
      printWrapped(json);
    }
  }

  static String dateTimeStringStatic(DateTime time) =>
      time.toUtc().toIso8601String();

  String dateTimeToString(DateTime time) => dateTimeStringStatic(time);

  // to remove 23.0 12.0
  // as result 23 12
  String removeZeroDots(double value) {
    final RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
    return value.toString().replaceAll(regex, '');
  }

  String secToTimeLeft(int value) {
    final int h = value ~/ 3600;
    final int m = (value - h * 3600) ~/ 60;
    final int s = value - (h * 3600) - (m * 60);

    final String hourLeft = h.toString().length < 2 ? "0$h" : h.toString();

    final String minuteLeft = m.toString().length < 2 ? "0$m" : m.toString();

    final String secondsLeft = s.toString().length < 2 ? "0$s" : s.toString();

    if (h == 0) {
      return "$minuteLeft:$secondsLeft";
    }
    return "$hourLeft:$minuteLeft:$secondsLeft";
  }

  String secToDayTimeLeft(int value) {
    final int d = value ~/ 86400;
    final int h = (value - (d * 86400)) ~/ 3600;
    final int m = (value - (h * 3600) - (d * 86400)) ~/ 60;
    final int s = value - (m * 60) - (h * 3600) - (d * 86400);

    final String hourLeft = "$h\h";

    final String minuteLeft = "$m\m";

    final String secondsLeft = "$s\s";

    final String dayLeft = "$d\d";

    if (d != 0 && h == 0) {
      return dayLeft;
    }
    if (d == 0 && h != 0) {
      return "$hourLeft $minuteLeft";
    }
    if (h == 0 && d == 0 && m != 0) {
      return "$minuteLeft $secondsLeft";
    }
    if (h == 0 && d == 0 && m == 0) {
      return secondsLeft;
    }
    return "$dayLeft $hourLeft";
  }

  static String get getUUID => const Uuid().v4();
}

/// This is used as wrapper inside scaffold
/// because inside scaffold context do not have
/// scaffold
class ContextWrapper extends StatelessWidget {
  final Widget Function(BuildContext context) modalCaller;

  const ContextWrapper({required this.modalCaller});
  @override
  Widget build(BuildContext context) {
    return modalCaller(context);
  }
}
