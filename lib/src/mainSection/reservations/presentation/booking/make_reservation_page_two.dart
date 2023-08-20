import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:rent_wheels/src/mainSection/payment/presentation/payment.dart';
import 'package:rent_wheels/src/mainSection/reservations/widgets/reservation_details_widget.dart';
import 'package:rent_wheels/src/mainSection/reservations/presentation/booking/reservation_successful.dart';
import 'package:rent_wheels/src/mainSection/reservations/presentation/booking/make_reservation_page_one.dart';
import 'package:rent_wheels/src/mainSection/reservations/widgets/reservation_details_bottom_sheet_widget.dart';

import 'package:rent_wheels/core/models/enums/enums.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/extenstions/date_compare.dart';
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/core/models/renter/renter_model.dart';
import 'package:rent_wheels/core/widgets/popups/success_popup.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/models/reservations/reservations_model.dart';
import 'package:rent_wheels/core/widgets/dialogs/confirmation_dialog_widget.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels/core/widgets/buttons/adaptive_back_button_widget.dart';
import 'package:rent_wheels/core/backend/reservations/methods/reservations_methods.dart';

class MakeReservationPageTwo extends StatefulWidget {
  final Car? car;
  final Renter? renter;
  final ReservationView view;
  final ReservationModel reservation;

  const MakeReservationPageTwo({
    super.key,
    required this.car,
    required this.view,
    required this.renter,
    required this.reservation,
  });

  @override
  State<MakeReservationPageTwo> createState() => _MakeReservationPageTwoState();
}

class _MakeReservationPageTwoState extends State<MakeReservationPageTwo> {
  makeReservation() async {
    try {
      buildLoadingIndicator(context, 'Making Reservation');
      await RentWheelsReservationsMethods()
          .makeReservation(reservationDetails: widget.reservation);
      if (!mounted) return;
      Navigator.pop(context);
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => const ReservationSuccessful(),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      showErrorPopUp(e.toString(), context);
    }
  }

  modifyReservation({
    required String reservationStatus,
  }) async {
    String loadingMessage = reservationStatus == 'Cancelled'
        ? 'Cancelling Reservation'
        : reservationStatus == 'Ongoing'
            ? 'Starting Trip'
            : 'Ending Trip';

    String successMessage = reservationStatus == 'Cancelled'
        ? 'Reservation Cancelled'
        : reservationStatus == 'Ongoing'
            ? 'Trip Started'
            : 'Trip Ended';
    try {
      buildLoadingIndicator(context, loadingMessage);
      await RentWheelsReservationsMethods().changeReservationStatus(
          reservationId: widget.reservation.id!, status: reservationStatus);
      if (!mounted) return;
      Navigator.pop(context);
      showSuccessPopUp(successMessage, context);
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      showErrorPopUp(e.toString(), context);
    }
  }

