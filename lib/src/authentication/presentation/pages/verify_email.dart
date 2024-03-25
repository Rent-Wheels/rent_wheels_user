import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_wheels/assets/images/image_constants.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/injection.dart';
import 'package:rent_wheels/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rent_wheels/src/global/presentation/provider/global_provider.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/core/widgets/popups/success_popup.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels/src/user/presentation/bloc/user_bloc.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  late GlobalProvider _globalProvider;

  final _userBloc = sl<UserBloc>();
  final _authBloc = sl<AuthenticationBloc>();

  logout() {
    buildLoadingIndicator(context, 'Logging Out');
    _authBloc.add(LogoutEvent());
  }

  verifyEmail() {
    buildLoadingIndicator(context, '');

    _globalProvider.reloadUser();

    if (!_globalProvider.user!.emailVerified) {
      context.pop();
      showErrorPopUp('Email not verified.', context);
      return;
    }

    getUserDetails();
  }

  getUserDetails() {
    final params = {
      'urlParameters': {
        'userId': _globalProvider.user?.uid,
      },
      'headers': _globalProvider.headers
    };

    _userBloc.add(GetUserDetailsEvent(params: params));
  }

  resendVerificationEmail() {
    buildLoadingIndicator(context, '');

    _authBloc.add(
      VerifyEmailEvent(
        params: {
          'user': _globalProvider.user!,
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _globalProvider = context.watch<GlobalProvider>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: rentWheelsNeutralLight0,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes().width(context, 0.02),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.logout,
                color: rentWheelsErrorDark700,
              ),
              onPressed: logout,
            ),
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener(
            bloc: _authBloc,
            listener: (context, state) {
              if (state is GenericFirebaseAuthError) {
                context.pop();
                showErrorPopUp(state.errorMessage, context);
              }

              if (state is VerifyEmailLoaded) {
                context.pop();
                showSuccessPopUp('Email Verification Sent', context);
              }

              if (state is LogoutLoaded) {
                context.pop();
                context.goNamed('login');
              }
            },
          ),
          BlocListener(
            bloc: _userBloc,
            listener: (context, state) {
              if (state is GetUserDetailsLoaded) {
                _globalProvider.updateUserDetails(state.user);
                context.pop();
                context.goNamed('home');
              }
            },
          )
        ],
        child: Padding(
          padding: EdgeInsets.all(Sizes().height(context, 0.02)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                emailSentImg,
                width: Sizes().width(context, 0.5),
              ),
              Space().height(context, 0.02),
              Text(
                'Verify your email address',
                style: theme.textTheme.titleSmall!.copyWith(
                  color: rentWheelsInformationDark900,
                ),
              ),
              Space().height(context, 0.02),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'A verification email has been sent to ',
                  children: [
                    TextSpan(
                      text: '${_globalProvider.user!.email}',
                      style: theme.textTheme.headlineMedium!.copyWith(
                        color: rentWheelsInformationDark900,
                      ),
                    ),
                  ],
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: rentWheelsInformationDark900,
                  ),
                ),
              ),
              Space().height(context, 0.03),
              GenericButton(
                width: Sizes().width(context, 0.5),
                isActive: true,
                btnColor: rentWheelsSuccessDark700,
                buttonName: 'Confirm Verification',
                onPressed: verifyEmail,
              ),
              Space().height(context, 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive an email?",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: rentWheelsNeutral,
                    ),
                  ),
                  Space().width(context, 0.01),
                  GestureDetector(
                    onTap: resendVerificationEmail,
                    child: Text(
                      "Resend Email",
                      style: theme.textTheme.headlineSmall!.copyWith(
                        color: rentWheelsInformationDark900,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
