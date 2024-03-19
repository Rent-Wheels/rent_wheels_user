import 'package:flutter/material.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';

class OnboardingSlide extends StatelessWidget {
  final String heading;
  final String imagePath;
  final String description;

  const OnboardingSlide({
    super.key,
    required this.heading,
    required this.imagePath,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: Sizes().width(context, 0.03)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Sizes().height(context, 0.4),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  imagePath,
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(
                Sizes().height(context, 0.015),
              ),
            ),
          ),
          Space().height(context, 0.08),
          Text(
            heading,
            style: theme.textTheme.titleSmall!.copyWith(
              color: rentWheelsBrandDark900,
            ),
          ),
          Space().height(context, 0.02),
          Text(
            description,
            style: theme.textTheme.bodyLarge!.copyWith(
              color: rentWheelsNeutral,
            ),
          ),
        ],
      ),
    );
  }
}
