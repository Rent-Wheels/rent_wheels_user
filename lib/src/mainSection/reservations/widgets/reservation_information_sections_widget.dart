import 'package:flutter/material.dart';

import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/models/reservations/reservations_model.dart';
import 'package:rent_wheels/core/util/date_formatter.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/src/mainSection/reservations/widgets/car_image_widget.dart';

Widget buildReservationSections({
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
      Space().height(context, 0.01),
      Text(
        '${car.yearOfManufacture} ${car.make} ${car.model}',
        style: heading3Information,
      ),
      Space().height(context, 0.01),
      Text(
        '${reservation.destination}, ${formatDate(reservation.startDate!)} - ${formatDate(reservation.returnDate!)}',
        style: heading6Brand,
      ),
      Space().height(context, 0.02),
      Row(
        children: [
          buildGenericButtonWidget(
            width: Sizes().width(context, 0.44),
            isActive: true,
            buttonName: 'Write review',
            context: context,
            onPressed: () {},
          ),
          SizedBox(
            width: Sizes().width(context, 0.04),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: Sizes().width(context, 0.44),
              height: Sizes().height(context, 0.06),
              decoration: BoxDecoration(
                  border: Border.all(color: rentWheelsNeutralLight400),
                  borderRadius: BorderRadius.circular(20)),
              child: const Center(
                  child: Text(
                'Booking again',
                style: heading6Brand,
              )),
            ),
          ),
        ],
      )
    ],
  );
}
