import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';

buildPromoCarousel({
  required int index,
  required List<Widget> items,
  required BuildContext context,
  required CarouselController controller,
  required Function(int, CarouselPageChangedReason) onPageChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CarouselSlider(
        items: items,
        carouselController: controller,
        options: CarouselOptions(autoPlay: true, onPageChanged: onPageChanged),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: items.asMap().entries.map((entry) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: index == entry.key
                ? Sizes().width(context, 0.09)
                : Sizes().width(context, 0.03),
            height: 12.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: ShapeDecoration(
              shape: index == entry.key
                  ? RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          Sizes().width(context, 0.03),
                        ),
                      ),
                    )
                  : const CircleBorder(),
              color: rentWheelsBrandDark900
                  .withOpacity(index == entry.key ? 0.9 : 0.1),
            ),
          );
        }).toList(),
      )
    ],
  );
}
