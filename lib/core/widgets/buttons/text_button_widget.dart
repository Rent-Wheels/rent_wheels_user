import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';

class TextButtonWidget extends StatefulWidget {
  final double width;
  final bool isActive;
  final Color? btnColor;
  final String buttonName;
  final void Function()? onPressed;

  const TextButtonWidget({
    super.key,
    this.btnColor,
    required this.width,
    required this.isActive,
    required this.onPressed,
    required this.buttonName,
  });

  @override
  State<TextButtonWidget> createState() => _TextButtonWidgetState();
}

class _TextButtonWidgetState extends State<TextButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      enableFeedback: true,
      child: SizedBox(
        width: widget.width,
        height: Sizes().height(context, 0.06),
        child: Container(
          alignment: Alignment.center,
          padding:
              EdgeInsets.symmetric(horizontal: Sizes().width(context, 0.02)),
          child: Text(
            widget.buttonName,
            style: theme.textTheme.headlineMedium!.copyWith(
              color: rentWheelsBrandDark900.withOpacity(
                widget.isActive ? 1 : 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
