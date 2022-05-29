import 'package:flutter/material.dart';

mixin AbDatePicker {
  static void get(BuildContext context,
      {required DateTime date,
      required DateTime maximumDate,
      required int minimumYear,
      required Function onChange}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              insetPadding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13.0)),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: AbDatePickerWidget(
                      dateTime: date,
                      maximumDate:
                          DateTime.now().add(const Duration(days: 10000)),
                      minimumYear: DateTime.now().year,
                      onChange: onChange)));
        });
  }
}

class AbDatePickerWidget extends StatelessWidget {
  final DateTime? dateTime;
  final DateTime? maximumDate;
  final int? minimumYear;
  final Function onChange;
  const AbDatePickerWidget(
      {Key? key,
      required this.dateTime,
      required this.maximumDate,
      required this.minimumYear,
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CalendarDatePicker(
      initialDate: dateTime ?? DateTime.now(),
      currentDate: DateTime.now(),
      lastDate: maximumDate ?? DateTime.now().add(const Duration(days: 500)),
      firstDate: DateTime.now(),
      onDateChanged: (date) {
        onChange(date);
      },
    );
  }
}
