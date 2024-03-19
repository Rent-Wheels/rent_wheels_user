import 'package:flutter/material.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';

import 'package:rent_wheels/src/mainSection/reservations/widgets/price_details_widget.dart';

import 'package:rent_wheels/core/util/date_formatter.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/models/renter/renter_model.dart';
import 'package:rent_wheels/core/widgets/details/key_value_widget.dart';
import 'package:rent_wheels/core/models/reservations/reservations_model.dart';

class ReservationDetails extends StatelessWidget {
  final Car? car;
  final Renter? renter;
  final String pageTitle;
  final Duration duration;
  final ReservationModel reservation;

  const ReservationDetails({
    super.key,
    required this.car,
    required this.renter,
    required this.pageTitle,
    required this.duration,
    required this.reservation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          pageTitle,
          style: theme.textTheme.titleSmall!.copyWith(
            color: rentWheelsInformationDark900,
          ),
        ),
        Space().height(context, 0.03),
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Vehicle Details",
                style: theme.textTheme.headlineMedium!.copyWith(
                  color: rentWheelsNeutralDark900,
                ),
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
                        style: theme.textTheme.headlineMedium!.copyWith(
                          color: rentWheelsNeutralDark900,
                        ),
                      ),
                      Space().height(context, 0.008),
                      Text(
                        'GH¢ ${car?.rate ?? ''} ${car?.plan ?? ''}',
                        style: theme.textTheme.headlineMedium!.copyWith(
                          color: rentWheelsInformationDark900,
                        ),
                      ),
                      Space().height(context, 0.008),
                      SizedBox(
                        width: Sizes().width(context, 0.6),
                        child: Text(
                          car?.location ?? '',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: rentWheelsNeutralDark900,
                          ),
                        ),
                      ),
                      Space().height(context, 0.008),
                      SizedBox(
                        width: Sizes().width(context, 0.6),
                        child: Text(
                          '${formatDate(reservation.startDate!)} - ${formatDate(reservation.returnDate!)}',
                          style: theme.textTheme.headlineSmall!.copyWith(
                            color: rentWheelsNeutralDark900,
                          ),
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
              Text(
                "Renter Information",
                style: theme.textTheme.headlineMedium!.copyWith(
                  color: rentWheelsNeutralDark900,
                ),
              ),
              Space().height(context, 0.02),
              DetailsKeyValue(
                label: 'Full Name',
                value: renter?.name ?? '',
              ),
              Space().height(context, 0.01),
              DetailsKeyValue(
                label: 'Address Line',
                value: renter?.placeOfResidence ?? '',
              ),
              Space().height(context, 0.01),
              DetailsKeyValue(
                label: 'Phone Number',
                value: renter?.phoneNumber ?? '',
              ),
              Space().height(context, 0.01),
              DetailsKeyValue(
                label: 'Email Address',
                value: renter?.email ?? '',
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
              Text(
                "Price",
                style: theme.textTheme.headlineMedium!.copyWith(
                  color: rentWheelsNeutralDark900,
                ),
              ),
              Space().height(context, 0.02),
              PriceDetailsKeyValue(
                label: 'Trip Price',
                value: 'GH¢ ${car?.rate ?? ''} ${car?.plan ?? ''}',
              ),
              Space().height(context, 0.01),
              PriceDetailsKeyValue(
                label: 'Destination',
                value: reservation.destination!,
              ),
              Space().height(context, 0.01),
              PriceDetailsKeyValue(
                label: 'Duration',
                value: duration.inDays == 1
                    ? '${duration.inDays} day'
                    : '${duration.inDays} days',
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
                    Text(
                      'Total',
                      style: theme.textTheme.headlineMedium!.copyWith(
                        color: rentWheelsNeutralDark900,
                      ),
                    ),
                    Text(
                      'GH¢ ${reservation.price}',
                      style: theme.textTheme.headlineMedium!.copyWith(
                        color: rentWheelsNeutralDark900,
                      ),
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
}
