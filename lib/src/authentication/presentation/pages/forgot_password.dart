import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/injection.dart';
import 'package:rent_wheels/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:string_validator/string_validator.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
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
  bool _isEmailValid = false;

  final _authBloc = sl<AuthenticationBloc>();
  final TextEditingController _email = TextEditingController();

  resetPassword() {
    buildLoadingIndicator(context, '');
    final params = {
      'email': _email.text,
    };

    _authBloc.add(ResetPasswordEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AdaptiveBackButton(
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocListener(
        bloc: _authBloc,
        listener: (context, state) {
          if (state is GenericFirebaseAuthError) {
            context.pop();
            showErrorPopUp(state.errorMessage, context);
          }

          if (state is ResetPasswordLoaded) {
            context.pop();
            context.goNamed(
              'resetPasswordSuccess',
              queryParameters: {
                'email': _email.text,
              },
            );
          }
        },
        child: Padding(
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
                controller: _email,
                hint: 'Email Address',
                enableSuggestions: false,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                onChanged: (value) {
                  setState(() {
                    _isEmailValid = isEmail(value);
                  });
                },
              ),
              Space().height(context, 0.05),
              GenericButton(
                isActive: _isEmailValid,
                buttonName: 'Recover Account',
                width: Sizes().width(context, 0.85),
                onPressed: resetPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}