import 'package:flutter/cupertino.dart';
import 'package:reciply/constants/localization_constains.dart';
import 'app_localizations.dart';

String? validatorRequired(value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context)!.translate(kRequired);
  }
  return null;
}

String? validatorPasswordRequired(value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context)!.translate(kRequired);
  } else if (value.length < 6) {
    return AppLocalizations.of(context)!.translate(kPasswordLengthError);
  }
  return null;
}

String? validatorEmail(value, BuildContext context) {
  String pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  RegExp regExp = RegExp(pattern);
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context)!.translate(kRequired);
  } else if (!regExp.hasMatch(value)) {
    return AppLocalizations.of(context)!.translate(kNotValidEmail);
  }
  return null;
}
