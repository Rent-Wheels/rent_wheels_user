import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/carousel/carousel_dots_widget.dart';

class ImageCarouselSlider extends StatefulWidget {
  final int index;
  final bool autoPlay;
  final double? height;
  final List<Widget> items;
  final CarouselController controller;
  final Function(int, CarouselPageChangedReason) onPageChanged;
  const ImageCarouselSlider({
    super.key,
    this.height,
    required this.index,
    required this.items,
    required this.autoPlay,
    required this.controller,
    required this.onPageChanged,
  });

  @override
  State<ImageCarouselSlider> createState() => _ImageCarouselSliderState();
}

class _ImageCarouselSliderState extends State<ImageCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          items: widget.items,
          carouselController: widget.controller,
          options: CarouselOptions(
            height: widget.height ?? Sizes().height(context, 0.32),
            autoPlay: widget.autoPlay,
            enableInfiniteScroll: widget.items.length > 1,
            viewportFraction: 1,
            onPageChanged: widget.onPageChanged,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.items.asMap().entries.map((entry) {
            return CarouselDots(
              index: entry.key,
              currentIndex: widget.index,
            );
          }).toList(),
        )
      ],
    );
  }
}
