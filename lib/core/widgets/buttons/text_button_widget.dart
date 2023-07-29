import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';

InkWell buildTextButtonWidget({
  Color? btnColor,
  required double width,
  required bool isActive,
  required String buttonName,
  required BuildContext context,
  required void Function()? onPressed,
}) {
  return InkWell(
    onTap: onPressed,
    enableFeedback: true,
    child: SizedBox(
      width: width,
      height: Sizes().height(context, 0.06),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: Sizes().width(context, 0.02)),
        child: Text(
          buttonName,
          style: isActive ? heading5Brand : heading5BrandDeselect,
        ),
      ),
    ),
  );
}
