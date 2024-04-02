import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_wheels/assets/images/image_constants.dart';

import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';

class ReservationSuccessful extends StatelessWidget {
  const ReservationSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Text(
              'Reservation success!',
              style: theme.textTheme.titleSmall!.copyWith(
                color: rentWheelsInformationDark900,
              ),
            ),
            Space().height(context, 0.01),
            Text(
              'Congratulations you booking has been made.',
              style: theme.textTheme.bodyLarge!.copyWith(
                color: rentWheelsNeutralDark900,
              ),
            ),
            Space().height(context, 0.01),
            Text(
              'Thanks for trusting us!',
              style: theme.textTheme.bodyLarge!.copyWith(
                color: rentWheelsNeutralDark900,
              ),
            ),
            Space().height(context, 0.04),
            GenericButton(
              width: Sizes().width(context, 0.85),
              isActive: true,
              buttonName: 'Back to homepage',
              onPressed: () => context.goNamed('home'),
            ),
          ],
        ),
      ),
    );
  }
}
