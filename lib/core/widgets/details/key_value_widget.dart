import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';

class DetailsKeyValue extends StatelessWidget {
  final String label;
  final String value;

  const DetailsKeyValue({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: theme.textTheme.headlineMedium!.copyWith(
            color: rentWheelsNeutral,
          ),
        ),
        SizedBox(
          width: Sizes().width(context, 0.4),
          child: Text(
            value,
            style: theme.textTheme.headlineSmall!.copyWith(
              color: rentWheelsNeutralDark900,
            ),
          ),
        ),
      ],
    );
  }
}
