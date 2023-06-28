import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:string_validator/string_validator.dart';

import 'package:rent_wheels/src/home/presentation/home.dart';
import 'package:rent_wheels/src/signup/presentation/signup.dart';
import 'package:rent_wheels/src/verify/presentation/verify_email.dart';
import 'package:rent_wheels/src/resetPassword/presentation/forgot_password.dart';

import 'package:rent_wheels/core/auth/auth_service.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/auth/auth_exceptions.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/backend/users/methods/user_methods.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels/core/widgets/textfields/generic_textfield_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isEmailValid = false;
  bool isPasswordValid = false;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isActive() {
    return isEmailValid && isPasswordValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      body: Center(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: EdgeInsets.all(Sizes().height(context, 0.02)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome to Rent Wheels',
                  style: heading3Information,
                ),
                Space().height(context, 0.01),
                const Text(
                  'Enter your account details to continue.',
                  style: body2Neutral,
                ),
                Space().height(context, 0.03),
                buildGenericTextfield(
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
                Space().height(context, 0.02),
                buildGenericTextfield(
                  maxLines: 1,
                  hint: 'Password',
                  context: context,
                  isPassword: true,
                  controller: password,
                  textCapitalization: TextCapitalization.none,
                  textInput: TextInputAction.done,
                  onChanged: (value) {
                    if (isAscii(value) && value.length > 5) {
                      setState(() {
                        isPasswordValid = true;
                      });
                    } else {
                      setState(() {
                        isPasswordValid = false;
                      });
                    }
                  },
                ),
                Space().height(context, 0.05),
                buildGenericButtonWidget(
                  context: context,
                  buttonName: 'Login',
                  isActive: isActive(),
                  width: Sizes().width(context, 0.85),
                  onPressed: () async {
                    buildLoadingIndicator(context, 'Logging In');

                    try {
                      final credential = await AuthService.firebase()
                          .signInWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );

                      if (credential.user != null) {
                        await global.setGlobals(currentUser: credential.user);

                        final user = await RentWheelsUserMethods()
                            .getUserDetails(userId: global.user!.uid);

                        global.setGlobals(fetchedUserDetails: user);

                        if (!mounted) return;
                        Navigator.pop(context);

                        if (!global.user!.emailVerified) {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const VerifyEmail(),
                            ),
                          );
                        } else {
                          Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const Home()),
                              (route) => false);
                        }
                      }
                    } catch (e) {
                      if (!mounted) return;
                      Navigator.pop(context);
                      if (e is UserNotFoundAuthException) {
                        showErrorPopUp(
                          'User does not exist',
                          context,
                        );
                      } else if (e is InvalidPasswordAuthException) {
                        showErrorPopUp(
                          'Invalid email or password',
                          context,
                        );
                      } else if (e is GenericAuthException) {
                        showErrorPopUp(
                          'Please check your internet connection',
                          context,
                        );
                      } else {
                        showErrorPopUp(
                          e.toString(),
                          context,
                        );
                      }
                    }
                  },
                ),
                Space().height(context, 0.02),
                SizedBox(
                  width: Sizes().width(context, 0.85),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const ForgotPassword(),
                          ),
                        ),
                        child: const Text(
                          'Forgot Password?',
                          style: body2Neutral,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: Sizes().height(context, 0.1),
                  color: rentWheelsNeutralLight0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: body2Neutral,
                      ),
                      Space().width(context, 0.01),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const SignUp(),
                            ),
                          );
                        },
                        child: const Text(
                          "Register",
                          style: heading6InformationBold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
