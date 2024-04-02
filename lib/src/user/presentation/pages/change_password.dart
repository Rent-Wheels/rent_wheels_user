import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/core/widgets/popups/success_popup.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels/core/widgets/buttons/adaptive_back_button_widget.dart';
import 'package:rent_wheels/core/widgets/textfields/generic_textfield_widget.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/injection.dart';
import 'package:rent_wheels/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rent_wheels/src/global/presentation/provider/global_provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isOldPasswordValid = false;
  bool isNewPasswordValid = false;
  bool isPasswordConfirmationValid = false;

  bool isOldPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isPasswordConfirmationVisible = false;

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController passwordConfirmation = TextEditingController();

  late GlobalProvider _globalProvider;
  final _authBloc = sl<AuthenticationBloc>();

  bool isActive() {
    return isOldPasswordValid &&
        isNewPasswordValid &&
        isPasswordConfirmationValid;
  }

  reauthenticateUser() {
    buildLoadingIndicator(context, 'Resetting Password');

    final params = {
      'user': _globalProvider.user,
      'password': oldPassword.text,
      'email': _globalProvider.userDetails!.email,
    };

    _authBloc.add(ReauthenticateUserEvent(params: params));
  }

  resetPassword() {
    final params = {
      'user': _globalProvider.user,
      'password': newPassword.text,
    };

    _authBloc.add(UpdateUserEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    _globalProvider = context.watch<GlobalProvider>();

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

          if (state is ReauthenticateUserLoaded) {
            resetPassword();
          }

          if (state is UpdateUserLoaded) {
            _globalProvider.reloadCurrentUser();
            setState(() {
              oldPassword.text = '';
              newPassword.text = '';
              passwordConfirmation.text = '';

              isOldPasswordValid = false;
              isNewPasswordValid = false;
              isPasswordConfirmationValid = false;
            });

            context.pop();
            showSuccessPopUp('Password Reset', context);
          }
        },
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes().width(context, 0.04),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reset Password",
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: rentWheelsInformationDark900,
                  ),
                ),
                Space().height(context, 0.03),
                GenericTextField(
                  maxLines: 1,
                  isPassword: true,
                  hint: 'Old Password',
                  controller: oldPassword,
                  enableSuggestions: false,
                  isPasswordVisible: isOldPasswordVisible,
                  iconOnTap: () => setState(() {
                    isOldPasswordVisible = !isOldPasswordVisible;
                  }),
                  onChanged: (value) {
                    setState(() {
                      isOldPasswordValid = value.length > 5;
                    });
                  },
                ),
                Space().height(context, 0.02),
                GenericTextField(
                  maxLines: 1,
                  isPassword: true,
                  hint: 'New Password',
                  controller: newPassword,
                  enableSuggestions: false,
                  isPasswordVisible: isNewPasswordVisible,
                  iconOnTap: () => setState(() {
                    isNewPasswordVisible = !isNewPasswordVisible;
                  }),
                  onChanged: (value) {
                    final regExp = RegExp(
                        r'(?=^.{8,255}$)((?=.*\d)(?=.*[A-Z])(?=.*[a-z])|(?=.*\d)(?=.*[^A-Za-z0-9])(?=.*[a-z])|(?=.*[^A-Za-z0-9])(?=.*[A-Z])(?=.*[a-z])|(?=.*\d)(?=.*[A-Z])(?=.*[^A-Za-z0-9]))^.*');
                    setState(() {
                      isNewPasswordValid = regExp.hasMatch(value);
                    });
                  },
                ),
                Space().height(context, 0.02),
                GenericTextField(
                  maxLines: 1,
                  isPassword: true,
                  enableSuggestions: false,
                  hint: 'Retype new password',
                  controller: passwordConfirmation,
                  isPasswordVisible: isPasswordConfirmationVisible,
                  iconOnTap: () => setState(() {
                    isPasswordConfirmationVisible =
                        !isPasswordConfirmationVisible;
                  }),
                  onChanged: (value) => setState(() {
                    isPasswordConfirmationValid = value == newPassword.text;
                  }),
                ),
                Space().height(context, 0.05),
                GenericButton(
                  width: Sizes().width(context, 0.85),
                  isActive: isActive(),
                  buttonName: 'Update Account',
                  onPressed: reauthenticateUser,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
