import 'package:flutter/material.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';

final ThemeData theme = ThemeData(
  useMaterial3: true,
  textTheme: _textTheme,
  fontFamily: 'Urbanist',
  appBarTheme: _appBarTheme,
  primaryColor: rentWheelsNeutral,
  inputDecorationTheme: _inputDecorationTheme,
  scaffoldBackgroundColor: rentWheelsNeutralLight0,
);

const AppBarTheme _appBarTheme = AppBarTheme(
  elevation: 0,
  foregroundColor: rentWheelsBrandDark900,
  backgroundColor: rentWheelsNeutralLight0,
);

const TextTheme _textTheme = TextTheme(
  titleLarge: TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w700,
  ),
  titleMedium: TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w700,
  ),
  titleSmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  ),
  headlineLarge: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  ),
  headlineMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  ),
  headlineSmall: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  ),
  bodyLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  ),
);

const InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
  border: InputBorder.none,
  hintStyle: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: rentWheelsNeutral,
  ),
);
