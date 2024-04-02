import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_wheels/core/widgets/dialogs/confirmation_dialog_widget.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/error/error_message_widget.dart';
import 'package:rent_wheels/src/cars/domain/entity/cars.dart';
import 'package:rent_wheels/src/reservations/domain/entity/reservations.dart';
import 'package:rent_wheels/src/reservations/presentation/widgets/filter_buttons_widget.dart';
import 'package:rent_wheels/src/reservations/presentation/widgets/reservation_information_sections_widget.dart';

class ReservationInformation extends StatefulWidget {
  final int currentIndex;
  final void Function(Car)? onBook;
  final List<Reservation> reservations;
  final void Function(Reservation)? onEnd;
  final void Function(Reservation)? onStart;
  final void Function(int)? filterButtonOnTap;
  final void Function(Reservation)? onPayment;
  final Map<String, List<Reservation>> sections;
  final void Function(Reservation)? onCancelAccept;

  const ReservationInformation({
    super.key,
    this.onEnd,
    this.onBook,
    this.onStart,
    this.onPayment,
    this.onCancelAccept,
    required this.sections,
    required this.currentIndex,
    required this.reservations,
    required this.filterButtonOnTap,
  });

  @override
  State<ReservationInformation> createState() => _ReservationInformationState();
}

class _ReservationInformationState extends State<ReservationInformation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Sizes().height(context, 0.05),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.sections.length,
            itemBuilder: (context, index) {
              return FilterButtons(
                btnColor: widget.currentIndex == index
                    ? rentWheelsBrandDark900
                    : rentWheelsNeutralLight0,
                style: theme.textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: widget.currentIndex == index
                      ? rentWheelsNeutralLight0
                      : rentWheelsBrandDark900,
                ),
                label: widget.sections.keys.toList()[index],
                onTap: () => widget.filterButtonOnTap!(index),
              );
            },
          ),
        ),
        Space().height(context, 0.02),
        widget.reservations.isEmpty
            ? const ErrorMessage(
                label: 'You have no reservations!',
              )
            : Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.sections.values
                        .elementAt(widget.currentIndex)
                        .map(
                          (reservation) => Padding(
                            padding: EdgeInsets.only(
                              bottom: Sizes().height(context, 0.04),
                            ),
                            child: ReservationSections(
                              isLoading: false,
                              car: reservation.car,
                              reservation: reservation,
                              onPayment: () {
                                if (widget.onPayment != null) {
                                  widget.onPayment!(reservation);
                                }
                              },
                              onBook: () {
                                if (widget.onBook != null) {
                                  widget.onBook!(reservation.car!);
                                }
                              },
                              onStart: () {
                                if (widget.onStart != null) {
                                  widget.onStart!(reservation);
                                }
                              },
                              onEnd: () {
                                if (widget.onEnd != null) {
                                  widget.onEnd!(reservation);
                                }
                              },
                              onCancel: () => buildConfirmationDialog(
                                context: context,
                                label: 'Cancel Reservation',
                                buttonName: 'Cancel Reservation',
                                message: reservation.status == 'Paid'
                                    ? 'Are you sure want to cancel your reservation? Only 50% of the trip price will be refunded to you.'
                                    : 'Are you sure you want to cancel your reservation?',
                                onAccept: () {
                                  if (widget.onCancelAccept != null) {
                                    widget.onCancelAccept!(reservation);
                                  }
                                },
                              ),
                              onPressed: () async {
                                final update = await context.pushNamed(
                                  'reservationDetails',
                                  pathParameters: {
                                    'reservationId': reservation.id!,
                                  },
                                  queryParameters: {
                                    'car': jsonEncode(reservation.car!.toMap()),
                                    'renter':
                                        jsonEncode(reservation.renter!.toMap()),
                                    'reservation':
                                        jsonEncode(reservation.toMap()),
                                  },
                                );

                                if (update != null) {
                                  setState(() {
                                    reservation = update as Reservation;
                                  });
                                }
                              },
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
      ],
    );
  }
}
