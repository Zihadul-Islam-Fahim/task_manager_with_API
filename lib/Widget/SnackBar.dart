import 'package:flutter/material.dart';

void mySnackbar(context, String msg, [bool iserror = false]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: iserror == true ? Colors.red : Colors.blue,
      content: Text(msg)));
}
