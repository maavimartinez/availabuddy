import 'package:availabuddy/core/essentials/colors.dart';
import 'package:availabuddy/core/essentials/textstyles.dart';
import 'package:availabuddy/core/essentials/timezones.dart';
import 'package:availabuddy/core/widgets/date_field.dart';
import 'package:availabuddy/core/widgets/time_field.dart';
import 'package:availabuddy/pages/home/widgets/ab_timezone_dropdown.dart';
import 'package:flutter/material.dart';

class AbTableRow extends TableRow {
  AbTableRow(BuildContext context,
      {required Function(DateTime date) setDate,
      required Function(TimeOfDay date) setStartTime,
      required Function(TimeOfDay date) setEndTime,
      required Function(AbTimezone date) setTimeZone,
      required Function() remove,
      required final DateTime date,
      required final TimeOfDay startTime,
      required final TimeOfDay endTime,
      required final AbTimezone? timezone,
      required final bool showDelete,
      required final bool isStandardFormat})
      : super(children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: DateField(
                  date: date,
                  setDate: (DateTime date) {
                    setDate(date);
                  })),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: TimeField(
                  time: startTime,
                  isStandardFormat: isStandardFormat,
                  setTime: (TimeOfDay time) {
                    setStartTime(time);
                  })),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: TimeField(
                  time: endTime,
                  isStandardFormat: isStandardFormat,
                  setTime: (TimeOfDay time) {
                    setEndTime(time);
                  })),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: AbTimezoneDropdown(
                placeholder: 'Timezone',
                onChanged: (AbTimezone value) {
                  setTimeZone(value);
                },
                value: timezone,
                width: MediaQuery.of(context).size.width,
              )),
          if (showDelete)
            Center(
                child: IconButton(
              icon: const Icon(Icons.delete, color: AbColors.red, size: 18),
              onPressed: () {
                remove();
              },
            ))
          else
            Container()
        ]);
}
