import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';

buildCarImageCarousel({
  required int index,
  required List<Widget> items,
  required BuildContext context,
  required CarouselController controller,
  required Function(int, CarouselPageChangedReason) onPageChanged,
}) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      CarouselSlider(
        items: items,
        carouselController: controller,
        options: CarouselOptions(
          height: Sizes().height(context, 0.32),
          enableInfiniteScroll: items.length == 1 ? false : true,
          viewportFraction: 1,
          onPageChanged: onPageChanged,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: items.asMap().entries.map((entry) {
          return AnimatedContainer(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 200),
            width: index == entry.key
                ? Sizes().width(context, 0.1)
                : Sizes().width(context, 0.03),
            height: 12.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: ShapeDecoration(
              shape: index == entry.key
                  ? RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        Sizes().width(context, 0.03),
                      ),
                    )
                  : const CircleBorder(),
              color: index == entry.key
                  ? rentWheelsBrandDark900
                  : rentWheelsNeutralLight0,
            ),
          );
        }).toList(),
      )
    ],
  );
}
