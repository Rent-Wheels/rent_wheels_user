import 'package:flutter/material.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';

Widget buildCarouselDots({
  double? width,
  Color? inactiveColor,
  required int index,
  required int currentIndex,
  required BuildContext context,
}) {
  return AnimatedContainer(
    curve: Curves.easeInOut,
    duration: const Duration(milliseconds: 200),
    width: currentIndex == index
        ? width ?? Sizes().width(context, 0.1)
        : Sizes().width(context, 0.03),
    height: Sizes().height(context, 0.012),
    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    decoration: ShapeDecoration(
      shape: currentIndex == index
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                Sizes().width(context, 0.03),
              ),
            )
          : const CircleBorder(),
      color: currentIndex == index
          ? rentWheelsBrandDark900
          : inactiveColor ?? rentWheelsNeutralLight0,
    ),
  );
}
