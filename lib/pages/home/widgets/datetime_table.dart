import 'package:availabuddy/core/essentials/colors.dart';
import 'package:availabuddy/core/essentials/date_helper.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class DateTimeTable extends StatefulWidget {
  const DateTimeTable({Key? key}) : super(key: key);

  @override
  _DateTimeTableState createState() => _DateTimeTableState();
}

class _DateTimeTableState extends State<DateTimeTable> {
  SharedPreferences? sharedPreferences;
  List<DateTime> dates = <DateTime>[];
  List<TimeOfDay> startTimes = <TimeOfDay>[];
  List<TimeOfDay> endTimes = <TimeOfDay>[];
  List<AbTimezone> timezones = <AbTimezone>[];
  late AbTimezone expectedTimezone;
  final Duration timezoneDifference = Duration.zero;
  String selectedTimeFormat = 'Standard Time';
  bool isStandardFormat = true;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      //value.clear();
      final stringDates = value.getStringList('dates') ?? [];
      final startTimesString = value.getStringList('startTimes') ?? [];
      final endTimesString = value.getStringList('endTimes') ?? [];
      final timezonesString = value.getStringList('timezones') ?? [];
      final expectedTimezoneString =
          value.getString('expectedTimezone') ?? 'EST';
      print(
          '🤖🤖🤖🤖🤖🤖 🤖🤖🤖🤖🤖🤖 🤖🤖🤖🤖🤖🤖 🤖🤖🤖🤖🤖🤖 🤖🤖🤖🤖🤖🤖 🤖🤖🤖🤖🤖🤖 ');
      print(stringDates);
      print(startTimesString);
      print(endTimesString);
      print(
          '🤖🤖🤖🤖🤖🤖 🤖🤖🤖🤖🤖🤖 🤖🤖🤖🤖🤖🤖 🤖🤖🤖🤖🤖🤖 🤖🤖🤖🤖🤖🤖 🤖🤖🤖🤖🤖🤖 ');
      setState(() {
        sharedPreferences = value;
        dates = stringDates.isEmpty
            ? [DateTime.now()]
            : stringDates.map((e) => DateTime.parse(e)).toList();
        startTimes = startTimesString.isEmpty
            ? [const TimeOfDay(hour: 12, minute: 00)]
            : startTimesString.map((e) {
                DateTime dateTime = DateFormat("HH:mm").parse(e);
                TimeOfDay timeOfDay = TimeOfDay.fromDateTime(dateTime);

                return timeOfDay;
              }).toList();
        endTimes = endTimesString.isEmpty
            ? [const TimeOfDay(hour: 13, minute: 00)]
            : endTimesString.map((e) {
                DateTime dateTime = DateFormat("HH:mm").parse(e);
                TimeOfDay timeOfDay = TimeOfDay.fromDateTime(dateTime);

                return timeOfDay;
              }).toList();
        timezones = timezonesString.isEmpty
            ? [abTimezones.where((element) => element.code == 'EST').first]
            : timezonesString
                .map((e) =>
                    abTimezones.where((element) => element.code == e).first)
                .toList();
        expectedTimezone = abTimezones
            .where((element) => expectedTimezoneString == element.code)
            .first;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (sharedPreferences == null) {
      return CircularProgressIndicator();
    }
    return SingleChildScrollView(
        child: Column(
      children: [
        _table(),
        const SizedBox(height: 20),
        _addDateButton(),
        const SizedBox(height: 20),
        Row(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.24,
            child: Text('Format', style: AbTextStyles.black13w600),
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
                  width: MediaQuery.of(context).size.width *
                      0.1, //* 0.24, //change
                  value: selectedTimeFormat,
                  placeholder: 'Time format',
                  onChanged: (String value) {
                    setState(() {
                      selectedTimeFormat = value;
                      isStandardFormat = value == 'Standard Time';
                    });
                  },
                  items: const ['Standard Time', 'Military Time']), //change
              const SizedBox(width: 15),
              AbTimezoneDropdown(
                  value: expectedTimezone,
                  placeholder: 'Time Zone',
                  onChanged: (AbTimezone timezone) {
                    setState(() {
                      expectedTimezone = timezone;
                      sharedPreferences?.setString(
                          'expectedTimezone', timezone.code);
                    });
                  },
                  decoration: BoxDecoration(
                      border: Border.all(color: AbColors.primary),
                      borderRadius: BorderRadius.circular(8)),
                  width: MediaQuery.of(context).size.width * 0.1) //chanfe
            ]),
            AbElevatedButton('Create list',
                fullWidth: false,
                size:
                    Size(MediaQuery.of(context).size.width * 0.2, 60), //change
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                onPressed: () {
              final aux = Logic.createDateList(
                  dates: dates,
                  isStandardFormat: isStandardFormat,
                  startTimes: startTimes,
                  endTimes: endTimes,
                  timezones: timezones,
                  expectedTimezone: expectedTimezone);
              final text = Logic.listToText(context, aux);

              Clipboard.setData(ClipboardData(text: text));
            }),
          ],
        ),
        const SizedBox(height: 15),
        const SizedBox(height: 15),
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
                    sharedPreferences?.setStringList(
                        'dates', dates.map((e) => e.toString()).toList());
                  });
                },
                showDelete: dates.length > 1,
                remove: () => deleteDate(i),
                setStartTime: (TimeOfDay newTime) {
                  setState(() {
                    startTimes.removeAt(i);
                    startTimes.insert(i, newTime);
                    sharedPreferences?.setStringList(
                        'startTimes',
                        startTimes
                            .map((e) =>
                                DateHelper.formatTimeOfDay(context, e, false))
                            .toList());
                  });
                },
                setEndTime: (TimeOfDay newTime) {
                  setState(() {
                    endTimes.removeAt(i);
                    endTimes.insert(i, newTime);
                    sharedPreferences?.setStringList(
                        'endTimes',
                        endTimes
                            .map((e) =>
                                DateHelper.formatTimeOfDay(context, e, false))
                            .toList());
                  });
                },
                setTimeZone: (AbTimezone timezone) {
                  setState(() {
                    timezones.removeAt(i);
                    timezones.insert(i, timezone);
                    sharedPreferences?.setStringList(
                        'timezones', timezones.map((e) => e.code).toList());
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
      return AbElevatedButton('+ Add time', onPressed: addDate);
    } else {
      return Container();
    }
  }

  void deleteDate(int i) {
    setState(() {
      dates.removeAt(i);
      startTimes.removeAt(i);
      endTimes.removeAt(i);
      timezones.removeAt(i);
      sharedPreferences?.setStringList(
          'timezones', timezones.map((e) => e.code).toList());
      sharedPreferences?.setStringList(
          'endTimes',
          endTimes
              .map((e) => DateHelper.formatTimeOfDay(context, e, false))
              .toList());
      sharedPreferences?.setStringList(
          'startTimes',
          startTimes
              .map((e) => DateHelper.formatTimeOfDay(context, e, false))
              .toList());
      sharedPreferences?.setStringList(
          'dates', dates.map((e) => e.toString()).toList());
    });
  }

  void addDate() {
    setState(() {
      timezones
          .add(AbTimezoneHelper.findTimezone(DateTime.now().timeZoneOffset));
      dates.add(DateTime.now());
      startTimes.add(TimeOfDay(hour: TimeOfDay.now().hour, minute: 00));
      endTimes.add(TimeOfDay(hour: TimeOfDay.now().hour + 1, minute: 00));
    });

    sharedPreferences?.setStringList(
        'dates', dates.map((e) => e.toString()).toList());
    sharedPreferences?.setStringList(
        'startTimes',
        startTimes
            .map((e) => DateHelper.formatTimeOfDay(context, e, false))
            .toList());
    sharedPreferences?.setStringList(
        'endTimes',
        endTimes
            .map((e) => DateHelper.formatTimeOfDay(context, e, false))
            .toList());
    sharedPreferences?.setStringList(
        'timezones', timezones.map((e) => e.code).toList());
  }
}
