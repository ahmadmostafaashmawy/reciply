import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reciply/constants/app_colors.dart';
import 'package:reciply/utils/app_localizations.dart';

class AppTextDisplay extends StatelessWidget {
  final Color color;
  final double fontSize;
  final String? text;
  final String? translation;
  final FontWeight fontWeight;
  final String fontFamily;
  TextStyle? style;
  final TextAlign textAlign;
  final bool isUpper;
  final bool softWrap;
  final int maxLines;
  final TextOverflow overflow;
  final TextDecoration? decoration;

  AppTextDisplay(
      {this.color = AppColor.darkGrey,
      this.fontSize = 16.0,
      this.text,
      this.fontFamily = 'Nunito',
      this.decoration,
      this.translation,
      this.overflow = TextOverflow.ellipsis,
      this.style,
      this.softWrap = false,
      this.maxLines = 2,
      this.textAlign = TextAlign.center,
      this.fontWeight = FontWeight.normal,
      this.isUpper = false});

  @override
  Widget build(BuildContext context) {
    if (style != null) {
      double fontSize = style!.fontSize ?? 16;
      style = style!.copyWith(fontSize: fontSize.sp);
    }
    return Text(
      translation != null
          ? AppLocalizations.of(context)!.translate(translation!)!
          : text != null
              ? text!
              : "",
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      style: style ??
          TextStyle(
              decoration: decoration,
              color: color,
              fontSize: fontSize.sp,
              fontFamily: fontFamily,
              fontWeight: fontWeight),
    );
  }
}
