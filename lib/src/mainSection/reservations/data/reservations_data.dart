import 'package:flutter/material.dart';
import 'package:rent_wheels/core/backend/reservations/methods/reservations_methods.dart';
import 'package:rent_wheels/core/models/reservations/reservations_model.dart';
import 'package:rent_wheels/core/widgets/error/error_message_widget.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/src/mainSection/reservations/widgets/filter_buttons_widget.dart';
import 'package:rent_wheels/src/mainSection/reservations/widgets/reservation_information_sections_widget.dart';

class ReservationsData extends StatefulWidget {
  const ReservationsData({super.key});

  @override
  State<ReservationsData> createState() => _ReservationsDataState();
}

class _ReservationsDataState extends State<ReservationsData> {
  final List<String> sections = [
    'All',
    'Ongoing',
    'Completed',
    'Cancelled',
  ];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: RentWheelsReservationsMethods().getAllReservations(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ReservationModel> reservations = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Sizes().height(context, 0.03),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sections.length,
                  itemBuilder: (context, index) {
                    return buildFilterButtons(
                      label: sections[index],
                      context: context,
                      onTap: () {},
                    );
                  },
                ),
              ),
              Space().height(context, 0.02),
              ...reservations
                  .map((reservation) => Padding(
                        padding: EdgeInsets.only(
                          bottom: Sizes().height(context, 0.04),
                        ),
                        child: buildReservationSections(
                          context: context,
                          car: reservation.car!,
                          reservation: reservation,
                        ),
                      ))
                  .toList()
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

        return const Text('');
      },
    );
  }
}
