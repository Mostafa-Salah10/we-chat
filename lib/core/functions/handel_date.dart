import 'package:flutter/material.dart';

String handleDate(BuildContext context, String time) {
  final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
  return TimeOfDay.fromDateTime(date).format(context);
}
