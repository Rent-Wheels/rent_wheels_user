import 'package:flutter/material.dart';
import 'package:rent_wheels/assets/images/image_constants.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/src/mainSection/base.dart';

class ReservationSuccessful extends StatelessWidget {
  const ReservationSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes().width(context, 0.04),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(carImageImg),
            Space().height(context, 0.04),
            const Text(
              'Reservation success!',
              style: heading3Information,
            ),
            Space().height(context, 0.01),
            const Text(
              'Congratulations you booking has been made.',
              style: body1Neutral900,
            ),
            Space().height(context, 0.01),
            const Text(
              'Thanks for trusting us!',
              style: body1Neutral900,
            ),
            Space().height(context, 0.04),
            buildGenericButtonWidget(
              width: Sizes().width(context, 0.85),
              isActive: true,
              buttonName: 'Back to homepage',
              context: context,
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainSection(
                    pageIndex: 2,
                  ),
                ),
                (route) => false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
