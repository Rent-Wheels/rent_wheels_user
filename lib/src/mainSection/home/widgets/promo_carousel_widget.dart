import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
          return Container(
            width: 12.0,
            height: 12.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: rentWheelsBrandDark900
                    .withOpacity(index == entry.key ? 0.9 : 0.4)),
          );
        }).toList(),
      )
    ],
  );
}
