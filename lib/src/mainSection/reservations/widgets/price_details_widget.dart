import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';

buildPriceDetailsKeyValue({
  required String label,
  required String value,
  required BuildContext context,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        label,
        style: heading6Neutral500,
      ),
      SizedBox(
        width: Sizes().width(context, 0.5),
        child: Text(
          value,
          style: heading6Neutral900Bold,
          textAlign: TextAlign.right,
        ),
      ),
    ],
  );
}
