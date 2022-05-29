import 'package:availabuddy/core/essentials/colors.dart';
import 'package:availabuddy/core/essentials/textstyles.dart';
import 'package:flutter/material.dart';

class AbDropdown extends StatelessWidget {
  final String placeholder;
  final Function onChanged;
  final List<String> items;
  final String? value;
  final double width;
  final TextStyle? selectedTextStyle;

  const AbDropdown(
      {Key? key,
      required this.value,
      required this.placeholder,
      required this.onChanged,
      required this.width,
      required this.items,
      this.selectedTextStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final val = value == '' ? null : value;
    return Container(
        width: width,
        decoration: BoxDecoration(
            border: Border.all(color: AbColors.primary),
            borderRadius: BorderRadius.circular(8)),
        child: DropdownButtonHideUnderline(
            child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField<String>(
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
                    hint: Text(placeholder, style: AbTextStyles.black14w500),
                    value: val,
                    onChanged: (String? newValue) {
                      onChanged(newValue);
                    },
                    items: items.map((String map) {
                      return DropdownMenuItem<String>(
                        value: map,
                        child: Text(map,
                            style:
                                selectedTextStyle ?? AbTextStyles.black14w500),
                      );
                    }).toList()))));
  }
}
