import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';

class GenericButton extends StatefulWidget {
  final double width;
  final bool isActive;
  final Color? btnColor;
  final BoxBorder? border;
  final String buttonName;
  final TextStyle? textStyle;
  final void Function()? onPressed;

  const GenericButton({
    super.key,
    this.border,
    this.btnColor,
    this.textStyle,
    required this.width,
    required this.isActive,
    required this.onPressed,
    required this.buttonName,
  });

  @override
  State<GenericButton> createState() => _GenericButtonState();
}

class _GenericButtonState extends State<GenericButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isActive ? widget.onPressed : null,
      child: Container(
        width: widget.width,
        height: Sizes().height(context, 0.06),
        decoration: BoxDecoration(
          color: widget.isActive
              ? widget.btnColor ?? rentWheelsBrandDark900
              : rentWheelsBrandDark900Trans,
          border: widget.border,
          borderRadius: BorderRadius.circular(Sizes().width(context, 0.035)),
        ),
        child: Container(
          alignment: Alignment.center,
          padding:
              EdgeInsets.symmetric(horizontal: Sizes().width(context, 0.02)),
          child: Text(
            widget.buttonName,
            style: widget.textStyle ??
                theme.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: rentWheelsNeutralLight0,
                ),
          ),
        ),
      ),
    );
  }
}
