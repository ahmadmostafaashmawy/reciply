import 'package:flutter/material.dart';
import 'package:reciply/constants/app_colors.dart';
import 'package:reciply/presentation/widgets/text_display.dart';

class AppButton extends StatelessWidget {
  final String? translation;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final TextDecoration? textDecoration;
  final BoxDecoration? decoration;
  TextStyle? style;
  void Function()? onTap;
  final Widget? child;
  BorderRadiusGeometry? border;
  final IconData? iconData;
  final EdgeInsets padding;

  AppButton(
      {this.translation,
      this.color = AppColor.white,
      this.textColor = AppColor.primaryColor,
      this.borderColor = AppColor.primaryColor,
      this.onTap,
      this.fontSize = 15,
      this.fontWeight = FontWeight.normal,
      this.fontFamily = 'Nunito',
      this.textDecoration,
      this.border,
      this.child,
      this.decoration,
      this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      this.iconData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: decoration ??
            BoxDecoration(
              color: color,
              border: Border.all(color: borderColor, width: 1.0),
              borderRadius: border ?? BorderRadius.circular(20),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconData != null) Icon(iconData, size: 24, color: textColor),
            if (iconData != null) const SizedBox(width: 4),
            child != null
                ? child!
                : AppTextDisplay(
                    translation: translation,
                    style: style ??
                        TextStyle(
                            decoration: textDecoration,
                            color: textColor,
                            fontSize: fontSize,
                            fontFamily: fontFamily,
                            fontWeight: fontWeight),
                  ),
          ],
        ),
      ),
    );
  }
}
