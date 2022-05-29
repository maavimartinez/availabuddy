import 'package:availabuddy/core/essentials/date_helper.dart';
import 'package:availabuddy/core/essentials/textstyles.dart';
import 'package:flutter/material.dart';

class TimeField extends StatelessWidget {
  final TimeOfDay time;
  final bool isStandardFormat;
  final Function(TimeOfDay time) setTime;
  const TimeField(
      {Key? key,
      required this.time,
      required this.isStandardFormat,
      required this.setTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          final TimeOfDay? newTime = await showTimePicker(
            context: context,
            initialTime: time,
          );
          if (newTime != null) {
            setTime(newTime);
          }
        },
        child: Center(
            child: Text(
                DateHelper.formatTimeOfDay(context, time, isStandardFormat),
                style: AbTextStyles.black14w500)));
  }
}
