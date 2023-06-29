import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';

buildGenericTextfield({
  Widget? icon,
  int? minLines,
  int? maxLines,
  bool? isPassword,
  bool? enableSuggestions,
  required String hint,
  TextInputAction? textInput,
  TextInputType? keyboardType,
  required BuildContext context,
  TextCapitalization? textCapitalization,
  required TextEditingController controller,
  required void Function(String) onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(bottom: Sizes().width(context, 0.02)),
        child: Text(
          hint,
          style: heading5Information,
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
        padding: EdgeInsets.symmetric(horizontal: Sizes().width(context, 0.04)),
        child: TextField(
          minLines: minLines,
          maxLines: maxLines,
          controller: controller,
          obscuringCharacter: '*',
          style: heading6Neutral900,
          keyboardType: keyboardType,
          obscureText: isPassword ?? false,
          cursorColor: rentWheelsBrandDark900,
          autocorrect: enableSuggestions ?? isPassword == null,
          enableSuggestions: enableSuggestions ?? isPassword == null,
          textInputAction: textInput ?? TextInputAction.next,
          textCapitalization:
              textCapitalization ?? TextCapitalization.sentences,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            hintStyle: heading6Neutral500,
            suffix: icon,
          ),
          onChanged: onChanged,
        ),
      ),
    ],
  );
}
