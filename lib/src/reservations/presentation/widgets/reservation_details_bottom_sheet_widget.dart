import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';

class ReservationDetailsBottomSheet extends StatelessWidget {
  final List<Widget> items;

  const ReservationDetailsBottomSheet({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: rentWheelsNeutralLight0,
      padding: EdgeInsets.all(Sizes().height(context, 0.02)),
      height: Sizes().height(context, 0.13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items,
      ),
    );
  }
}
