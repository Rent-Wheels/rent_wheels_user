import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';

class PriceDetailsKeyValue extends StatelessWidget {
  final String label;
  final String value;
  const PriceDetailsKeyValue({
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
          style: theme.textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.w500,
            color: rentWheelsNeutralDark900,
          ),
        ),
        SizedBox(
          width: Sizes().width(context, 0.5),
          child: Text(
            value,
            style: theme.textTheme.headlineSmall!.copyWith(
              color: rentWheelsNeutralDark900,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