  bookAgain() => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => MakeReservationPageOne(car: widget.car),
        ),
      );

  @override
  Widget build(BuildContext context) {
    Car? car = widget.car;
    Renter? renter = widget.renter;
    ReservationModel reservation = widget.reservation;

    Duration getDuration() {
      Duration duration = reservation.returnDate
              ?.difference(reservation.startDate ?? DateTime.now()) ??
          const Duration(days: 0);

      if (reservation.returnDate!.isAtSameMomentAs(reservation.startDate!)) {
        duration = const Duration(days: 1);
      }

      return duration;
    }

    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: rentWheelsBrandDark900,
        backgroundColor: rentWheelsNeutralLight0,
        leading: buildAdaptiveBackButton(
          onPressed: () => Navigator.pop(context, reservation.status),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: Sizes().width(context, 0.04),
            right: Sizes().width(context, 0.04),
            bottom: Sizes().height(context, 0.15),
          ),
          child: widget.view == ReservationView.make
              ? buildReservationDetails(
                  car: car,
                  renter: renter,
                  pageTitle: 'Make Reservation',
                  duration: getDuration(),
                  context: context,
                  reservation: reservation,
                )
              : buildReservationDetails(
                  car: car,
                  renter: renter,
                  pageTitle: 'Reservation',
                  duration: getDuration(),
                  context: context,
                  reservation: reservation,
                ),
        ),
      ),
      bottomSheet: widget.view == ReservationView.make
          ? buildReservationDetailsBottomSheet(
              items: [
                buildGenericButtonWidget(
                  isActive: true,
                  context: context,
                  buttonName: 'Make Reservation',
                  width: Sizes().width(context, 0.85),
                  onPressed: makeReservation,
                ),
              ],
              context: context,
            )
          : widget.view == ReservationView.view && car != null
              ? reservation.status == 'Pending'
                  ? buildReservationDetailsBottomSheet(
                      context: context,
                      items: [
                        buildGenericButtonWidget(
                          isActive: true,
                          context: context,
                          buttonName: 'Cancel Reservation',
                          btnColor: rentWheelsErrorDark700,
                          width: Sizes().width(context, 0.85),
                          onPressed: () => buildConfirmationDialog(
                            context: context,
                            label: 'Cancel Reservation',
                            buttonName: 'Cancel Reservation',
                            message:
                                'Are you sure you want to cancel your reservation?',
                            onAccept: () async {
                              await modifyReservation(
                                  reservationStatus: 'Cancelled');
                              setState(() {
                                reservation.status = 'Cancelled';
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  : reservation.status == 'Ongoing'
                      ? buildReservationDetailsBottomSheet(
                          context: context,
                          items: [
                            buildGenericButtonWidget(
                              isActive: true,
                              context: context,
                              buttonName: 'End Trip',
                              btnColor: rentWheelsErrorDark700,
                              width: Sizes().width(context, 0.85),
                              onPressed: () async {
                                await modifyReservation(
                                    reservationStatus: 'Completed');

                                setState(() {
                                  reservation.status = 'Completed';
                                });
                              },
                            ),
                          ],
                        )
                      : reservation.status == 'Accepted'
                          ? buildReservationDetailsBottomSheet(
                              context: context,
                              items: [
                                buildGenericButtonWidget(
                                    isActive: true,
                                    context: context,
                                    buttonName: 'Make Payment',
                                    width: Sizes().width(context, 0.4),
                                    onPressed: () async {
                                      final status = await Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => Payment(
                                            car: car,
                                            reservation: reservation,
                                          ),
                                        ),
                                      );
                                      setState(() {
                                        reservation.status =
                                            status ?? reservation.status;
                                      });
                                    }),
                                Space().width(context, 0.04),
                                buildGenericButtonWidget(
                                  isActive: true,
                                  context: context,
                                  buttonName: 'Cancel Reservation',
                                  btnColor: rentWheelsErrorDark700,
                                  width: Sizes().width(context, 0.4),
                                  onPressed: () => buildConfirmationDialog(
                                    context: context,
                                    label: 'Cancel Reservation',
                                    buttonName: 'Cancel Reservation',
                                    message:
                                        'Are you sure you want to cancel your reservation?',
                                    onAccept: () async {
                                      await modifyReservation(
                                          reservationStatus: 'Cancelled');
                                      setState(() {
                                        reservation.status = 'Cancelled';
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )
                          : reservation.status == 'Paid'
                              ? buildReservationDetailsBottomSheet(
                                  context: context,
                                  items: [
                                    buildGenericButtonWidget(
                                      context: context,
                                      buttonName: 'Start Trip',
                                      width: Sizes().width(context, 0.4),
                                      isActive: DateTime.now()
                                          .isSameDate(reservation.startDate!),
                                      onPressed: () async {
                                        await modifyReservation(
                                            reservationStatus: 'Ongoing');

                                        setState(() {
                                          reservation.status = 'Ongoing';
                                        });
                                      },
                                    ),
                                    Space().width(context, 0.04),
                                    buildGenericButtonWidget(
                                      isActive: true,
                                      context: context,
                                      buttonName: 'Cancel Reservation',
                                      btnColor: rentWheelsErrorDark700,
                                      width: Sizes().width(context, 0.4),
                                      onPressed: () => buildConfirmationDialog(
                                        context: context,
                                        label: 'Cancel Reservation',
                                        buttonName: 'Cancel Reservation',
                                        message:
                                            'Are you sure want to cancel your reservation? Only 50% of the trip price will be refunded to you.',
                                        onAccept: () async {
                                          await modifyReservation(
                                              reservationStatus: 'Cancelled');
                                          setState(() {
                                            reservation.status = 'Cancelled';
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : buildReservationDetailsBottomSheet(
                                  context: context,
                                  items: [
                                    buildGenericButtonWidget(
                                      isActive: true,
                                      context: context,
                                      onPressed: bookAgain,
                                      buttonName: 'Book Again',
                                      width: Sizes().width(context, 0.85),
                                    ),
                                  ],
                                )
              : null,
    );
  }
}
