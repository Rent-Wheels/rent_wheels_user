import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';

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
      color: status == 'Completed'
          ? rentWheelsSuccessDark800
          : status == 'Cancelled'
              ? rentWheelsErrorDark700
              : status == 'Pending'
                  ? rentWheelsWarningDark700
                  : status == 'Accepted'
                      ? rentWheelsSuccess
                      : status == 'Ongoing'
                          ? rentWheelsSuccessDark600
                          : rentWheelsNeutralLight0,
      borderRadius: BorderRadius.circular(Sizes().height(context, 0.1)),
    ),
    child: Text(
      status,
      style: heading6Neutral0,
    ),
  );
}
