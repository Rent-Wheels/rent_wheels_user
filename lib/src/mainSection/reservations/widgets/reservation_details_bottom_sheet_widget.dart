import 'package:flutter/material.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';

buildReservationDetailsBottomSheet({
  required String buttonTitle,
  required BuildContext context,
  required void Function() onPressed,
}) {
  return Container(
    color: rentWheelsNeutralLight0,
    padding: EdgeInsets.all(Sizes().height(context, 0.02)),
    height: Sizes().height(context, 0.13),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildGenericButtonWidget(
            width: Sizes().width(context, 0.85),
            isActive: true,
            buttonName: 'Make Reservation',
            context: context,
            onPressed: onPressed),
      ],
    ),
  );
}
