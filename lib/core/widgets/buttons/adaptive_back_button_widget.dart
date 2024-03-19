import 'dart:io';

import 'package:flutter/material.dart';

//TODO: CHANGE TO CONTAINER
class AdaptiveBackButton extends StatelessWidget {
  final void Function() onPressed;

  const AdaptiveBackButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Platform.isIOS
          ? const Icon(Icons.arrow_back_ios)
          : const Icon(Icons.arrow_back),
    );
  }
}
