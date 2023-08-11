import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';

buildProfileOptions({
  Color? color,
  TextStyle? style,
  required String svg,
  required String section,
  required BuildContext context,
  required void Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: Sizes().width(context, 0.85),
      height: Sizes().height(context, 0.07),
      child: Row(
        children: [
          Container(
            width: Sizes().width(context, 0.082),
            height: Sizes().height(context, 0.04),
            decoration: BoxDecoration(
              border: Border.all(color: color ?? rentWheelsInformationDark900),
              color: rentWheelsNeutralLight0,
              borderRadius: BorderRadius.circular(
                Sizes().height(context, 0.015),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(Sizes().height(context, 0.009)),
              child: SvgPicture.asset(
                svg,
                fit: BoxFit.scaleDown,
                height: Sizes().height(context, 0.01),
                colorFilter: ColorFilter.mode(
                  color ?? rentWheelsInformationDark900,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          Space().width(context, 0.04),
          Text(
            section,
            style: style ?? heading5Information500,
          )
        ],
      ),
    ),
  );
}
