import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';

buildConfirmationPopup({
  String? message,
  required String label,
  required BuildContext context,
  required void Function()? onCancel,
  required void Function()? onAccept,
}) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Container(
        height: double.infinity,
        color: Colors.black.withOpacity(0.4),
      ),
      Container(
        width: Sizes().width(context, 0.85),
        height: Sizes().height(context, 0.28),
        padding: EdgeInsets.all(Sizes().height(context, 0.02)),
        margin: EdgeInsets.only(bottom: Sizes().height(context, 0.1)),
        decoration: BoxDecoration(
          color: rentWheelsNeutralLight0,
          borderRadius: BorderRadius.circular(
            Sizes().height(context, 0.015),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: heading3Information,
                ),
                Icon(
                  Icons.close,
                  color: rentWheelsNeutral,
                  size: Sizes().height(context, 0.04),
                )
              ],
            ),
            Space().height(context, 0.02),
            Text(
              message ?? '',
              style: body1Neutral500,
            ),
            Space().height(context, 0.02),
            buildGenericButtonWidget(
              width: Sizes().width(context, 0.85),
              isActive: true,
              buttonName: 'Logout',
              context: context,
              onPressed: null,
            ),
          ],
        ),
      )
    ],
  );
}
