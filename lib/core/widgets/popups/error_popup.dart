import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';

showErrorPopUp(String content, BuildContext context) {
  return Flushbar(
    padding: EdgeInsets.symmetric(
        horizontal: Sizes().width(context, 0.1),
        vertical: Sizes().height(context, 0.02)),
    messageText: Wrap(
      children: [
        Icon(
          Icons.error_outline,
          color: rentWheelsNeutralLight0,
          size: Sizes().height(context, 0.02),
        ),
        Space().width(context, 0.02),
        Text(
          content.replaceAll(RegExp(r'(Exception:|")'), ''),
          style: body1NeutralLight,
        ),
      ],
    ),
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    backgroundColor: rentWheelsErrorDark800,
    duration: const Duration(seconds: 4),
  )..show(context);
}
