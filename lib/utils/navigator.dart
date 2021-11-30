import 'package:flutter/material.dart';

Future<dynamic> pushName(BuildContext context, String route,
    {dynamic arguments}) async {
  return await Navigator.of(context).pushNamed(route, arguments: arguments);
}

void pushNameWithArguments(BuildContext context, String route, argument) {
  Navigator.of(context).pushNamed(route, arguments: argument);
}

void popScreen(BuildContext context, int size) {
  int count = 0;
  Navigator.of(context).popUntil((_) => count++ >= size);
}

void popAndPushName(BuildContext context, String route, {dynamic arguments}) {
  Navigator.of(context).popAndPushNamed(route, arguments: arguments);
}

void popAllAndPushName(BuildContext context, String widget) {
  Navigator.of(context).pushNamedAndRemoveUntil(
    widget,
    (route) => false,
  );
}
