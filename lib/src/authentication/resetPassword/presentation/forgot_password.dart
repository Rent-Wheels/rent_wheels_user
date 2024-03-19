import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:string_validator/string_validator.dart';

import 'package:rent_wheels/src/authentication/resetPassword/presentation/reset_password_success.dart';

import 'package:rent_wheels/core/auth/auth_service.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/auth/auth_exceptions.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels/core/widgets/buttons/adaptive_back_button_widget.dart';
import 'package:rent_wheels/core/widgets/textfields/generic_textfield_widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isEmailValid = false;

  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: rentWheelsNeutralLight0,
        foregroundColor: rentWheelsBrandDark900,
        leading: AdaptiveBackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizes().height(context, 0.02)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Forgot Password?',
              style: theme.textTheme.titleSmall!.copyWith(
                color: rentWheelsInformationDark900,
              ),
            ),
            Space().height(context, 0.01),
            Text(
              'Please enter your email to recover your account.',
              style: theme.textTheme.bodyMedium!.copyWith(
                color: rentWheelsNeutral,
              ),
            ),
            Space().height(context, 0.03),
            GenericTextField(
              maxLines: 1,
              context: context,
              controller: email,
              hint: 'Email Address',
              enableSuggestions: false,
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
              onChanged: (value) {
                if (isEmail(value)) {
                  setState(() {
                    isEmailValid = true;
                  });
                } else {
                  setState(() {
                    isEmailValid = false;
                  });
                }
              },
            ),
            Space().height(context, 0.05),
            GenericButton(
              buttonName: 'Recover Account',
              isActive: isEmailValid,
              width: Sizes().width(context, 0.85),
              onPressed: () async {
                buildLoadingIndicator(context, '');
                try {
                  await AuthService.firebase().resetPassword(email: email.text);

                  if (!mounted) return;
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                      builder: (context) =>
                          ResetPasswordSuccess(email: email.text),
                    ),
                    (route) => false,
                  );
                } catch (e) {
                  if (!mounted) return;
                  Navigator.pop(context);
                  if (e is GenericAuthException) {
                  } else {
                    showErrorPopUp(
                      e.toString(),
                      context,
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
