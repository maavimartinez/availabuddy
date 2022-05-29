import 'package:availabuddy/core/essentials/colors.dart';
import 'package:availabuddy/core/essentials/textstyles.dart';
import 'package:flutter/material.dart';

class AbElevatedButton extends StatelessWidget {
  final String label;
  final Widget? widget;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final Size? size;
  final double borderRadius;
  final bool disabled;
  final Color? disabledColor;
  final Color? color;
  final Color? borderColor;
  final void Function()? onPressed;
  final bool fullWidth;
  final bool loading;
  final double loadingIconSize;
  final Icon? leadingIcon;
  final double? elevation;

  AbElevatedButton(this.label,
      {Key? key,
      this.widget,
      this.textStyle,
      this.padding,
      this.size,
      this.borderRadius = 14,
      this.disabledColor = AbColors.lightGray,
      this.disabled = false,
      this.color = AbColors.primary,
      this.borderColor = AbColors.primary,
      required this.onPressed,
      this.fullWidth = true,
      this.loading = false,
      this.loadingIconSize = 6,
      this.leadingIcon,
      this.elevation})
      : child = ElevatedButton(
            onPressed: !disabled ? (loading ? () {} : onPressed) : () {},
            style: ElevatedButton.styleFrom(
              elevation: elevation ?? 0,
              minimumSize: fullWidth == true
                  ? (size ?? const Size(double.maxFinite, 50))
                  : size,
              padding: padding ??
                  (fullWidth
                      ? const EdgeInsets.symmetric(horizontal: 30, vertical: 0)
                      : const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20)),
              primary: disabled ? disabledColor : color,
              onSurface: AbColors.primary,
              shape: RoundedRectangleBorder(
                side: (disabled)
                    ? BorderSide.none
                    : BorderSide(color: borderColor!, width: 1),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            child: loading
                ? const CircularProgressIndicator()
                : ((leadingIcon != null)
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          leadingIcon,
                          const SizedBox(width: 8),
                          Text(label,
                              style: textStyle ?? AbTextStyles.white16w600),
                        ],
                      )
                    : Text(label,
                        style: textStyle ?? AbTextStyles.white16w600))),
        super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
