import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';

class ConfirmationPopup extends StatefulWidget {
  final String label;
  final String? message;
  final String buttonName;
  final BuildContext context;
  final void Function()? onCancel;
  final void Function()? onAccept;

  const ConfirmationPopup({
    super.key,
    this.message,
    required this.label,
    required this.context,
    required this.onCancel,
    required this.onAccept,
    required this.buttonName,
  });

  @override
  State<ConfirmationPopup> createState() => _ConfirmationPopupState();
}

class _ConfirmationPopupState extends State<ConfirmationPopup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes().height(context, 0.28),
      padding: EdgeInsets.symmetric(
        vertical: Sizes().height(context, 0.01),
        horizontal: Sizes().width(context, 0.04),
      ),
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
                widget.label,
                style: theme.textTheme.titleSmall!.copyWith(
                  color: rentWheelsInformationDark900,
                ),
              ),
              GestureDetector(
                onTap: widget.onCancel,
                child: Icon(
                  Icons.close,
                  color: rentWheelsNeutral,
                  size: Sizes().height(context, 0.04),
                ),
              )
            ],
          ),
          if (widget.message != null)
            Wrap(
              children: [
                Space().height(context, 0.02),
                Text(
                  widget.message!,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: rentWheelsNeutral,
                  ),
                ),
              ],
            ),
          GenericButton(
            width: Sizes().width(context, 0.85),
            isActive: true,
            buttonName: widget.buttonName,
            onPressed: widget.onAccept,
          ),
        ],
      ),
    );
  }
}
