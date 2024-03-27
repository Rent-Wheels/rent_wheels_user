import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';

class ProfileOptions extends StatelessWidget {
  final Color? color;
  final TextStyle? style;
  final String svg;
  final String section;
  final void Function()? onTap;
  const ProfileOptions({
    super.key,
    this.color,
    this.style,
    required this.svg,
    required this.section,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
                border:
                    Border.all(color: color ?? rentWheelsInformationDark900),
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
              style: style ??
                  theme.textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: rentWheelsInformationDark900,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
