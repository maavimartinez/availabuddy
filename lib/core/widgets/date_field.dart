import 'package:availabuddy/core/essentials/date_helper.dart';
import 'package:availabuddy/core/essentials/textstyles.dart';
import 'package:availabuddy/core/widgets/ab_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateField extends StatelessWidget {
  final DateTime date;
  final Function(DateTime date) setDate;
  const DateField({Key? key, required this.date, required this.setDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => AbDatePicker.get(context,
            date: date,
            maximumDate: DateTime.now().add(const Duration(days: 10000)),
            minimumYear: DateTime.now().year,
            onChange: (DateTime pickedDate) => setDate(pickedDate)),
        child: Center(
            child: Text(
                DateHelper.format(date, DateFormat.yMd().pattern ?? 'MM/dd/yy'),
                style: AbTextStyles.black14w500)));
  }
}
