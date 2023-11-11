import 'package:flutter/material.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/models/reservations/reservations_model.dart';

import 'package:rent_wheels/src/mainSection/reservations/widgets/price_details_widget.dart';

import 'package:rent_wheels/core/enums/enums.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';

class PaymentPageTwo extends StatefulWidget {
  final Car car;
  final String value;
  final String cvvCode;
  final String cardNumber;
  final String expiryDate;
  final bool isCvvFocused;
  final String phoneNumber;
  final String cardHolderName;
  final PaymentMethods paymentType;
  final ReservationModel reservation;

  const PaymentPageTwo({
    super.key,
    required this.car,
    required this.value,
    required this.cvvCode,
    required this.cardNumber,
    required this.expiryDate,
    required this.reservation,
    required this.phoneNumber,
    required this.paymentType,
    required this.isCvvFocused,
    required this.cardHolderName,
  });

  @override
  State<PaymentPageTwo> createState() => _PaymentPageTwoState();
}

class _PaymentPageTwoState extends State<PaymentPageTwo> {
  Duration getDuration() {
    Duration duration = widget.reservation.returnDate
            ?.difference(widget.reservation.startDate ?? DateTime.now()) ??
        const Duration(days: 0);

    if (widget.reservation.returnDate!
        .isAtSameMomentAs(widget.reservation.startDate!)) {
      duration = const Duration(days: 1);
    }

    return duration;
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = getDuration();
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      body: Padding(
        padding: EdgeInsets.only(
          left: Sizes().width(context, 0.04),
          right: Sizes().width(context, 0.04),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Payment Details",
                    style: heading5Neutral,
                  ),
                  Space().height(context, 0.02),
                  widget.paymentType == PaymentMethods.creditCard
                      ? CreditCardWidget(
                          cvvCode: widget.cvvCode,
                          cardNumber: widget.cardNumber,
                          expiryDate: widget.expiryDate,
                          isHolderNameVisible: true,
                          showBackView: widget.isCvvFocused,
                          cardHolderName: widget.cardHolderName,
                          cardBgColor: rentWheelsBrandDark900,
                          onCreditCardWidgetChange: (_) {},
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              global.userDetails!.name,
                              style: heading5Neutral,
                            ),
                            Space().height(context, 0.008),
                            Text(
                              widget.phoneNumber,
                              style: heading5Information,
                            ),
                          ],
                        ),
                ],
              ),
            ),
            // Space().height(context, 0.06),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Order Summary",
                  style: heading5Neutral,
                ),
                Space().height(context, 0.02),
                buildPriceDetailsKeyValue(
                  label: 'Trip Price',
                  value: 'GH¢ ${widget.car.rate} ${widget.car.plan}',
                  context: context,
                ),
                Space().height(context, 0.01),
                buildPriceDetailsKeyValue(
                  label: 'Car',
                  value:
                      '${widget.car.yearOfManufacture} ${widget.car.make} ${widget.car.model}',
                  context: context,
                ),
                Space().height(context, 0.01),
                buildPriceDetailsKeyValue(
                  label: 'Destination',
                  value: widget.reservation.destination!,
                  context: context,
                ),
                Space().height(context, 0.01),
                buildPriceDetailsKeyValue(
                  label: 'Duration',
                  value: duration.inDays == 1
                      ? '${duration.inDays} day'
                      : '${duration.inDays} days',
                  context: context,
                ),
                Space().height(context, 0.01),
                DottedDashedLine(
                  height: 0,
                  axis: Axis.horizontal,
                  width: Sizes().width(context, 1),
                  dashColor: rentWheelsNeutral,
                ),
                Space().height(context, 0.01),
                SizedBox(
                  width: Sizes().width(context, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Total',
                        style: heading5Neutral,
                      ),
                      Text(
                        'GH¢ ${widget.reservation.price}',
                        style: heading5Neutral,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
