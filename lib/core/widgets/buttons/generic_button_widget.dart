import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';

GestureDetector buildGenericButtonWidget({
  Color? btnColor,
  required double width,
  required bool isActive,
  required String buttonName,
  required BuildContext context,
  required void Function() onPressed,
}) {
  return GestureDetector(
    onTap: isActive ? onPressed : null,
    child: Container(
      width: width,
      height: Sizes().height(context, 0.06),
      decoration: BoxDecoration(
        color: isActive
            ? btnColor ?? rentWheelsBrandDark900
            : rentWheelsBrandDark900Trans,
        borderRadius: BorderRadius.circular(Sizes().width(context, 0.035)),
      ),
      child: Center(
        child: Text(
          buttonName,
          style: heading5Neutral0,
        ),
      ),
    ),
  );
}
