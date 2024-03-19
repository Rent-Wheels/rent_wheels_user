import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';

buildTappableTextField({
  required String hint,
  required BuildContext context,
  required TextEditingController controller,
  required void Function() onTap,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(bottom: Sizes().width(context, 0.02)),
        child: Text(
          hint,
          style: theme.textTheme.headlineMedium!.copyWith(
            color: rentWheelsInformationDark900,
          ),
        ),
      ),
      Container(
        width: Sizes().width(context, 0.85),
        decoration: BoxDecoration(
          border: Border.all(
            color: rentWheelsNeutralLight200,
          ),
          borderRadius: BorderRadius.circular(
            Sizes().width(context, 0.035),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: Sizes().width(context, 0.04)),
        child: GestureDetector(
          onTap: onTap,
          child: TextField(
            enabled: false,
            controller: controller,
            minLines: 1,
            maxLines: null,
            style: theme.textTheme.headlineSmall!
                .copyWith(color: rentWheelsNeutralDark900),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: theme.textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: rentWheelsNeutralDark900,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    ],
  );
}
