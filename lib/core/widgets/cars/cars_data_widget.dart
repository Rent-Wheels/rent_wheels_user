import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';

Container buildCarsData({
  required double width,
  required Car carDetails,
  required bool isLoading,
  required BuildContext context,
}) {
  return Container(
    width: width,
    margin: EdgeInsets.only(right: Sizes().width(context, 0.03)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: Sizes().height(context, 0.2),
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes().height(context, 0.02)),
            color: rentWheelsNeutralLight0,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(
                '${global.baseURL}/${carDetails.media![0].mediaURL}',
              ),
            ),
          ),
        ),
        Space().height(context, 0.01),
        isLoading
            ? Container(
                width: double.infinity,
                height: Sizes().height(context, 0.02),
                decoration: BoxDecoration(
                  color: rentWheelsNeutralLight0,
                  borderRadius:
                      BorderRadius.circular(Sizes().height(context, 0.2)),
                ),
              )
            : Text(
                '${carDetails.yearOfManufacture} ${carDetails.make} ${carDetails.model}',
                style: heading4Information,
              ),
        Space().height(context, 0.01),
        isLoading
            ? Container(
                width: Sizes().width(context, 0.2),
                height: Sizes().height(context, 0.02),
                decoration: BoxDecoration(
                  color: rentWheelsNeutralLight0,
                  borderRadius:
                      BorderRadius.circular(Sizes().height(context, 0.2)),
                ),
              )
            : Text(
                'GH¢${carDetails.rate} ${carDetails.plan}',
                style: body1Information,
              ),
      ],
    ),
  );
}
