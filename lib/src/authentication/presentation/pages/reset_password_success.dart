import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';

class ResetPasswordSuccess extends StatelessWidget {
  final String email;
  const ResetPasswordSuccess({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: rentWheelsBrandDark900,
        backgroundColor: rentWheelsNeutralLight0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline_sharp,
              color: rentWheelsSuccessDark800,
              size: Sizes().height(context, 0.15),
            ),
            Space().height(context, 0.02),
            RichText(
              text: TextSpan(
                text: "A password reset link has been sent to ",
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: rentWheelsInformationDark900,
                ),
                children: [
                  TextSpan(
                    text: email,
                    style: theme.textTheme.headlineMedium!.copyWith(
                      color: rentWheelsInformationDark900,
                    ),
                  )
                ],
              ),
              textAlign: TextAlign.center,
            ),
            Space().height(context, 0.05),
            GenericButton(
              isActive: true,
              buttonName: "Return to login",
              width: Sizes().width(context, 0.85),
              onPressed: () => context.goNamed('login'),
            )
          ],
        ),
      ),
    );
  }
}
