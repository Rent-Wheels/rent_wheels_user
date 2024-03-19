import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';

presentDatePicker({
  required BuildContext context,
  required void Function(DateTime) onDateTimeChanged,
  required void Function() onPressed,
}) {
  final currentDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  Platform.isIOS
      ? showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return Container(
              height: Sizes().height(context, 0.4),
              color: rentWheelsNeutralLight0,
              child: Column(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return SizedBox(
                        height: constraints.minHeight + 200,
                        child: CupertinoDatePicker(
                          minimumDate: DateTime(1950),
                          maximumDate: DateTime(
                            currentDate.year - 18,
                            currentDate.month,
                            currentDate.day,
                          ),
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: DateTime(
                            currentDate.year - 18,
                          ),
                          onDateTimeChanged: onDateTimeChanged,
                        ),
                      );
                    },
                  ),
                  CupertinoButton(
                    onPressed: onPressed,
                    child: Text(
                      'OK',
                      style: theme.textTheme.headlineSmall!.copyWith(
                        color: rentWheelsNeutralDark900,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        )
      : showDatePicker(
          context: context,
          initialDate: DateTime(2005),
          firstDate: DateTime(1950),
          lastDate: DateTime(2006),
          initialEntryMode: DatePickerEntryMode.input,
          builder: (context, child) {
            return Theme(
              data: theme.copyWith(
                textTheme: TextTheme(
                  titleMedium: theme.textTheme.headlineSmall!.copyWith(
                    color: rentWheelsNeutralDark900,
                  ),
                  headlineMedium: theme.textTheme.titleMedium!.copyWith(
                    color: rentWheelsBrandDark900,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              child: child!,
            );
          },
        ).then((pickedDate) {
          if (pickedDate == null) {
            return;
          }
          onDateTimeChanged(pickedDate);
        });
}
