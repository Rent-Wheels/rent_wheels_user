import 'package:flutter/material.dart';
import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/models/reservations/reservations_model.dart';
import 'package:rent_wheels/src/mainSection/reservations/widgets/car_image_widget.dart';

buildReservationSections({
  required BuildContext context,
  required Car car,
  required ReservationModel reservation,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildCarImage(
        imageUrl: car.media![0].mediaURL,
        reservationStatus: reservation.status!,
        context: context,
      ),
    ],
  );
}
