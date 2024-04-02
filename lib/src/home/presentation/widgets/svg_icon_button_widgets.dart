import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';

import 'package:rent_wheels/core/widgets/theme/colors.dart';

class SVGIconButton extends StatelessWidget {
  final String svg;
  final void Function()? onPressed;

  const SVGIconButton({
    super.key,
    required this.svg,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SvgPicture.asset(
        svg,
        height: Sizes().height(context, 0.025),
        colorFilter: const ColorFilter.mode(
          rentWheelsNeutralDark900,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
