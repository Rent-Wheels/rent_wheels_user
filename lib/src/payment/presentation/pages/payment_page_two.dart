import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';

import 'package:rent_wheels/src/cars/domain/entity/cars.dart';
import 'package:rent_wheels/src/payment/presentation/pages/payment_page_one.dart';
import 'package:rent_wheels/src/reservations/domain/entity/reservations.dart';
import 'package:rent_wheels/src/global/presentation/provider/global_provider.dart';
import 'package:rent_wheels/src/reservations/presentation/widgets/price_details_widget.dart';

class PaymentPageTwo extends StatefulWidget {
  final Car car;
  final String value;
  final String cvvCode;
  final String cardNumber;
  final String expiryDate;
  final bool isCvvFocused;
  final String phoneNumber;
  final String cardHolderName;
  final Reservation reservation;
  final PaymentMethods paymentType;

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
  late GlobalProvider _globalProvider;

  Duration getDuration() {
    final startDate = DateTime.parse(widget.reservation.startDate!);
    final returnDate = DateTime.parse(widget.reservation.returnDate!);
    Duration duration = returnDate.difference(startDate);

    if (returnDate.isAtSameMomentAs(startDate)) {
      duration = const Duration(days: 1);
    }

    return duration;
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = getDuration();
    _globalProvider = context.read<GlobalProvider>();
    return Scaffold(
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
                  Text(
                    "Payment Details",
                    style: theme.textTheme.headlineMedium!.copyWith(
                      color: rentWheelsNeutralDark900,
                    ),
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
                              _globalProvider.userDetails!.name!,
                              style: theme.textTheme.headlineMedium!.copyWith(
                                color: rentWheelsNeutralDark900,
                              ),
                            ),
                            Space().height(context, 0.008),
                            Text(
                              widget.phoneNumber,
                              style: theme.textTheme.headlineMedium!.copyWith(
                                color: rentWheelsInformationDark900,
                              ),
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
                Text(
                  "Order Summary",
                  style: theme.textTheme.headlineMedium!.copyWith(
                    color: rentWheelsNeutralDark900,
                  ),
                ),
                Space().height(context, 0.02),
                PriceDetailsKeyValue(
                  label: 'Trip Price',
                  value: 'GH¢ ${widget.car.rate} ${widget.car.plan}',
                ),
                Space().height(context, 0.01),
                PriceDetailsKeyValue(
                  label: 'Car',
                  value:
                      '${widget.car.yearOfManufacture} ${widget.car.make} ${widget.car.model}',
                ),
                Space().height(context, 0.01),
                PriceDetailsKeyValue(
                  label: 'Destination',
                  value: widget.reservation.destination!,
                ),
                Space().height(context, 0.01),
                PriceDetailsKeyValue(
                  label: 'Duration',
                  value: duration.inDays == 1
                      ? '${duration.inDays} day'
                      : '${duration.inDays} days',
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
                      Text(
                        'Total',
                        style: theme.textTheme.headlineMedium!.copyWith(
                          color: rentWheelsNeutralDark900,
                        ),
                      ),
                      Text(
                        'GH¢ ${widget.reservation.price}',
                        style: theme.textTheme.headlineMedium!.copyWith(
                          color: rentWheelsNeutralDark900,
                        ),
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