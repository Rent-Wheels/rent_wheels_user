import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/models/renter/renter_model.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';

buildRenterOverview({
  required BuildContext context,
  required Renter renter,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        height: Sizes().height(context, 0.06),
        width: Sizes().width(context, 0.12),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(
              renter.profilePicture!,
            ),
          ),
          border: Border.all(color: rentWheelsNeutralLight200),
          color: rentWheelsNeutralLight0,
          borderRadius: BorderRadius.circular(
            Sizes().height(context, 0.015),
          ),
        ),
      ),
      Space().width(context, 0.03),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            renter.name!,
            style: heading5Neutral,
          ),
          Space().height(context, 0.005),
          Text(
            renter.placeOfResidence!,
            style: heading6Neutral500,
          ),
        ],
      )
    ],
  );
}
