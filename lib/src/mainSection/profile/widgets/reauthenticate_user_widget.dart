import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/textfields/generic_textfield_widget.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';

buildReauthenticateUserDialog({
  required BuildContext context,
  required void Function() onSubmit,
  required TextEditingController controller,
}) =>
    showDialog(
        context: context,
        builder: (context) {
          bool isPasswordVisible = false;
          bool isPasswordValid = false;

          return StatefulBuilder(
            builder: (context, setState) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                Sizes().height(context, 0.015),
              )),
              clipBehavior: Clip.antiAlias,
              alignment: Alignment.center,
              child: Container(
                width: Sizes().width(context, 0.9),
                height: Sizes().height(context, 0.28),
                padding: EdgeInsets.symmetric(
                  vertical: Sizes().height(context, 0.01),
                  horizontal: Sizes().width(context, 0.04),
                ),
                color: rentWheelsNeutralLight0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Please enter your password to continue',
                      style: theme.textTheme.headlineMedium!.copyWith(
                        color: rentWheelsNeutralDark900,
                      ),
                    ),
                    GenericTextField(
                      maxLines: 1,
                      context: context,
                      hint: 'Password',
                      onChanged: (value) {
                        if (value.length > 5) {
                          setState(() {
                            isPasswordValid = true;
                          });
                        } else {
                          setState(() {
                            isPasswordValid = false;
                          });
                        }
                      },
                      controller: controller,
                      enableSuggestions: false,
                      isPassword: !isPasswordVisible,
                      icon: isPasswordVisible
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPasswordVisible = false;
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
                                  isPasswordVisible = true;
                                });
                              },
                              child: Icon(
                                Icons.visibility_outlined,
                                size: Sizes().width(context, 0.045),
                                color: rentWheelsNeutral,
                              ),
                            ),
                    ),
                    GenericButton(
                      width: Sizes().width(context, 0.9),
                      isActive: isPasswordValid,
                      buttonName: 'Continue',
                      onPressed: onSubmit,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
