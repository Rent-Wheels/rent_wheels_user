import 'package:flutter/cupertino.dart';

import 'package:rent_wheels/src/reservations/domain/entity/reservations.dart';
import 'package:rent_wheels/src/reservations/presentation/widgets/reservations_loading.dart';
import 'package:rent_wheels/src/reservations/presentation/widgets/reservation_information.dart';

class ReservationsData extends StatefulWidget {
  final bool isLoading;
  final int currentIndex;
  final List<Reservation> reservations;
  final void Function(int)? filterButtonOnTap;
  const ReservationsData({
    super.key,
    this.isLoading = true,
    this.currentIndex = 0,
    this.filterButtonOnTap,
    required this.reservations,
  });

  @override
  State<ReservationsData> createState() => _ReservationsDataState();
}

class _ReservationsDataState extends State<ReservationsData> {
  Map<String, List<Reservation>> getReservations() {
    Map<String, List<Reservation>> reservationCategories = {
      'All': widget.reservations
    };

    for (var reservation in widget.reservations) {
      String status = reservation.status!;
      if (reservationCategories.containsKey(status)) {
        reservationCategories[status]!.add(reservation);
      } else {
        reservationCategories.addEntries({
          reservation.status!: [reservation]
        }.entries);
      }
    }

    return reservationCategories;
  }

  // modifyReservation({
  //   required String reservationId,
  //   required String reservationStatus,
  // }) async {
  //   String loadingMessage = reservationStatus == 'Cancelled'
  //       ? 'Cancelling Reservation'
  //       : reservationStatus == 'Ongoing'
  //           ? 'Starting Trip'
  //           : 'Ending Trip';

  //   String successMessage = reservationStatus == 'Cancelled'
  //       ? 'Reservation Cancelled'
  //       : reservationStatus == 'Ongoing'
  //           ? 'Trip Started'
  //           : 'Trip Ended';
  //   try {
  //     buildLoadingIndicator(context, loadingMessage);
  //     await RentWheelsReservationsMethods().changeReservationStatus(
  //         reservationId: reservationId, status: reservationStatus);
  //     if (!mounted) return;
  //     if (reservationStatus == 'Cancelled') context.pop();
  //     context.pop();
  //     showSuccessPopUp(successMessage, context);
  //   } catch (e) {
  //     if (!mounted) return;
  //     context.pop();
  //     showErrorPopUp(e.toString(), context);
  //   }
  // }

  // bookTrip({required Car car}) => Navigator.push(
  //       context,
  //       CupertinoPageRoute(
  //         builder: (context) => MakeReservationPageOne(car: car),
  //       ),
  //     );

  @override
  Widget build(BuildContext context) {
    final sections = getReservations();
    return widget.isLoading
        ? ReservationsLoading(
            isLoading: widget.isLoading,
          )
        : ReservationInformation(
            sections: sections,
            currentIndex: widget.currentIndex,
            reservations: widget.reservations,
            filterButtonOnTap:
                widget.isLoading ? null : (p0) => widget.filterButtonOnTap!(p0),
          );
  }
}
