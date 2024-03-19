import 'package:flutter/material.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/assets/images/image_constants.dart';

class ErrorMessage extends StatelessWidget {
  final String label;
  final String? errorMessage;

  const ErrorMessage({
    super.key,
    this.errorMessage,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(errorImg),
        Space().height(context, 0.03),
        Text(
          label,
          style: theme.textTheme.titleSmall!.copyWith(
            color: rentWheelsInformationDark900,
          ),
        ),
        Text(
          errorMessage?.replaceAll(RegExp(r'(Exception:|")'), '') ?? '',
          style: theme.textTheme.bodyMedium!.copyWith(
            color: rentWheelsNeutral,
          ),
        )
      ],
    );
  }
}
