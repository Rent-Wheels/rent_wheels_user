import 'package:flutter/material.dart';
import 'package:rent_wheels/core/extenstions/date_compare.dart';

import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/models/reservations/reservations_model.dart';
import 'package:rent_wheels/core/util/date_util.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/src/mainSection/reservations/widgets/car_image_widget.dart';

class ReservationSections extends StatefulWidget {
  final Car? car;
  final bool isLoading;
  final void Function()? onEnd;
  final void Function()? onBook;
  final void Function()? onStart;
  final void Function()? onCancel;
  final void Function()? onPayment;
  final void Function()? onPressed;
  final ReservationModel reservation;

  const ReservationSections({
    super.key,
    this.onEnd,
    this.onBook,
    this.onStart,
    this.onCancel,
    this.onPayment,
    required this.car,
    required this.isLoading,
    required this.onPressed,
    required this.reservation,
  });

  @override
  State<ReservationSections> createState() => _ReservationSectionsState();
}

class _ReservationSectionsState extends State<ReservationSections> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: widget.onPressed,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarImage(
                imageUrl: widget.car?.media?[0].mediaURL ?? '',
                reservationStatus: widget.reservation.status ?? '',
              ),
              Space().height(context, 0.01),
              widget.isLoading
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
                      '${widget.car?.yearOfManufacture ?? ''} ${widget.car?.make ?? ''} ${widget.car?.model ?? ''}',
                      style: theme.textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: rentWheelsInformationDark900,
                      ),
                    ),
              Space().height(context, 0.01),
              widget.isLoading
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
                      '${widget.reservation.destination}, ${formatDate(widget.reservation.startDate!)} - ${formatDate(widget.reservation.returnDate!)}',
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
            widget.car != null
                ? widget.reservation.status == 'Pending'
                    ? GenericButton(
                        width: Sizes().width(context, 0.9),
                        isActive: true,
                        btnColor: rentWheelsErrorDark700,
                        buttonName: 'Cancel Reservation',
                        onPressed: widget.onCancel,
                      )
                    : widget.reservation.status == 'Ongoing'
                        ? GenericButton(
                            width: Sizes().width(context, 0.9),
                            isActive: true,
                            btnColor: rentWheelsErrorDark700,
                            buttonName: 'End Trip',
                            onPressed: widget.onEnd,
                          )
                        : widget.reservation.status == 'Completed' ||
                                widget.reservation.status == 'Cancelled' ||
                                widget.reservation.status == 'Declined'
                            ? GenericButton(
                                width: Sizes().width(context, 0.9),
                                isActive: true,
                                buttonName: 'Book Again',
                                onPressed: widget.onBook,
                              )
                            : widget.reservation.status == 'Paid'
                                ? Wrap(
                                    children: [
                                      GenericButton(
                                        width: Sizes().width(context, 0.4),
                                        isActive: DateTime.now().isSameDate(
                                            widget.reservation.startDate!),
                                        buttonName: 'Start Trip',
                                        onPressed: widget.onStart,
                                      ),
                                      Space().width(context, 0.04),
                                      GenericButton(
                                        width: Sizes().width(context, 0.4),
                                        isActive: true,
                                        onPressed: widget.onCancel,
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
                                        onPressed: widget.onPayment,
                                      ),
                                      Space().width(context, 0.04),
                                      GenericButton(
                                        isActive: true,
                                        btnColor: rentWheelsErrorDark700,
                                        buttonName: 'Cancel Reservation',
                                        width: Sizes().width(context, 0.4),
                                        onPressed: widget.onCancel,
                                      ),
                                    ],
                                  )
                : const SizedBox(),
          ],
        )
      ],
    );
  }
}
