import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:rent_wheels/core/widgets/buttons/adaptive_back_button_widget.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/details/key_value_widget.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/src/mainSection/reservations/widgets/price_details_widget.dart';

class MakeReservationPageTwoMock extends StatefulWidget {
  const MakeReservationPageTwoMock({super.key});

  @override
  State<MakeReservationPageTwoMock> createState() =>
      _MakeReservationPageTwoMockState();
}

class _MakeReservationPageTwoMockState
    extends State<MakeReservationPageTwoMock> {
  @override
  Widget build(BuildContext context) {
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
                          const Text(
                            '2021 Tesla Model 3',
                            style: heading5Neutral,
                          ),
                          Space().height(context, 0.008),
                          const Text(
                            'GH¢ 20 /day',
                            style: heading5Information,
                          ),
                          Space().height(context, 0.008),
                          const Text(
                            'Los Santos, Aug 25, 2022 - Aug 30, 2022',
                            style: body2Neutral900,
                          ),
                        ],
                      ),
                      Container(
                        height: Sizes().height(context, 0.08),
                        width: Sizes().width(context, 0.16),
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              'url',
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
                    value: 'Full Name',
                    context: context,
                  ),
                  Space().height(context, 0.01),
                  buildDetailsKeyValue(
                    label: 'Address Line',
                    value: 'Address Line',
                    context: context,
                  ),
                  Space().height(context, 0.01),
                  buildDetailsKeyValue(
                    label: 'Email Address',
                    value: 'Email Address',
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
                    value: '9999999',
                    context: context,
                  ),
                  Space().height(context, 0.01),
                  buildPriceDetailsKeyValue(
                    label: 'Duration',
                    value: '34 weeks',
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
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Total',
                          style: heading5Neutral,
                        ),
                        Text(
                          'Total',
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
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
