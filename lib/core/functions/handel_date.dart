import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

String handleDate(BuildContext context, String time) {
  final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
  return TimeOfDay.fromDateTime(date).format(context);
}

String formatChatTimeFromMillisString(String millisString) {
  int millis = int.parse(millisString);
  DateTime time = DateTime.fromMillisecondsSinceEpoch(millis);

  final now = DateTime.now();
  final diff = now.difference(time);

  if (diff.inDays == 0) {
    return DateFormat('hh:mm a').format(time);
  } else if (diff.inDays == 1) {
    return 'Yesterday';
  } else if (diff.inDays < 7) {
    return DateFormat('EEEE').format(time); // Mon, Tue, etc.
  } else {
    return DateFormat('dd MMM').format(time); // 10 May
  }
}
