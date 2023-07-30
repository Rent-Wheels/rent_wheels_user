import 'package:flutter/material.dart';
import 'package:rent_wheels/core/backend/reservations/methods/reservations_methods.dart';
import 'package:rent_wheels/core/widgets/error/error_message_widget.dart';

class ReservationsData extends StatefulWidget {
  const ReservationsData({super.key});

  @override
  State<ReservationsData> createState() => _ReservationsDataState();
}

class _ReservationsDataState extends State<ReservationsData> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: RentWheelsReservationsMethods().getAllReservations(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data![0].customer!.name!);
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
