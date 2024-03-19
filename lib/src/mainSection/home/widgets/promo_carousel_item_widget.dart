import 'package:flutter/widgets.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';

buildPromoCarouselItem({
  required String label,
  required String image,
  required BuildContext context,
}) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: Sizes().width(context, 0.01),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: Sizes().height(context, 0.28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(
                Sizes().width(context, 0.05),
              ),
            ),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Space().height(context, 0.02),
        Text(
          label,
          style: theme.textTheme.titleSmall!.copyWith(
            color: rentWheelsInformationDark900,
          ),
        )
      ],
    ),
  );
}
