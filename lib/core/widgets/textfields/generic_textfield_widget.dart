import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';

class GenericTextField extends StatefulWidget {
  final Widget? icon;
  final int? minLines;
  final int? maxLines;
  final bool? isPassword;
  final bool? enableSuggestions;
  final String hint;
  final TextInputAction? textInput;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final TextEditingController controller;
  final void Function(String) onChanged;
  const GenericTextField({
    super.key,
    this.icon,
    this.minLines,
    this.maxLines,
    this.isPassword,
    this.enableSuggestions,
    required this.hint,
    this.textInput,
    this.keyboardType,
    this.textCapitalization,
    required this.controller,
    required this.onChanged,
  });

  @override
  State<GenericTextField> createState() => _GenericTextFieldState();
}

class _GenericTextFieldState extends State<GenericTextField> {
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
          padding:
              EdgeInsets.symmetric(horizontal: Sizes().width(context, 0.04)),
          child: TextField(
            obscuringCharacter: '*',
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            cursorColor: rentWheelsBrandDark900,
            obscureText: widget.isPassword ?? false,
            textInputAction: widget.textInput ?? TextInputAction.next,
            autocorrect: widget.enableSuggestions ?? widget.isPassword == null,
            enableSuggestions:
                widget.enableSuggestions ?? widget.isPassword == null,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.sentences,
            style: theme.textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.w600,
              color: rentWheelsNeutralDark900,
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              suffix: widget.icon,
            ),
            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }
}
