import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';

buildConfirmationPopup({
  String? message,
  required String label,
  required String buttonName,
  required BuildContext context,
  required void Function()? onCancel,
  required void Function()? onAccept,
}) {
  return Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
      Sizes().height(context, 0.015),
    )),
    clipBehavior: Clip.antiAlias,
    alignment: Alignment.bottomCenter,
    child: Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                style: heading3Information,
              ),
              GestureDetector(
                onTap: onCancel,
                child: Icon(
                  Icons.close,
                  color: rentWheelsNeutral,
                  size: Sizes().height(context, 0.04),
                ),
              )
            ],
          ),
          if (message != null)
            Wrap(
              children: [
                Space().height(context, 0.02),
                Text(
                  message,
                  style: body1Neutral500,
                ),
              ],
            ),
          buildGenericButtonWidget(
            width: Sizes().width(context, 0.85),
            isActive: true,
            buttonName: buttonName,
            context: context,
            onPressed: onAccept,
          ),
        ],
      ),
    ),
  );
}
