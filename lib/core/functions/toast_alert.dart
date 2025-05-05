import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

toastAlert({required Color color, required String msg}) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
