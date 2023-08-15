import 'package:flutter/material.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:rent_wheels/src/mainSection/reservations/widgets/price_details_widget.dart';

import 'package:rent_wheels/core/util/date_formatter.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/models/renter/renter_model.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/details/key_value_widget.dart';
import 'package:rent_wheels/core/models/reservations/reservations_model.dart';

buildReservationDetails({
  required Car? car,
  required Renter? renter,
  required String pageTitle,
  required Duration duration,
  required BuildContext context,
  required ReservationModel reservation,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        pageTitle,
        style: heading3Information,
      ),
      Space().height(context, 0.03),
      Flexible(
        flex: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Vehicle Details",
              style: heading5Neutral,
            ),
            Space().height(context, 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${car?.yearOfManufacture ?? ''} ${car?.make ?? ''} ${car?.model ?? ''}',
                      style: heading5Neutral,
                    ),
                    Space().height(context, 0.008),
                    Text(
                      'GH¢ ${car?.rate ?? ''} ${car?.plan ?? ''}',
                      style: heading5Information,
                    ),
                    Space().height(context, 0.008),
                    SizedBox(
                      width: Sizes().width(context, 0.6),
                      child: Text(
                        car?.location ?? '',
                        style: body2Neutral900,
                      ),
                    ),
                    Space().height(context, 0.008),
                    SizedBox(
                      width: Sizes().width(context, 0.6),
                      child: Text(
                        '${formatDate(reservation.startDate!)} - ${formatDate(reservation.returnDate!)}',
                        style: heading6Neutral900Bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: Sizes().height(context, 0.15),
                  width: Sizes().width(context, 0.3),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        car?.media![0].mediaURL ?? '',
                      ),
                    ),
                    border: Border.all(color: rentWheelsNeutralLight200),
                    color: rentWheelsNeutralLight0,
                    borderRadius: BorderRadius.circular(
                      Sizes().height(context, 0.015),
                    ),
                  ),
                ),
              ],
            ),
            Space().height(context, 0.04),
            const Text(
              "Renter Information",
              style: heading5Neutral,
            ),
            Space().height(context, 0.02),
            buildDetailsKeyValue(
              label: 'Full Name',
              value: renter?.name ?? '',
              context: context,
            ),
            Space().height(context, 0.01),
            buildDetailsKeyValue(
              label: 'Address Line',
              value: renter?.placeOfResidence ?? '',
              context: context,
            ),
            Space().height(context, 0.01),
            buildDetailsKeyValue(
              label: 'Phone Number',
              value: renter?.phoneNumber ?? '',
              context: context,
            ),
            Space().height(context, 0.01),
            buildDetailsKeyValue(
              label: 'Email Address',
              value: renter?.email ?? '',
              context: context,
            ),
          ],
        ),
      ),
      Space().height(context, 0.06),
      Flexible(
        flex: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Price",
              style: heading5Neutral,
            ),
            Space().height(context, 0.02),
            buildPriceDetailsKeyValue(
              label: 'Trip Price',
              value: 'GH¢ ${car?.rate ?? ''} ${car?.plan ?? ''}',
              context: context,
            ),
            Space().height(context, 0.01),
            buildPriceDetailsKeyValue(
              label: 'Destination',
              value: reservation.destination!,
              context: context,
            ),
            Space().height(context, 0.01),
            buildPriceDetailsKeyValue(
              label: 'Duration',
              value: duration.inDays == 1
                  ? '${duration.inDays} day'
                  : '${duration.inDays} days',
              context: context,
            ),
            Space().height(context, 0.01),
            DottedDashedLine(
              height: 0,
              axis: Axis.horizontal,
              width: Sizes().width(context, 1),
              dashColor: rentWheelsNeutral,
            ),
            Space().height(context, 0.01),
            SizedBox(
              width: Sizes().width(context, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Total',
                    style: heading5Neutral,
                  ),
                  Text(
                    'GH¢ ${reservation.price}',
                    style: heading5Neutral,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
