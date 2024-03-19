import 'package:flutter/material.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';

class FilterButtons extends StatefulWidget {
  final double? width;
  final Color? btnColor;
  final TextStyle? style;
  final String label;
  final void Function()? onTap;
  const FilterButtons(
      {super.key,
      this.width,
      this.btnColor,
      this.style,
      required this.label,
      this.onTap});

  @override
  State<FilterButtons> createState() => _FilterButtonsState();
}

class _FilterButtonsState extends State<FilterButtons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: Sizes().width(context, 0.03)),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.width,
          alignment: Alignment.center,
          padding:
              EdgeInsets.symmetric(horizontal: Sizes().width(context, 0.04)),
          height: Sizes().height(context, 0.04),
          decoration: BoxDecoration(
            border: Border.all(color: rentWheelsNeutral),
            borderRadius: BorderRadius.circular(
              Sizes().height(context, 0.01),
            ),
            color: widget.btnColor ?? rentWheelsNeutralLight0,
          ),
          child: Text(
            widget.label,
            style: widget.style ??
                theme.textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: rentWheelsBrandDark900,
                ),
          ),
        ),
      ),
    );
  }
}
