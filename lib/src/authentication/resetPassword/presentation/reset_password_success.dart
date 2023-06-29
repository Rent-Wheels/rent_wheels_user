import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:rent_wheels/src/authentication/login/presentation/login.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';

class ResetPasswordSuccess extends StatelessWidget {
  final String email;
  const ResetPasswordSuccess({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
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
                style: body1Information,
                children: [
                  TextSpan(
                    text: email,
                    style: heading5Information,
                  )
                ],
              ),
              textAlign: TextAlign.center,
            ),
            Space().height(context, 0.05),
            buildGenericButtonWidget(
              context: context,
              width: Sizes().width(context, 0.85),
              isActive: true,
              buttonName: "Return to login",
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(
                  builder: (context) => const Login(),
                ),
                (route) => false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
