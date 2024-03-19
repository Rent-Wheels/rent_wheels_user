import 'package:flutter/material.dart';
import 'package:rent_wheels/core/extenstions/date_compare.dart';

import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/models/reservations/reservations_model.dart';
import 'package:rent_wheels/core/util/date_formatter.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/src/mainSection/reservations/widgets/car_image_widget.dart';

Widget buildReservationSections({
  required Car? car,
  required bool isLoading,
  required BuildContext context,
  required void Function()? onPressed,
  required ReservationModel reservation,
  void Function()? onEnd,
  void Function()? onBook,
  void Function()? onStart,
  void Function()? onCancel,
  void Function()? onPayment,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCarImage(
              imageUrl: car?.media?[0].mediaURL ?? '',
              reservationStatus: reservation.status ?? '',
              context: context,
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
                    '${car?.yearOfManufacture ?? ''} ${car?.make ?? ''} ${car?.model ?? ''}',
                    style: theme.textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: rentWheelsInformationDark900,
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
                    '${reservation.destination}, ${formatDate(reservation.startDate!)} - ${formatDate(reservation.returnDate!)}',
                    style: theme.textTheme.headlineSmall!.copyWith(
                      color: rentWheelsBrandDark900,
                    ),
                  ),
          ],
        ),
      ),
      Space().height(context, 0.02),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          car != null
              ? reservation.status == 'Pending'
                  ? GenericButton(
                      width: Sizes().width(context, 0.9),
                      isActive: true,
                      btnColor: rentWheelsErrorDark700,
                      buttonName: 'Cancel Reservation',
                      onPressed: onCancel,
                    )
                  : reservation.status == 'Ongoing'
                      ? GenericButton(
                          width: Sizes().width(context, 0.9),
                          isActive: true,
                          btnColor: rentWheelsErrorDark700,
                          buttonName: 'End Trip',
                          onPressed: onEnd,
                        )
                      : reservation.status == 'Completed' ||
                              reservation.status == 'Cancelled' ||
                              reservation.status == 'Declined'
                          ? GenericButton(
                              width: Sizes().width(context, 0.9),
                              isActive: true,
                              buttonName: 'Book Again',
                              onPressed: onBook,
                            )
                          : reservation.status == 'Paid'
                              ? Wrap(
                                  children: [
                                    GenericButton(
                                      width: Sizes().width(context, 0.4),
                                      isActive: DateTime.now()
                                          .isSameDate(reservation.startDate!),
                                      buttonName: 'Start Trip',
                                      onPressed: onStart,
                                    ),
                                    Space().width(context, 0.04),
                                    GenericButton(
                                      width: Sizes().width(context, 0.4),
                                      isActive: true,
                                      onPressed: onCancel,
                                      btnColor: rentWheelsErrorDark700,
                                      buttonName: 'Cancel Reservation',
                                    ),
                                  ],
                                )
                              : Wrap(
                                  children: [
                                    GenericButton(
                                      width: Sizes().width(context, 0.4),
                                      isActive: true,
                                      buttonName: 'Make Payment',
                                      onPressed: onPayment,
                                    ),
                                    Space().width(context, 0.04),
                                    GenericButton(
                                      isActive: true,
                                      btnColor: rentWheelsErrorDark700,
                                      buttonName: 'Cancel Reservation',
                                      width: Sizes().width(context, 0.4),
                                      onPressed: onCancel,
                                    ),
                                  ],
                                )
              : const SizedBox(),
        ],
      )
    ],
  );
}
