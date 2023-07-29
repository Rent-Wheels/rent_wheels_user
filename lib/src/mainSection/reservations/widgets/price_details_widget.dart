import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';

SizedBox buildPriceDetailsKeyValue({
  required String label,
  required String value,
  required BuildContext context,
}) {
  return SizedBox(
    width: Sizes().width(context, 0.85),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: heading6Neutral500,
        ),
        Text(
          value,
          style: heading6Neutral900Bold,
        ),
      ],
    ),
  );
}
