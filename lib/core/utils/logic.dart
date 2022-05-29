import 'dart:html';

import 'package:availabuddy/core/essentials/date_helper.dart';
import 'package:availabuddy/core/essentials/timezones.dart';
import 'package:flutter/material.dart';

mixin Logic {
  static List<Map<String, dynamic>> createDateList(
      {required List<DateTime> dates,
      required List<TimeOfDay> startTimes,
      required List<TimeOfDay> endTimes,
      required List<AbTimezone> timezones,
      required AbTimezone expectedTimezone,
      required bool isStandardFormat}) {
    final List<Map<String, dynamic>> ret = <Map<String, dynamic>>[];
    for (var i = 0; i < dates.length; i++) {
      final actualStartDateWithoutTimezone = DateTime(
          dates[i].year,
          dates[i].month,
          dates[i].day,
          startTimes[i].hour,
          startTimes[i].minute);
      final actualEndDateWithoutTimezone = DateTime(dates[i].year,
          dates[i].month, dates[i].day, endTimes[i].hour, endTimes[i].minute);
      final Duration durationToAdd =
          getOffsetDuration(timezones[i].offset, expectedTimezone.offset);
      final finalStartDateTime =
          actualStartDateWithoutTimezone.add(durationToAdd);
      final finalEndDateTime = actualEndDateWithoutTimezone.add(durationToAdd);
      ret.add({
        'date': finalStartDateTime,
        'start_time': finalStartDateTime,
        'end_time': finalEndDateTime,
        'time_zone_code': expectedTimezone.code,
        'time_zone_offset': expectedTimezone.offset,
        'actual_offset': durationToAdd.inHours,
        'is_standard_format': isStandardFormat
      });
    }
    return ret;
  }

  static String listToText(
      BuildContext context, List<Map<String, dynamic>> list) {
    TableElement table2 = TableElement();
    table2.style.width = '100%';
    var tBody2 = table2.createTBody();

    // table2.tHead!.insertRow(-1)
    //   ..insertCell(0).nodes.add(TableEle  .tag('th')..text = '1')
    //   ..insertCell(1).nodes.add(Element.tag('th')..text = '2')
    //   ..insertCell(2).nodes.add(Element.tag('th')..text = '3')
    //   ..insertCell(3).nodes.add(Element.tag('th')..text = '4');
    for (int i = 0; i < list.length; i++) {
      final date = DateHelper.format(list[i]['date'], 'MM/dd');
      final startTime = DateHelper.format(list[i]['start_time'],
          list[i]['is_standard_format'] ? 'hh:mm a' : 'HH:mm');
      final endTime = DateHelper.format(list[i]['end_time'],
          list[i]['is_standard_format'] ? 'hh:mm a' : 'HH:mm');

      tBody2.insertRow(i)
        ..insertCell(0).text = date
        ..insertCell(1).text = startTime
        ..insertCell(2).text = endTime
        ..insertCell(3).text = list[0]['time_zone_code'];
    }

    return table2.outerHtml ?? '';
  }

  static getOffsetDuration(Duration myOffset, Duration desiredOffset) {
    if (myOffset.inMinutes == desiredOffset.inMinutes) {
      return Duration.zero;
    }
    if (myOffset.inMinutes < desiredOffset.inMinutes) {
      final minutes = desiredOffset.inMinutes - myOffset.inMinutes;
      return Duration(minutes: minutes);
    } else {
      final minutes = myOffset.inMinutes - desiredOffset.inMinutes;
      return Duration(minutes: -minutes);
    }
  }
}
