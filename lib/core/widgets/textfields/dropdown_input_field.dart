import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';

class DropdownInputField extends StatefulWidget {
  final dynamic value;
  final String? hintText;
  final void Function(Object?)? onChanged;
  final List<DropdownMenuItem<Object>>? items;
  const DropdownInputField({
    super.key,
    this.value,
    this.hintText,
    required this.items,
    required this.onChanged,
  });

  @override
  State<DropdownInputField> createState() => _DropdownInputFieldState();
}

class _DropdownInputFieldState extends State<DropdownInputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: Sizes().width(context, 0.02)),
          child: Text(
            widget.hintText ?? '',
            style: theme.textTheme.headlineMedium!.copyWith(
              color: rentWheelsInformationDark900,
            ),
          ),
        ),
        Container(
          width: Sizes().width(context, 0.85),
          padding: EdgeInsets.only(
            left: Sizes().width(context, 0.04),
            right: Sizes().width(context, 0.02),
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: rentWheelsNeutralLight200,
            ),
            borderRadius: BorderRadius.circular(
              Sizes().width(context, 0.035),
            ),
          ),
          child: DropdownButtonFormField(
            value: widget.value,
            icon: Icon(
              Icons.arrow_drop_down,
              color: rentWheelsNeutral,
              size: Sizes().height(context, 0.03),
            ),
            style: theme.textTheme.headlineSmall!
                .copyWith(color: rentWheelsNeutralDark900),
            dropdownColor: rentWheelsNeutralLight0,
            items: widget.items,
            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }
}
