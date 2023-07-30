import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:rent_wheels/src/mainSection/reservations/widgets/reservation_details_widget.dart';
import 'package:rent_wheels/src/mainSection/reservations/presentation/booking/reservation_successful.dart';
import 'package:rent_wheels/src/mainSection/reservations/widgets/reservation_details_bottom_sheet_widget.dart';

import 'package:rent_wheels/core/models/enums/enums.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/core/models/renter/renter_model.dart';
import 'package:rent_wheels/core/models/reservations/reservations_model.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels/core/widgets/buttons/adaptive_back_button_widget.dart';
import 'package:rent_wheels/core/backend/reservations/methods/reservations_methods.dart';

class MakeReservationPageTwo extends StatefulWidget {
  final Car car;
  final Renter renter;
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
  @override
  Widget build(BuildContext context) {
    Car car = widget.car;
    Renter renter = widget.renter;
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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: Sizes().width(context, 0.04),
          right: Sizes().width(context, 0.04),
          bottom: Sizes().height(context, 0.1),
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
      bottomSheet: widget.view == ReservationView.make
          ? buildReservationDetailsBottomSheet(
              buttonTitle: 'Make Reservation',
              context: context,
              onPressed: () async {
                try {
                  buildLoadingIndicator(context, 'Booking Reservation');
                  await RentWheelsReservationsMethods()
                      .makeReservation(reservationDetails: reservation);
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
              },
            )
          : widget.view == ReservationView.view &&
                  (reservation.status != 'Completed' &&
                      reservation.status != 'Cancelled')
              ? buildReservationDetailsBottomSheet(
                  context: context,
                  btnColor: rentWheelsErrorDark700,
                  buttonTitle: 'Cancel Reservation',
                  onPressed: () {},
                )
              : null,
    );
  }
}
