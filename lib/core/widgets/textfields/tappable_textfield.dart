import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';

class TappableTextfield extends StatefulWidget {
  final String hint;
  final void Function() onTap;
  final TextEditingController controller;
  const TappableTextfield({
    super.key,
    required this.hint,
    required this.onTap,
    required this.controller,
  });

  @override
  State<TappableTextfield> createState() => _TappableTextfieldState();
}

class _TappableTextfieldState extends State<TappableTextfield> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: Sizes().width(context, 0.02)),
          child: Text(
            widget.hint,
            style: theme.textTheme.headlineMedium!.copyWith(
              color: rentWheelsInformationDark900,
            ),
          ),
        ),
        Container(
          width: Sizes().width(context, 0.85),
          decoration: BoxDecoration(
            border: Border.all(
              color: rentWheelsNeutralLight200,
            ),
            borderRadius: BorderRadius.circular(
              Sizes().width(context, 0.035),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: Sizes().width(context, 0.04),
          ),
          child: GestureDetector(
            onTap: widget.onTap,
            child: TextField(
              enabled: false,
              controller: widget.controller,
              minLines: 1,
              maxLines: null,
              style: theme.textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: rentWheelsNeutralDark900,
              ),
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: theme.textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: rentWheelsNeutralDark900,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
