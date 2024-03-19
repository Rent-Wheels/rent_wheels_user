import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CarDetailsCarouselItem extends StatelessWidget {
  final String image;

  const CarDetailsCarouselItem({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Image(
        image: CachedNetworkImageProvider(image),
        fit: BoxFit.cover,
      ),
    );
  }
}
