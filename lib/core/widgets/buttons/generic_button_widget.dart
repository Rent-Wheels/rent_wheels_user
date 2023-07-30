import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';

GestureDetector buildGenericButtonWidget({
  Color? btnColor,
  TextStyle? textStyle,
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
        border: Border.all(color: rentWheelsNeutralLight400),
        borderRadius: BorderRadius.circular(Sizes().width(context, 0.035)),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: Sizes().width(context, 0.02)),
        child: Text(
          buttonName,
          style: textStyle ?? heading5Neutral0,
        ),
      ),
    ),
  );
}
