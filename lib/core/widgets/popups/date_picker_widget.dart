import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}

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
          builder: (_) {
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
                    child: const Text(
                      'OK',
                      style: heading6Neutral900,
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
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: getMaterialColor(rentWheelsInformationDark900),
                  accentColor: rentWheelsBrandDark700,
                ),
                textTheme: const TextTheme(
                  titleMedium: heading6Neutral900,
                  headlineMedium: heading2BrandLight,
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
