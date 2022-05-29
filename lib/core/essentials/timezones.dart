class AbTimezone {
  String code;
  Duration offset;
  AbTimezone({required this.code, required this.offset});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AbTimezone && o.code == code && o.offset == offset;
  }
}

//las timezones no son iguales alas de dart
//como encuentor una timezone si hay dos iguales?

class AbTimezoneHelper {
  static AbTimezone findTimezone(Duration offset) {
    final matches = abTimezones.where((element) => element.offset == offset);
    if (matches.isNotEmpty) {
      return matches.first;
    } else {
      return abTimezones.first;
    }
  }
}

List<AbTimezone> abTimezones = [
  AbTimezone(code: 'GMT', offset: const Duration(hours: 0)),
  AbTimezone(code: 'UTC', offset: const Duration(hours: 0)),
  AbTimezone(code: 'ECT', offset: const Duration(hours: 1)),
  AbTimezone(code: 'EET', offset: const Duration(hours: 2)),
  AbTimezone(code: 'ART', offset: const Duration(hours: 2)),
  AbTimezone(code: 'EAT', offset: const Duration(hours: 3)),
  AbTimezone(code: 'MET', offset: const Duration(hours: 3, minutes: 30)),
  AbTimezone(code: 'NET', offset: const Duration(hours: 4)),
  AbTimezone(code: 'PLT', offset: const Duration(hours: 5)),
  AbTimezone(code: 'IST', offset: const Duration(hours: 5, minutes: 30)),
  AbTimezone(code: 'BST', offset: const Duration(hours: 6)),
  AbTimezone(code: 'VST', offset: const Duration(hours: 7)),
  AbTimezone(code: 'CTT', offset: const Duration(hours: 8)),
  AbTimezone(code: 'JST', offset: const Duration(hours: 9)),
  AbTimezone(code: 'ACT', offset: const Duration(hours: 9, minutes: 30)),
  AbTimezone(code: 'AET', offset: const Duration(hours: 10)),
  AbTimezone(code: 'SST', offset: const Duration(hours: 11)),
  AbTimezone(code: 'NST', offset: const Duration(hours: 12)),
  AbTimezone(code: 'MIT', offset: const Duration(hours: -11)),
  AbTimezone(code: 'HST', offset: const Duration(hours: -10)),
  AbTimezone(code: 'AST', offset: const Duration(hours: -9)),
  AbTimezone(code: 'PST', offset: const Duration(hours: -8)),
  AbTimezone(code: 'PNT', offset: const Duration(hours: -7)),
  AbTimezone(code: 'MST', offset: const Duration(hours: -7)),
  AbTimezone(code: 'CST', offset: const Duration(hours: -6)),
  AbTimezone(code: 'EST', offset: const Duration(hours: -5)),
  AbTimezone(code: 'IET', offset: const Duration(hours: -5)),
  AbTimezone(code: 'PRT', offset: const Duration(hours: -4)),
  AbTimezone(code: 'CNT', offset: const Duration(hours: -3, minutes: -30)),
  AbTimezone(code: 'AGT', offset: const Duration(hours: -3)),
  AbTimezone(code: 'BET', offset: const Duration(hours: -3)),
  AbTimezone(code: 'CAT', offset: const Duration(hours: -1))
];
