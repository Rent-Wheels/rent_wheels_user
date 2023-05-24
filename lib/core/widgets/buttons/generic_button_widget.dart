import 'package:flutter/material.dart';

buildGenericButtonWidget({
  required String buttonName,
  required void Function() onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Text(buttonName),
  );
}
