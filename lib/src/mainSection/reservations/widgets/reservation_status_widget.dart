import 'package:flutter/material.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';

buildReservationStatus({
  required String status,
  required BuildContext context,
}) {
  return Container(
    alignment: Alignment.center,
    width: Sizes().width(context, 0.23),
    padding: EdgeInsets.all(Sizes().height(context, 0.008)),
    margin: EdgeInsets.all(Sizes().height(context, 0.015)),
    decoration: BoxDecoration(
      color: rentWheelsNeutralLight0,
      borderRadius: BorderRadius.circular(Sizes().height(context, 0.1)),
    ),
    child: Text(
      status,
      style: body1Neutral900,
    ),
  );
}
