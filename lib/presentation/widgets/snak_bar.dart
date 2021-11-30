import 'package:flutter/material.dart';
import 'package:reciply/presentation/widgets/text_display.dart';

void showSnackBar(BuildContext context, String message) =>
    Scaffold.of(context).showSnackBar(SnackBar(
      elevation: 20,
      content: AppTextDisplay(
        translation: message,
        color: Colors.white,
      ),
    ));
