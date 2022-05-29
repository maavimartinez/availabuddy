import 'package:availabuddy/core/essentials/colors.dart';
import 'package:availabuddy/core/essentials/textstyles.dart';
import 'package:availabuddy/core/essentials/timezones.dart';
import 'package:availabuddy/core/utils/logic.dart';
import 'package:availabuddy/core/widgets/ab_dropdown.dart';
import 'package:availabuddy/core/widgets/ab_elevated_button.dart';
import 'package:availabuddy/pages/home/widgets/ab_table_header.dart';
import 'package:availabuddy/pages/home/widgets/ab_table_row.dart';
import 'package:availabuddy/pages/home/widgets/ab_timezone_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DateTimeTable extends StatefulWidget {
  const DateTimeTable({Key? key}) : super(key: key);

  @override
  State<DateTimeTable> createState() => _DateTimeTableState();
}

class _DateTimeTableState extends State<DateTimeTable> {
  final List<DateTime> dates = <DateTime>[];
  final List<TimeOfDay> startTimes = <TimeOfDay>[];
  final List<TimeOfDay> endTimes = <TimeOfDay>[];
  final List<AbTimezone> timezones = <AbTimezone>[];
  late AbTimezone expectedTimezone;
  final Duration timezoneDifference = Duration.zero;
  String selectedTimeFormat = 'ST';
  bool isStandardFormat = true;

  @override
  void initState() {
    dates.add(DateTime.now());
    startTimes.add(TimeOfDay.now());
    endTimes.add(
        TimeOfDay.fromDateTime(DateTime.now().add(const Duration(hours: 1))));
    timezones.add(AbTimezoneHelper.findTimezone(DateTime.now().timeZoneOffset));
    expectedTimezone =
        AbTimezoneHelper.findTimezone(DateTime.now().timeZoneOffset);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        _table(),
        const SizedBox(height: 20),
        _addDateButton(),
        const SizedBox(height: 20),
        Row(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Text(
              'Format',
              style: AbTextStyles.black13w600,
            ),
          ),
          const SizedBox(width: 15),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Text(
              'To time zone',
              style: AbTextStyles.black13w600,
            ),
          )
        ]),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              AbDropdown(
                  width: MediaQuery.of(context).size.width * 0.2,
                  value: selectedTimeFormat,
                  placeholder: 'Time format',
                  onChanged: (String value) {
                    setState(() {
                      selectedTimeFormat = value;
                      isStandardFormat = value == 'ST';
                    });
                  },
                  items: const ['ST', 'MT']),
              const SizedBox(width: 15),
              AbTimezoneDropdown(
                  value: expectedTimezone,
                  placeholder: 'Time Zone',
                  onChanged: (AbTimezone timezone) {
                    setState(() {
                      expectedTimezone = timezone;
                    });
                  },
                  decoration: BoxDecoration(
                      border: Border.all(color: AbColors.primary),
                      borderRadius: BorderRadius.circular(8)),
                  width: MediaQuery.of(context).size.width * 0.2)
            ]),
            AbElevatedButton('Create list', fullWidth: false, onPressed: () {
              final aux = Logic.createDateList(
                  dates: dates,
                  isStandardFormat: isStandardFormat,
                  startTimes: startTimes,
                  endTimes: endTimes,
                  timezones: timezones,
                  expectedTimezone: expectedTimezone);
              final text = Logic.listToText(context, aux);

              Clipboard.setData(ClipboardData(text: text));
            })
          ],
        )
      ],
    ));
  }

  Widget _table() {
    return Table(
        border: TableBorder.all(
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        textBaseline: TextBaseline.alphabetic,
        children: [
          AbTableHeaderRow(context, labels: const [
            'Date',
            'Start time',
            'End time',
            'Timezone',
            'Delete'
          ]),
          for (int i = 0; i < dates.length; i++)
            AbTableRow(context,
                date: dates[i],
                setDate: (DateTime newDate) {
                  setState(() {
                    dates.removeAt(i);
                    dates.insert(i, newDate);
                  });
                },
                showDelete: dates.length > 1,
                remove: () {
                  setState(() {
                    dates.removeAt(i);
                    startTimes.removeAt(i);
                    endTimes.removeAt(i);
                    timezones.removeAt(i);
                  });
                },
                setStartTime: (TimeOfDay newTime) {
                  setState(() {
                    startTimes.removeAt(i);
                    startTimes.insert(i, newTime);
                  });
                },
                setEndTime: (TimeOfDay newTime) {
                  setState(() {
                    endTimes.removeAt(i);
                    endTimes.insert(i, newTime);
                  });
                },
                setTimeZone: (AbTimezone timezone) {
                  setState(() {
                    timezones.removeAt(i);
                    timezones.insert(i, timezone);
                  });
                },
                isStandardFormat: isStandardFormat,
                timezone: timezones[i],
                startTime: startTimes[i],
                endTime: endTimes[i])
        ]);
  }

  Widget _addDateButton() {
    if (dates.length < 7) {
      return AbElevatedButton('+ Add time', onPressed: () {
        setState(() {
          timezones.add(
              AbTimezoneHelper.findTimezone(DateTime.now().timeZoneOffset));
          dates.add(DateTime.now());
          startTimes.add(TimeOfDay.now());
          endTimes.add(TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(hours: 1))));
        });
      });
    } else {
      return Container();
    }
  }
}
