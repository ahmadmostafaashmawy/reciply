import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reciply/constants/app_colors.dart';
import 'package:reciply/utils/app_localizations.dart';

class AppEditText extends StatelessWidget {
  final Color textColor;
  final Color hintColor;
  final Color backgroundColor;
  final Color borderColor;
  final double fontSize;
  final String? text;
  final String? translation;
  final FontWeight fontWeight;
  final String fontFamily;
  final double radius;
  TextStyle? style;
  TextInputType keyboardType;
  bool isHint;
  final TextAlign textAlign;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  EdgeInsets? contentPadding;
  final TextDecoration? textDecoration;
  final InputDecoration? decoration;
  final TextEditingController controller;
  final bool autoFocus;
  final bool alignLabelWithHint;
  final bool enableInteractiveSelection;
  final int maxLength;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final String? errorText;
  final bool obscureText;
  final bool readOnly;
  InputBorder? border;
  FormFieldValidator<String>? validator;

  AppEditText({
    this.textColor = AppColor.primaryColor,
    this.backgroundColor = AppColor.white,
    this.fontSize = 16,
    this.text,
    this.validator,
    this.prefixIcon,
    this.readOnly = false,
    this.fontFamily = 'Nunito',
    this.textDecoration,
    this.borderColor = AppColor.grey,
    this.focusNode,
    this.radius = 8,
    this.onChanged,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.decoration,
    this.translation,
    this.isHint = true,
    this.style,
    this.contentPadding,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.normal,
    this.autoFocus = false,
    this.alignLabelWithHint = false,
    this.enableInteractiveSelection = true,
    this.suffixIcon,
    this.maxLength = 10,
    this.errorText,
    this.obscureText = false,
    this.hintColor = AppColor.darkGrey,
  });

  @override
  Widget build(BuildContext context) {
    contentPadding ??=
        EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12));
    if (style != null) {
      double fontSize = style!.fontSize ?? 16;
      style = style!.copyWith(fontSize: fontSize.sp);
    }
    init();
    return TextFormField(
      autofocus: autoFocus,
      validator: validator,
      readOnly: readOnly,
      maxLength: maxLength,
      onChanged: onChanged,
      focusNode: focusNode,
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      // enableInteractiveSelection: enableInteractiveSelection,
      decoration: decoration ??
          InputDecoration(
              contentPadding: contentPadding,
              counterText: "",
              errorText: errorText,
              suffixIcon: suffixIcon,
              suffix: suffixIcon,
              prefixIcon: prefixIcon,
              border: border,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: .8),
                borderRadius: BorderRadius.all(Radius.circular(radius)),
              ),
              focusColor: AppColor.primaryColor,
              enabledBorder: border,
              filled: true,
              hintStyle: TextStyle(color: hintColor),
              hintText: isHint
                  ? translation != null
                      ? AppLocalizations.of(context)!.translate(translation!)
                      : text ?? ''
                  : null,
              alignLabelWithHint: alignLabelWithHint,
              fillColor: backgroundColor),
      textAlign: textAlign,
      style: style ??
          TextStyle(
              decoration: textDecoration,
              fontSize: ScreenUtil().setSp(fontSize),
              color: textColor,
              fontFamily: fontFamily,
              fontWeight: fontWeight),
    );
  }

  void init() {
    border = OutlineInputBorder(
      borderSide: BorderSide(color: borderColor, width: .8),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );
  }
}
