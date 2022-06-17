import 'package:dio/dio.dart';

class AbTimezone {
  String code;
  Duration offset;
  String name;
  AbTimezone({required this.code, required this.name, required this.offset});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AbTimezone && o.code == code && o.offset == offset;
  }
}

class AbTimezoneHelper {
  static AbTimezone findTimezone(Duration offset) {
    final matches = abTimezones.where((element) => element.offset == offset);
    if (matches.isNotEmpty) {
      return matches.first;
    } else {
      return abTimezones.first;
    }
  }

  static Future<List<AbTimezone>> initializeTimeZones() async {
    final ret = <AbTimezone>[];
    for (final tz in abTimezones) {
      final offset = await _getTimezoneOffset(name: tz.name);
      ret.add(AbTimezone(code: tz.code, name: tz.name, offset: offset));
    }
    return ret;
  }

  static Future<Duration> _getTimezoneOffset({required String name}) async {
    try {
      var dio = Dio();
      final response =
          await dio.get('https://timeapi.io/api/TimeZone/zone?timeZone=$name',
              options: Options(
                headers: {
                  "Access-Control-Allow-Methods": "*",
                  "Access-Control-Allow-Headers":
                      "'Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token'",
                  'Access-Control-Allow-Origin': '*',
                  'Content-Type': 'application/json',
                },
              ));
      final data = response.data;
      final offsetInSeconds = data['currentUtcOffset']['seconds'];
      return Duration(seconds: offsetInSeconds);
    } catch (err) {
      return abTimezones
          .where((element) => element.name == name)
          .toList()
          .first
          .offset;
    }
  }
}

List<AbTimezone> abTimezones = [
  AbTimezone(
      code: 'PST', name: 'US/Pacific', offset: const Duration(hours: -8)),
  AbTimezone(
      code: 'MST', name: 'US/Mountain', offset: const Duration(hours: -7)),
  AbTimezone(
      code: 'CST', name: 'US/Central', offset: const Duration(hours: -6)),
  AbTimezone(
      code: 'EST', name: 'US/Eastern', offset: const Duration(hours: -5)),
  AbTimezone(code: 'GMT', name: "GMT", offset: const Duration(hours: 0)),
  AbTimezone(code: 'UTC', name: 'UTC', offset: const Duration(hours: 0)),
  AbTimezone(code: 'ECT', name: 'CET', offset: const Duration(hours: 1)),
  AbTimezone(code: 'EET', name: 'EET', offset: const Duration(hours: 2)),
  AbTimezone(code: 'ART', name: 'EET', offset: const Duration(hours: 2)),
  AbTimezone(
      code: 'EAT', name: 'Europe/Moscow', offset: const Duration(hours: 3)),
  AbTimezone(
      code: 'MET', name: 'MET', offset: const Duration(hours: 3, minutes: 30)),
  AbTimezone(code: 'NET', name: 'Asia/Dubai', offset: const Duration(hours: 4)),
  AbTimezone(
      code: 'PLT', name: 'Asia/Karachi', offset: const Duration(hours: 5)),
  AbTimezone(
      code: 'IST',
      name: 'Indian/Mahe',
      offset: const Duration(hours: 5, minutes: 30)),
  AbTimezone(
      code: 'BST', name: 'Asia/Urumqi', offset: const Duration(hours: 6)),
  AbTimezone(
      code: 'VST', name: 'Asia/Bangkok', offset: const Duration(hours: 7)),
  AbTimezone(
      code: 'CTT', name: 'Asia/Hong_Kong', offset: const Duration(hours: 8)),
  AbTimezone(code: 'JST', name: 'Japan', offset: const Duration(hours: 9)),
  AbTimezone(
      code: 'ACT',
      name: 'Australia/Adelaide',
      offset: const Duration(hours: 9, minutes: 30)),
  AbTimezone(
      code: 'AET', name: 'Australia/Sydney', offset: const Duration(hours: 10)),
  AbTimezone(
      code: 'SST',
      name: 'Pacific/Guadalcanal',
      offset: const Duration(hours: 11)),
  AbTimezone(code: 'NST', name: 'NZ', offset: const Duration(hours: 12)),
  AbTimezone(
      code: 'MIT', name: 'Pacific/Midway', offset: const Duration(hours: -11)),
  AbTimezone(
      code: 'HST', name: 'US/Hawaii', offset: const Duration(hours: -10)),
  AbTimezone(code: 'AST', name: 'US/Alaska', offset: const Duration(hours: -9)),
  AbTimezone(
      code: 'PNT', name: 'US/Arizona', offset: const Duration(hours: -7)),
  AbTimezone(
      code: 'IET', name: 'US/East-Indiana', offset: const Duration(hours: -5)),
  AbTimezone(
      code: 'PRT',
      name: 'America/Puerto_Rico',
      offset: const Duration(hours: -4)),
  AbTimezone(
      code: 'CNT',
      name: 'Canada/Newfoundland',
      offset: const Duration(hours: -3, minutes: -30)),
  AbTimezone(
      code: 'AGT',
      name: 'America/Argentina/Buenos_Aires',
      offset: const Duration(hours: -3)),
  AbTimezone(
      code: 'BET', name: 'Brazil/East', offset: const Duration(hours: -3)),
  AbTimezone(
      code: 'CAT', name: 'Africa/Cairo', offset: const Duration(hours: 2))
];
