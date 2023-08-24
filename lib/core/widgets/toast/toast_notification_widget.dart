import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

buildToastNotification() {
  return Fluttertoast.showToast(
    msg: "This feature hasn't been implemented",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
