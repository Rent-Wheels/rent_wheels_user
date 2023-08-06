import 'package:flutter/cupertino.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/core/widgets/popups/success_popup.dart';
import 'package:rent_wheels/src/mainSection/reservations/presentation/booking/make_reservation_page_one.dart';

import 'package:rent_wheels/src/mainSection/reservations/widgets/filter_buttons_widget.dart';
import 'package:rent_wheels/src/mainSection/reservations/presentation/booking/make_reservation_page_two.dart';
import 'package:rent_wheels/src/mainSection/reservations/widgets/reservation_information_sections_widget.dart';

import 'package:rent_wheels/core/models/enums/enums.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/error/error_message_widget.dart';
import 'package:rent_wheels/core/models/reservations/reservations_model.dart';
import 'package:rent_wheels/core/backend/reservations/methods/reservations_methods.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/shimmer_loading_placeholder.dart';

class ReservationsData extends StatefulWidget {
  const ReservationsData({super.key});

  @override
  State<ReservationsData> createState() => _ReservationsDataState();
}

class _ReservationsDataState extends State<ReservationsData> {
  int currentIndex = 0;

  cancelReservation({required String reservationId}) async {
    try {
      buildLoadingIndicator(context, 'Cancelling Reservation');
      await RentWheelsReservationsMethods().changeReservationStatus(
          reservationId: reservationId, status: 'Cancelled');
      if (!mounted) return;
      Navigator.pop(context);
      showSuccessPopUp('Reservation Cancelled', context);
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      showErrorPopUp(e.toString(), context);
    }
  }

  startTrip({required String reservationId}) async {
    try {
      buildLoadingIndicator(context, 'Starting Trip');
      await RentWheelsReservationsMethods().changeReservationStatus(
          reservationId: reservationId, status: 'Ongoing');
      if (!mounted) return;
      Navigator.pop(context);
      showSuccessPopUp('Trip Started', context);
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      showErrorPopUp(e.toString(), context);
    }
  }

  endTrip({required String reservationId}) async {
    try {
      buildLoadingIndicator(context, 'Ending Trip');
      await RentWheelsReservationsMethods().changeReservationStatus(
          reservationId: reservationId, status: 'Completed');
      if (!mounted) return;
      Navigator.pop(context);
      showSuccessPopUp('Trip Ended', context);
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      showErrorPopUp(e.toString(), context);
    }
  }

  bookTrip({required Car car}) => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => MakeReservationPageOne(car: car),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RentWheelsReservationsMethods().getAllReservations(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ReservationModel> reservations = snapshot.data!;
          if (reservations.isNotEmpty) {
            reservations.sort(
              (a, b) => b.createdAt!.compareTo(a.createdAt!),
            );
          }

          List<ReservationModel> pendingReservations() {
            return reservations
                .where((reservation) =>
                    reservation.status!.toLowerCase() == 'pending')
                .toList();
          }

          List<ReservationModel> acceptedReservations() {
            return reservations
                .where((reservation) =>
                    reservation.status!.toLowerCase() == 'accepted')
                .toList();
          }

          List<ReservationModel> declinedReservations() {
            return reservations
                .where((reservation) =>
                    reservation.status!.toLowerCase() == 'declined')
                .toList();
          }

          List<ReservationModel> paidReservations() {
            return reservations
                .where((reservation) =>
                    reservation.status!.toLowerCase() == 'paid')
                .toList();
          }

          List<ReservationModel> ongoingReservations() {
            return reservations
                .where((reservation) =>
                    reservation.status!.toLowerCase() == 'ongoing')
                .toList();
          }

          List<ReservationModel> completedReservations() {
            return reservations
                .where((reservation) =>
                    reservation.status!.toLowerCase() == 'completed')
                .toList();
          }

          List<ReservationModel> cancelledReservations() {
            return reservations
                .where((reservation) =>
                    reservation.status!.toLowerCase() == 'cancelled')
                .toList();
          }

          final Map<String, List<ReservationModel>> sections = {
            'All': reservations,
            'Pending': pendingReservations(),
            'Accepted': acceptedReservations(),
            'Declined': declinedReservations(),
            'Paid': paidReservations(),
            'Ongoing': ongoingReservations(),
            'Completed': completedReservations(),
            'Cancelled': cancelledReservations(),
          };

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Sizes().height(context, 0.05),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sections.length,
                  itemBuilder: (context, index) {
                    return buildFilterButtons(
                      btnColor: currentIndex == index
                          ? rentWheelsBrandDark900
                          : rentWheelsNeutralLight0,
                      style: currentIndex == index
                          ? heading6Neutral0
                          : heading6Brand,
                      label: sections.keys.toList()[index],
                      context: context,
                      onTap: () {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    );
                  },
                ),
              ),
              Space().height(context, 0.02),
              reservations.isEmpty
                  ? buildErrorMessage(
                      label: 'You have no reservations!',
                      context: context,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: sections.values
                          .elementAt(currentIndex)
                          .map((reservation) => Padding(
                                padding: EdgeInsets.only(
                                  bottom: Sizes().height(context, 0.04),
                                ),
                                child: buildReservationSections(
                                  isLoading: false,
                                  context: context,
                                  car: reservation.car!,
                                  reservation: reservation,
                                  onBook: () => bookTrip(car: reservation.car!),
                                  onStart: () async {
                                    await startTrip(
                                        reservationId: reservation.id!);
                                    setState(() {
                                      reservation.status = 'Ongoing';
                                    });
                                  },
                                  onEnd: () async {
                                    await endTrip(
                                        reservationId: reservation.id!);
                                    setState(() {
                                      reservation.status = 'Completed';
                                    });
                                  },
                                  onCancel: () async {
                                    await cancelReservation(
                                        reservationId: reservation.id!);
                                    setState(() {
                                      reservation.status = 'Cancelled';
                                    });
                                  },
                                  onPressed: () async {
                                    final status = await Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            MakeReservationPageTwo(
                                          car: reservation.car!,
                                          view: ReservationView.view,
                                          renter: reservation.renter!,
                                          reservation: reservation,
                                        ),
                                      ),
                                    );

                                    if (status != null) {
                                      setState(() {
                                        reservation.status = status;
                                      });
                                    }
                                  },
                                ),
                              ))
                          .toList(),
                    ),
            ],
          );
        }
        if (snapshot.hasError) {
          return buildErrorMessage(
            label: 'An error occured',
            errorMessage: snapshot.error.toString(),
            context: context,
          );
        }

        return ShimmerLoading(
          isLoading: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Sizes().height(context, 0.05),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return buildFilterButtons(
                      width: Sizes().width(context, 0.2),
                      label: '',
                      context: context,
                      onTap: null,
                    );
                  },
                ),
              ),
              Space().height(context, 0.02),
              SizedBox(
                height: Sizes().height(context, 0.9),
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: Sizes().height(context, 0.04)),
                      child: buildReservationSections(
                        isLoading: true,
                        onPressed: null,
                        context: context,
                        reservation: ReservationModel(),
                        car: Car(media: [Media(mediaURL: '')]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
