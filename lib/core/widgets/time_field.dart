import 'package:availabuddy/core/essentials/colors.dart';
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
    final values = <dynamic>[];
    if (isStandardFormat) {
      for (var i = 1; i < 13; i++) {
        for (var j = 0; j < 46; j = j + 15) {
          values.add({
            "display": i.toString() +
                ':' +
                (j < 10 ? '0$j' : j.toString()) +
                (i == 12 ? ' PM' : ' AM'),
            "value": TimeOfDay(hour: i, minute: j),
          });
        }
      }
      for (var i = 1; i < 13; i++) {
        for (var j = 0; j < 46; j = j + 15) {
          values.add({
            "display": i.toString() +
                ':' +
                (j < 10 ? '0$j' : j.toString()) +
                (i == 12 ? ' AM' : ' PM'),
            "value": TimeOfDay(hour: i + 12, minute: j),
          });
        }
      }
    } else {
      for (var i = 0; i < 24; i++) {
        for (var j = 0; j < 46; j = j + 15) {
          values.add({
            "display": i.toString() + ':' + (j < 10 ? '0$j' : j.toString()),
            "value": TimeOfDay(hour: i + 12, minute: j),
          });
        }
      }
    }
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 5),
              labelStyle: AbTextStyles.black14w500,
              errorStyle: AbTextStyles.red14w400,
              hintText: 'Please select a time',
              border: InputBorder.none),
          isEmpty: time == null,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<TimeOfDay>(
              iconEnabledColor: AbColors.primary,
              icon: const Icon(Icons.keyboard_arrow_down),
              iconDisabledColor: AbColors.lightGray,
              value: time,
              isDense: true,
              onChanged: (TimeOfDay? newTime) {
                if (newTime != null) {
                  setTime(newTime);
                }
              },
              items: values.map((dynamic value) {
                return DropdownMenuItem<TimeOfDay>(
                  value: value['value'],
                  child: Text(value['display']),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
