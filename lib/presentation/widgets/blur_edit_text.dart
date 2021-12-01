import 'package:flutter/material.dart';
import 'package:reciply/constants/app_colors.dart';
import 'package:reciply/constants/localization_constains.dart';
import 'package:reciply/presentation/widgets/text_field_display.dart';

import 'blur_widget.dart';

class BlurEditText extends StatelessWidget {
  String translation;
  final TextEditingController controller;
  final bool errorText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;

  BlurEditText({
    required this.translation,
    required this.controller,
    required this.validator,
    this.errorText = false,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlurWidget(
      sigmaX: 10,
      sigmaY: 10,
      child: AppEditText(
          isHint: true,
          controller: controller,
          radius: 12,
          obscureText: obscureText,
          translation: translation,
          errorText: errorText ? kCannotBeNull : null,
          hintColor: Colors.white,
          textColor: AppColor.lightGrey,
          validator: validator,
          maxLength: 50,
          borderColor: Colors.transparent,
          fontSize: 15,
          backgroundColor: AppColor.darkGrey.withOpacity(0.1)),
    );
  }
}
