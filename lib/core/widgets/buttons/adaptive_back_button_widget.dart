import 'dart:io';

import 'package:flutter/material.dart';

class AdaptiveBackButton extends StatelessWidget {
  final void Function() onPressed;

  const AdaptiveBackButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Platform.isIOS
          ? const Icon(Icons.arrow_back_ios)
          : const Icon(Icons.arrow_back),
    );
  }
}
