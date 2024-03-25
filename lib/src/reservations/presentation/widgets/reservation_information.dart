import 'package:flutter/cupertino.dart';
import 'package:rent_wheels/core/widgets/error/error_message_widget.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/src/reservations/domain/entity/reservations.dart';
import 'package:rent_wheels/src/reservations/presentation/widgets/filter_buttons_widget.dart';
import 'package:rent_wheels/src/reservations/presentation/widgets/reservation_information_sections_widget.dart';

class ReservationInformation extends StatelessWidget {
  final int currentIndex;
  final List<Reservation> reservations;
  final void Function(int)? filterButtonOnTap;
  final Map<String, List<Reservation>> sections;

  const ReservationInformation({
    super.key,
    required this.sections,
    required this.currentIndex,
    required this.reservations,
    required this.filterButtonOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Sizes().height(context, 0.05),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sections.length,
            itemBuilder: (context, index) {
              return FilterButtons(
                btnColor: currentIndex == index
                    ? rentWheelsBrandDark900
                    : rentWheelsNeutralLight0,
                style: theme.textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: currentIndex == index
                      ? rentWheelsNeutralLight0
                      : rentWheelsBrandDark900,
                ),
                label: sections.keys.toList()[index],
                onTap: () => filterButtonOnTap!(index),
              );
            },
          ),
        ),
        Space().height(context, 0.02),
        reservations.isEmpty
            ? const ErrorMessage(
                label: 'You have no reservations!',
              )
            : Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: sections.values
                        .elementAt(currentIndex)
                        .map(
                          (reservation) => Padding(
                            padding: EdgeInsets.only(
                              bottom: Sizes().height(context, 0.04),
                            ),
                            child: ReservationSections(
                              isLoading: false,
                              car: reservation.car,
                              reservation: reservation,
                              // onPayment: () async {
                              //   final status = await Navigator.push(
                              //     context,
                              //     CupertinoPageRoute(
                              //       builder: (context) => Payment(
                              //         car: reservation.car!,
                              //         reservation: reservation,
                              //       ),
                              //     ),
                              //   );
                              //   setState(() {
                              //     reservation.status =
                              //         status ?? reservation.status;
                              //   });
                              // },
                              // onBook:
                              // () =>
                              //     bookTrip(car: reservation.car!),
                              // onStart: () async {
                              //   await modifyReservation(
                              //     reservationId: reservation.id!,
                              //     reservationStatus: 'Ongoing',
                              //   );
                              //   setState(() {
                              //     reservation.status = 'Ongoing';
                              //   });
                              // },
                              // onEnd: () async {
                              //   await modifyReservation(
                              //     reservationId: reservation.id!,
                              //     reservationStatus: 'Completed',
                              //   );
                              //   setState(() {
                              //     reservation.status = 'Completed';
                              //   });
                              // },
                              // onCancel: () => buildConfirmationDialog(
                              //   context: context,
                              //   label: 'Cancel Reservation',
                              //   buttonName: 'Cancel Reservation',
                              //   message: reservation.status == 'Paid'
                              //       ? 'Are you sure want to cancel your reservation? Only 50% of the trip price will be refunded to you.'
                              //       : 'Are you sure you want to cancel your reservation?',
                              //   onAccept: () async {
                              //     await modifyReservation(
                              //       reservationId: reservation.id!,
                              //       reservationStatus: 'Cancelled',
                              //     );
                              //     setState(() {
                              //       reservation.status = 'Cancelled';
                              //     });
                              //   },
                              // ),
                              onPressed: () async {
                                // final status = await Navigator.push(
                                //   context,
                                //   CupertinoPageRoute(
                                //     builder: (context) =>
                                //         MakeReservationPageTwo(
                                //       car: reservation.car,
                                //       view: ReservationView.view,
                                //       renter: reservation.renter,
                                //       reservation: reservation,
                                //     ),
                                //   ),
                                // );

                                // if (status != null) {
                                //   setState(() {
                                //     reservation.status = status;
                                //   });
                                // }
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
