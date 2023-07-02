import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/theme/colors.dart';

buildSVGIconButton({
  required String svg,
  required void Function()? onPressed,
}) {
  return GestureDetector(
    onTap: () {},
    child: SvgPicture.asset(
      svg,
      colorFilter: const ColorFilter.mode(
        rentWheelsNeutralDark900,
        BlendMode.srcIn,
      ),
    ),
  );
}
