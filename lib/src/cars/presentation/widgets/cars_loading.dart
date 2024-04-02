import 'package:flutter/material.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/shimmer_loading_placeholder.dart';

class CarsLoading extends StatelessWidget {
  const CarsLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      isLoading: true,
      child: Container(
        margin: EdgeInsets.only(
          right: Sizes().width(context, 0.03),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Sizes().height(context, 0.2),
              width: Sizes().width(context, 0.6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  Sizes().height(context, 0.02),
                ),
                color: rentWheelsNeutralLight0,
              ),
            ),
            Space().height(context, 0.01),
            Container(
              width: Sizes().width(context, 0.6),
              height: Sizes().height(context, 0.02),
              decoration: BoxDecoration(
                color: rentWheelsNeutralLight0,
                borderRadius: BorderRadius.circular(
                  Sizes().height(context, 0.2),
                ),
              ),
            ),
            Space().height(context, 0.01),
            Container(
              width: Sizes().width(context, 0.2),
              height: Sizes().height(context, 0.02),
              decoration: BoxDecoration(
                color: rentWheelsNeutralLight0,
                borderRadius: BorderRadius.circular(
                  Sizes().height(context, 0.2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
