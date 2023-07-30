import 'package:flutter/material.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';

buildFilterButtons({
  double? width,
  required String label,
  required BuildContext context,
  required void Function()? onTap,
}) {
  return Padding(
    padding: EdgeInsets.only(right: Sizes().width(context, 0.04)),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: Sizes().width(context, 0.04)),
        height: Sizes().height(context, 0.04),
        decoration: BoxDecoration(
            border: Border.all(color: rentWheelsNeutral),
            borderRadius: BorderRadius.circular(
              Sizes().height(context, 0.01),
            ),
            color: rentWheelsNeutralLight0),
        child: Text(
          label,
          style: heading6Brand,
        ),
      ),
    ),
  );
}
