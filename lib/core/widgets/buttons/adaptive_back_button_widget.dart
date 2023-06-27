import 'dart:io';

import 'package:flutter/material.dart';

buildAdaptiveBackButton({required void Function() onPressed}) {
  return IconButton(
    onPressed: onPressed,
    icon: Platform.isIOS
        ? const Icon(Icons.arrow_back_ios)
        : const Icon(Icons.arrow_back),
  );
}
