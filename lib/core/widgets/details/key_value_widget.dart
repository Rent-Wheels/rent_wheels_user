import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';

buildDetailsKeyValue({
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
        style: heading5Neutral500,
      ),
      SizedBox(
        width: Sizes().width(context, 0.4),
        child: Text(
          value,
          style: heading6Neutral900,
        ),
      ),
    ],
  );
}
