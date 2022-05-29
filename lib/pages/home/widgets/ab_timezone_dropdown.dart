import 'package:availabuddy/core/essentials/colors.dart';
import 'package:availabuddy/core/essentials/textstyles.dart';
import 'package:availabuddy/core/essentials/timezones.dart';
import 'package:flutter/material.dart';

class AbTimezoneDropdown extends StatelessWidget {
  final String placeholder;
  final Function(AbTimezone) onChanged;
  final AbTimezone? value;
  final double width;
  final TextStyle? selectedTextStyle;
  final BoxDecoration? decoration;

  const AbTimezoneDropdown(
      {Key? key,
      required this.value,
      required this.placeholder,
      this.decoration,
      required this.onChanged,
      required this.width,
      this.selectedTextStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [...abTimezones];
    return Container(
        width: width,
        decoration: decoration ?? const BoxDecoration(),
        child: DropdownButtonHideUnderline(
            child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField<AbTimezone>(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorStyle: AbTextStyles.red12w600,
                    ),
                    isExpanded: true,
                    iconEnabledColor: AbColors.primary,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconDisabledColor: AbColors.lightGray,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    hint: Text(placeholder,
                        style: AbTextStyles.almostBlack13w600),
                    value: value,
                    onChanged: (AbTimezone? newValue) {
                      if (newValue != null) {
                        onChanged(newValue);
                      }
                    },
                    items: items.map((AbTimezone map) {
                      return DropdownMenuItem<AbTimezone>(
                        value: map,
                        child: Text(
                            map
                                .code, // GMT${(map.offset.inHours < 10 || (map.offset.inHours < 0 && map.offset.inHours > -10)) ? '0' + map.offset.inHours.toString() : map.offset.inHours.toString()}:00
                            style:
                                selectedTextStyle ?? AbTextStyles.black14w500),
                      );
                    }).toList()))));
  }
}
