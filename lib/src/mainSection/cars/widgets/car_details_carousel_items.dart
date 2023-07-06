import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

SizedBox buildCarDetailsCarouselItem({
  required String image,
  required BuildContext context,
}) {
  return SizedBox(
    width: double.infinity,
    child: Image(
      image: CachedNetworkImageProvider(image),
      fit: BoxFit.cover,
    ),
  );
}
