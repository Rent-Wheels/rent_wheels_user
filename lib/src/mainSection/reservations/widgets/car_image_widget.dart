import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/src/mainSection/reservations/widgets/reservation_status_widget.dart';

buildCarImage({
  required String imageUrl,
  required String reservationStatus,
  required BuildContext context,
}) {
  return Stack(
    alignment: Alignment.topLeft,
    children: [
      Container(
        height: Sizes().height(context, 0.2),
        width: Sizes().width(context, 0.85),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes().height(context, 0.02)),
          color: rentWheelsNeutralLight0,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(imageUrl),
          ),
        ),
      ),
      buildReservationStatus(status: reservationStatus, context: context),
    ],
  );
}
