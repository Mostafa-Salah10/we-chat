import 'package:flutter/material.dart';

void customPushReplacement(
  BuildContext context, {
  required String route,
  dynamic argument,
}) {
  Navigator.pushReplacementNamed(context, route, arguments: argument);
}

void customPush(
  BuildContext context, {
  required String route,
  dynamic argument,
}) {
  Navigator.pushNamed(context, route, arguments: argument);
}

void customPushAndRemoveAll(
  BuildContext context, {
  required String route,
  dynamic argument,
}) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    route,
    arguments: argument,
    (route) => false,
  );
}
