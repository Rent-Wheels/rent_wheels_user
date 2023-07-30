import 'package:flutter/material.dart';

import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/models/reservations/reservations_model.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/src/mainSection/reservations/widgets/car_image_widget.dart';

import '../../../../core/widgets/sizes/sizes.dart';
import '../../../../core/widgets/textStyles/text_styles.dart';
import '../../../../core/widgets/theme/colors.dart';

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
      Space().height(context, 0.005),
      Text('${car.model} - ${car.yearOfManufacture}', style: heading3Information,),
      Space().height(context, 0.005),
      Text('${reservation.destination}, ${takeAndBringDates(reservation.startDate!, reservation.returnDate!)}', style: heading6Brand,),
      Space().height(context, 0.01),
      Row(children: [
        buildGenericButtonWidget(width: Sizes().width(context, 0.44), isActive: true, buttonName: 'Write review', context: context, onPressed: (){}),
        SizedBox(width: Sizes().width(context, 0.04),),
        GestureDetector(
          onTap: (){},
          child: Container(
            width: Sizes().width(context, 0.44),
            height: Sizes().height(context, 0.06),
            decoration: BoxDecoration(border: Border.all(color: rentWheelsNeutralLight400), borderRadius: BorderRadius.circular(20)),
            child: const Center(child: Text('Booking again', style: heading6Brand,)),
          ),
        ),
        ],
      )
    ],
  );
}

String takeAndBringDates(DateTime? take, DateTime? bring) {
  /// If take and bring dates of the same month, return <Month> <take_day> - <bring_day> <year>
  /// Else if of the same year but different months, return <take_month> <take_day> - <bring_month> <bring_day> <year>
  /// Else if of different years do the above and specify the years for each.
  if(take == null || bring == null) return '';

  bool eqlMonth = take.month == bring.month;
  bool eqlYear = take.year == bring.year;

  return '${months[take.month]} ${take.day} ${eqlYear?'':take.year} - ${eqlMonth?'':months[bring.month]} ${bring.day} ${bring.year}';
}

List<String> months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];