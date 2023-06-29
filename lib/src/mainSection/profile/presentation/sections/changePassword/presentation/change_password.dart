import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:rent_wheels/core/auth/auth_service.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/auth/auth_exceptions.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/core/widgets/popups/success_popup.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels/core/widgets/buttons/adaptive_back_button_widget.dart';
import 'package:rent_wheels/core/widgets/textfields/generic_textfield_widget.dart';

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

  bool isActive() {
    return isOldPasswordValid &&
        isNewPasswordValid &&
        isPasswordConfirmationValid;
  }

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
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: EdgeInsets.all(Sizes().height(context, 0.02)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Reset Password",
                style: heading3Information,
              ),
              Space().height(context, 0.03),
              buildGenericTextfield(
                icon: isOldPasswordVisible
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            isOldPasswordVisible = false;
                          });
                        },
                        child: Icon(
                          Icons.visibility_off_outlined,
                          size: Sizes().width(context, 0.045),
                          color: rentWheelsNeutral,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            isOldPasswordVisible = true;
                          });
                        },
                        child: Icon(
                          Icons.visibility_outlined,
                          size: Sizes().width(context, 0.045),
                          color: rentWheelsNeutral,
                        ),
                      ),
                isPassword: !isOldPasswordVisible,
                hint: 'Old Password',
                context: context,
                controller: oldPassword,
                maxLines: 1,
                enableSuggestions: false,
                onChanged: (value) {
                  if (value.length > 5) {
                    setState(() {
                      isOldPasswordValid = true;
                    });
                  }
                },
              ),
              Space().height(context, 0.02),
              buildGenericTextfield(
                icon: isNewPasswordVisible
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            isNewPasswordVisible = false;
                          });
                        },
                        child: Icon(
                          Icons.visibility_off_outlined,
                          size: Sizes().width(context, 0.045),
                          color: rentWheelsNeutral,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            isNewPasswordVisible = true;
                          });
                        },
                        child: Icon(
                          Icons.visibility_outlined,
                          size: Sizes().width(context, 0.045),
                          color: rentWheelsNeutral,
                        ),
                      ),
                isPassword: !isNewPasswordVisible,
                hint: 'New Password',
                context: context,
                controller: newPassword,
                maxLines: 1,
                enableSuggestions: false,
                onChanged: (value) {
                  final regExp = RegExp(
                      r'(?=^.{8,255}$)((?=.*\d)(?=.*[A-Z])(?=.*[a-z])|(?=.*\d)(?=.*[^A-Za-z0-9])(?=.*[a-z])|(?=.*[^A-Za-z0-9])(?=.*[A-Z])(?=.*[a-z])|(?=.*\d)(?=.*[A-Z])(?=.*[^A-Za-z0-9]))^.*');
                  if (regExp.hasMatch(value)) {
                    setState(() {
                      isNewPasswordValid = true;
                    });
                  } else {
                    setState(() {
                      isNewPasswordValid = false;
                    });
                  }
                },
              ),
              Space().height(context, 0.02),
              buildGenericTextfield(
                icon: isPasswordConfirmationVisible
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            isPasswordConfirmationVisible = false;
                          });
                        },
                        child: Icon(
                          Icons.visibility_off_outlined,
                          size: Sizes().width(context, 0.045),
                          color: rentWheelsNeutral,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            isPasswordConfirmationVisible = true;
                          });
                        },
                        child: Icon(
                          Icons.visibility_outlined,
                          size: Sizes().width(context, 0.045),
                          color: rentWheelsNeutral,
                        ),
                      ),
                isPassword: !isPasswordConfirmationVisible,
                hint: 'Retype new password',
                context: context,
                controller: passwordConfirmation,
                maxLines: 1,
                enableSuggestions: false,
                onChanged: (value) {
                  if (value == newPassword.text) {
                    setState(() {
                      isPasswordConfirmationValid = true;
                    });
                  } else {
                    setState(() {
                      isPasswordConfirmationValid = false;
                    });
                  }
                },
              ),
              Space().height(context, 0.05),
              buildGenericButtonWidget(
                width: Sizes().width(context, 0.85),
                isActive: isActive(),
                buttonName: 'Update Account',
                context: context,
                onPressed: () async {
                  buildLoadingIndicator(context, 'Resetting Password');

                  try {
                    final reauthenticatedUser =
                        await AuthService.firebase().reauthenticateUser(
                      email: global.user!.email,
                      password: oldPassword.text,
                    );

                    await AuthService.firebase().updateUserDetails(
                      user: reauthenticatedUser!.user!,
                      password: newPassword.text,
                    );

                    await FirebaseAuth.instance.currentUser!.reload();

                    final user = FirebaseAuth.instance.currentUser;
                    await global.setGlobals(currentUser: user);

                    setState(() {
                      oldPassword.text = '';
                      newPassword.text = '';
                      passwordConfirmation.text = '';

                      isOldPasswordValid = false;
                      isNewPasswordValid = false;
                      isPasswordConfirmationValid = false;
                    });

                    if (!mounted) return;
                    Navigator.pop(context);
                    showSuccessPopUp('Password Reset', context);
                  } catch (e) {
                    if (!mounted) return;
                    Navigator.pop(context);
                    if (e is InvalidPasswordAuthException) {
                      showErrorPopUp('Incorrect Password', context);
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
      ),
    );
  }
}
