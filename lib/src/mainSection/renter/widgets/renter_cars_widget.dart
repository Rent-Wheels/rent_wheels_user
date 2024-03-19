import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';

buildRenterCars({
  String? heroTag,
  required double width,
  required Car carDetails,
  required BuildContext context,
  required void Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: heroTag ?? carDetails.media![0].mediaURL,
            child: Container(
              height: Sizes().height(context, 0.15),
              width: width,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(Sizes().height(context, 0.02)),
                color: rentWheelsNeutralLight0,
                image: carDetails.media![0].mediaURL == ''
                    ? null
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          carDetails.media![0].mediaURL,
                        ),
                      ),
              ),
            ),
          ),
          Space().height(context, 0.01),
          Text(
            '${carDetails.yearOfManufacture} ${carDetails.make} ${carDetails.model}',
            style: theme.textTheme.headlineLarge!.copyWith(
              color: rentWheelsInformationDark900,
            ),
          ),
        ],
      ),
    ),
  );
}
