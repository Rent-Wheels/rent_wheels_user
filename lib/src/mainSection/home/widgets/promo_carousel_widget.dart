import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/carousel/carousel_dots_widget.dart';

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
        options: CarouselOptions(
          height: Sizes().height(context, 0.35),
          autoPlay: items.length == 1 ? false : true,
          enableInfiniteScroll: items.length == 1 ? false : true,
          viewportFraction: 1,
          onPageChanged: onPageChanged,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: items.asMap().entries.map((entry) {
          return buildCarouselDots(
            index: entry.key,
            currentIndex: index,
            context: context,
          );
        }).toList(),
      )
    ],
  );
}
