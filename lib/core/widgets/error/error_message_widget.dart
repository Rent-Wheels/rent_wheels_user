import 'package:flutter/material.dart';
import 'package:rent_wheels/assets/images/image_constants.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';

import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';

buildErrorMessage({
  String? errorMessage,
  required String label,
  required BuildContext context,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset(errorImg),
      Space().height(context, 0.03),
      Text(
        label,
        style: heading3Information,
      ),
      Text(
        errorMessage?.replaceAll(RegExp(r'(Exception:|")'), '') ?? '',
        style: body2Neutral,
      )
    ],
  );
}
