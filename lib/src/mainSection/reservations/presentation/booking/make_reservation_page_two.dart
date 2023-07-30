import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rent_wheels/core/backend/reservations/methods/reservations_methods.dart';
import 'package:rent_wheels/core/util/date_formatter.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/models/renter/renter_model.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/details/key_value_widget.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/models/reservations/reservations_model.dart';
import 'package:rent_wheels/core/widgets/buttons/adaptive_back_button_widget.dart';
import 'package:rent_wheels/src/mainSection/reservations/presentation/booking/reservation_successful.dart';
import 'package:rent_wheels/src/mainSection/reservations/widgets/price_details_widget.dart';

class MakeReservationPageTwo extends StatefulWidget {
  final Car car;
  final Renter renter;
  final ReservationModel reservation;

  const MakeReservationPageTwo({
    super.key,
    required this.car,
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
          bottom: Sizes().height(context, 0.05),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Make Reservation",
              style: heading3Information,
            ),
            Space().height(context, 0.03),
            Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Vehicle Details",
                    style: heading5Neutral,
                  ),
                  Space().height(context, 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${car.yearOfManufacture} ${car.make} ${car.model}',
                            style: heading5Neutral,
                          ),
                          Space().height(context, 0.008),
                          Text(
                            'GH¢ ${car.rate} ${car.plan}',
                            style: heading5Information,
                          ),
                          Space().height(context, 0.008),
                          SizedBox(
                            width: Sizes().width(context, 0.6),
                            child: Text(
                              '${car.location}',
                              style: body2Neutral900,
                            ),
                          ),
                          Space().height(context, 0.008),
                          Text(
                            '${formatDate(reservation.startDate!)} - ${formatDate(reservation.returnDate!)}',
                            style: heading6Neutral900Bold,
                          ),
                        ],
                      ),
                      Container(
                        height: Sizes().height(context, 0.15),
                        width: Sizes().width(context, 0.3),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              car.media![0].mediaURL,
                            ),
                          ),
                          border: Border.all(color: rentWheelsNeutralLight200),
                          color: rentWheelsNeutralLight0,
                          borderRadius: BorderRadius.circular(
                            Sizes().height(context, 0.015),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Space().height(context, 0.04),
                  const Text(
                    "Renter Information",
                    style: heading5Neutral,
                  ),
                  Space().height(context, 0.02),
                  buildDetailsKeyValue(
                    label: 'Full Name',
                    value: renter.name!,
                    context: context,
                  ),
                  Space().height(context, 0.01),
                  buildDetailsKeyValue(
                    label: 'Address Line',
                    value: renter.placeOfResidence!,
                    context: context,
                  ),
                  Space().height(context, 0.01),
                  buildDetailsKeyValue(
                    label: 'Phone Number',
                    value: renter.phoneNumber!,
                    context: context,
                  ),
                  Space().height(context, 0.01),
                  buildDetailsKeyValue(
                    label: 'Email Address',
                    value: renter.email!,
                    context: context,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Price",
                    style: heading5Neutral,
                  ),
                  Space().height(context, 0.02),
                  buildPriceDetailsKeyValue(
                    label: 'Trip Price',
                    value: 'GH¢ ${car.rate} ${car.plan}',
                    context: context,
                  ),
                  Space().height(context, 0.01),
                  buildPriceDetailsKeyValue(
                    label: 'Duration',
                    value: getDuration().inDays == 1
                        ? '${getDuration().inDays} day'
                        : '${getDuration().inDays} days',
                    context: context,
                  ),
                  Space().height(context, 0.01),
                  DottedDashedLine(
                    height: 0,
                    axis: Axis.horizontal,
                    width: Sizes().width(context, 0.85),
                    dashColor: rentWheelsNeutral,
                  ),
                  Space().height(context, 0.01),
                  SizedBox(
                    width: Sizes().width(context, 0.85),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Total',
                          style: heading5Neutral,
                        ),
                        Text(
                          'GH¢ ${reservation.price}',
                          style: heading5Neutral,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomSheet: Container(
        color: rentWheelsNeutralLight0,
        padding: EdgeInsets.all(Sizes().height(context, 0.02)),
        height: Sizes().height(context, 0.13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildGenericButtonWidget(
              width: Sizes().width(context, 0.85),
              isActive: true,
              buttonName: 'Continue',
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
            ),
          ],
        ),
      ),
    );
  }
}
