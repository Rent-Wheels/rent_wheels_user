import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';

SizedBox buildCarsData({
  required double width,
  required Car carDetails,
  required BuildContext context,
}) {
  return SizedBox(
    width: width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: Sizes().height(context, 0.03),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                '${global.baseURL}/${carDetails.media![0].mediaURL}',
              ),
            ),
          ),
        ),
        Text(
          '${carDetails.yearOfManufacture} ${carDetails.make} ${carDetails.model}',
          style: heading4Information,
        ),
        Space().height(context, 0.02),
        Text(
          'GH¢${carDetails.rate} ${carDetails.plan}',
          style: heading4Information,
        ),
      ],
    ),
  );
}
