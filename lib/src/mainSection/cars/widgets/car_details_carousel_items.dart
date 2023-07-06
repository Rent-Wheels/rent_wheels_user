import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

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
