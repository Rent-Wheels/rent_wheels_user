import 'package:flutter/material.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';

class CarouselDots extends StatefulWidget {
  final int index;
  final double? width;
  final int currentIndex;
  final Color? inactiveColor;

  const CarouselDots({
    super.key,
    this.width,
    this.inactiveColor,
    required this.index,
    required this.currentIndex,
  });

  @override
  State<CarouselDots> createState() => _CarouselDotsState();
}

class _CarouselDotsState extends State<CarouselDots> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 200),
      width: widget.currentIndex == widget.index
          ? widget.width ?? Sizes().width(context, 0.1)
          : Sizes().width(context, 0.03),
      height: Sizes().height(context, 0.012),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      decoration: ShapeDecoration(
        shape: widget.currentIndex == widget.index
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Sizes().width(context, 0.03),
                ),
              )
            : const CircleBorder(),
        color: widget.currentIndex == widget.index
            ? rentWheelsBrandDark900
            : widget.inactiveColor ?? rentWheelsNeutralLight0,
      ),
    );
  }
}
