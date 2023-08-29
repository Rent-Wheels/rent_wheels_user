import 'package:flutter/cupertino.dart';

import 'package:rent_wheels/src/mainSection/payment/presentation/payment.dart';
import 'package:rent_wheels/src/mainSection/reservations/widgets/filter_buttons_widget.dart';
import 'package:rent_wheels/src/mainSection/reservations/presentation/booking/make_reservation_page_one.dart';
import 'package:rent_wheels/src/mainSection/reservations/presentation/booking/make_reservation_page_two.dart';
import 'package:rent_wheels/src/mainSection/reservations/widgets/reservation_information_sections_widget.dart';

import 'package:rent_wheels/core/models/enums/enums.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/core/widgets/popups/success_popup.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/error/error_message_widget.dart';
import 'package:rent_wheels/core/models/reservations/reservations_model.dart';
import 'package:rent_wheels/core/widgets/dialogs/confirmation_dialog_widget.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels/core/backend/reservations/methods/reservations_methods.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/shimmer_loading_placeholder.dart';

class ReservationsData extends StatefulWidget {
  const ReservationsData({super.key});

  @override
  State<ReservationsData> createState() => _ReservationsDataState();
}

class _ReservationsDataState extends State<ReservationsData> {
  int currentIndex = 0;

  modifyReservation({
    required String reservationId,
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
          reservationId: reservationId, status: reservationStatus);
      if (!mounted) return;
      if (reservationStatus == 'Cancelled') Navigator.pop(context);
      Navigator.pop(context);
      showSuccessPopUp(successMessage, context);
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

          Map<String, List<ReservationModel>> getReservations() {
            Map<String, List<ReservationModel>> reservationCategories = {
              'All': reservations
            };

            for (var reservation in reservations) {
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

          final Map<String, List<ReservationModel>> sections =
              getReservations();

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
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Column(
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
                                      car: reservation.car,
                                      reservation: reservation,
                                      onPayment: () async {
                                        final status = await Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) => Payment(
                                              car: reservation.car!,
                                              reservation: reservation,
                                            ),
                                          ),
                                        );
                                        setState(() {
                                          reservation.status =
                                              status ?? reservation.status;
                                        });
                                      },
                                      onBook: () =>
                                          bookTrip(car: reservation.car!),
                                      onStart: () async {
                                        await modifyReservation(
                                          reservationId: reservation.id!,
                                          reservationStatus: 'Ongoing',
                                        );
                                        setState(() {
                                          reservation.status = 'Ongoing';
                                        });
                                      },
                                      onEnd: () async {
                                        await modifyReservation(
                                          reservationId: reservation.id!,
                                          reservationStatus: 'Completed',
                                        );
                                        setState(() {
                                          reservation.status = 'Completed';
                                        });
                                      },
                                      onCancel: () => buildConfirmationDialog(
                                        context: context,
                                        label: 'Cancel Reservation',
                                        buttonName: 'Cancel Reservation',
                                        message: reservation.status == 'Paid'
                                            ? 'Are you sure want to cancel your reservation? Only 50% of the trip price will be refunded to you.'
                                            : 'Are you sure you want to cancel your reservation?',
                                        onAccept: () async {
                                          await modifyReservation(
                                            reservationId: reservation.id!,
                                            reservationStatus: 'Cancelled',
                                          );
                                          setState(() {
                                            reservation.status = 'Cancelled';
                                          });
                                        },
                                      ),
                                      onPressed: () async {
                                        final status = await Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                MakeReservationPageTwo(
                                              car: reservation.car,
                                              view: ReservationView.view,
                                              renter: reservation.renter,
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
                      ),
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
              Expanded(
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
