import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class DateHelper {
  static DateTime toDate(String date, [String format = 'do MMM, yyyy']) {
    return Jiffy(date, format).dateTime;
  }

  static String format(dynamic date, [String format = 'do MMM, yyyy']) {
    if (date == null) return 'Invalid date';
    return Jiffy(date).format(format);
  }

  static String formatTimeOfDay(
      BuildContext context, TimeOfDay? time, bool isStandardFormat) {
    if (time == null) return 'Invalid time';
    final date = DateTime(DateTime.now().day, DateTime.now().month,
        DateTime.now().year, time.hour, time.minute);
    final format = isStandardFormat ? 'hh:mm a' : 'HH:mm';
    return Jiffy(date).format(format);
  }

  static String formatRelativeDate(dynamic date, {String format = 'h:mm a'}) {
    if (DateHelper.isYesterday(date)) {
      return DateHelper.format(date, '[Yesterday] $format');
    } else if (DateHelper.isToday(date)) {
      return DateHelper.format(date, '[Today] $format');
    } else {
      return DateHelper.format(date, 'EEEE, do MMM $format');
    }
  }

  static String formatRelativeDateNew(dynamic date,
      [String format = ' · h:mm a']) {
    if (DateHelper.isYesterday(date)) {
      return DateHelper.format(date, '[Yesterday] $format');
    } else if (DateHelper.isToday(date)) {
      return DateHelper.format(date, '[Today] $format');
    } else {
      return DateHelper.format(date, 'dd MMM, yyyy $format');
    }
  }

  static bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static String toUtcDateString(DateTime date) {
    final utc = Jiffy(date).utc();
    return Jiffy(utc).format();
  }

  static bool isYesterday(DateTime date) {
    final now = DateTime.now();
    DateTime yesterday = now.subtract(const Duration(days: 1));
    return date.day == yesterday.day &&
        date.month == yesterday.month &&
        date.year == yesterday.year;
  }

  static bool isToday(DateTime date) => isSameDay(DateTime.now(), date);
  static DateTime mergeDateAndTime(
          {required DateTime date, required DateTime time}) =>
      DateTime(
          date.year, date.month, date.day, time.hour, time.minute, time.second);
  static DateTime mergeDateAndTimeOfDay(
          {required DateTime date, required TimeOfDay time}) =>
      DateTime(date.year, date.month, date.day, time.hour, time.minute);
  static DateTime syncDateAndNow(DateTime date) =>
      mergeDateAndTime(date: date, time: DateTime.now());

  static List<DateTime> getDateRange(DateTime date) {
    final range = <DateTime>[
      Jiffy(date).startOf(Units.DAY).dateTime,
      Jiffy(date).endOf(Units.DAY).dateTime,
    ];
    return range;
  }

  static DateTime startOfDay(DateTime date) =>
      Jiffy(date).startOf(Units.DAY).dateTime;
  static DateTime endOfDay(DateTime date) =>
      Jiffy(date).endOf(Units.DAY).dateTime;

  static List<DateTime> getTwoWeekDateRange(DateTime date) {
    final last7Days =
        List.generate(7, (i) => date.subtract(Duration(days: 7 - i)));
    final next7Days = List.generate(
        7, (i) => DateTime(date.year, date.month, date.day + i + 1));

    final range = <DateTime>[];
    range.addAll(last7Days);
    range.add(date);
    range.addAll(next7Days);

    return range;
  }

  static int totalDaysInMonth(DateTime date) {
    var firstDayThisMonth = DateTime(date.year, date.month, 1);
    var firstDayNextMonth = DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }
}
