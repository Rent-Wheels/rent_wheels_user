import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';

buildDropDownInputField({
  dynamic value,
  String? hintText,
  required BuildContext context,
  required void Function(Object?)? onChanged,
  required List<DropdownMenuItem<Object>>? items,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(bottom: Sizes().width(context, 0.02)),
        child: Text(
          hintText ?? '',
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
          value: value,
          icon: Icon(
            Icons.arrow_drop_down,
            color: rentWheelsNeutral,
            size: Sizes().height(context, 0.03),
          ),
          style: theme.textTheme.headlineSmall!
              .copyWith(color: rentWheelsNeutralDark900),
          dropdownColor: rentWheelsNeutralLight0,
          items: items,
          onChanged: onChanged,
        ),
      ),
    ],
  );
}
