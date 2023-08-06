import 'package:flutter/material.dart';

import 'package:rent_wheels/src/mainSection/reservations/data/reservations_data.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/shimmer_loading_placeholder.dart';

class Reservations extends StatefulWidget {
  const Reservations({super.key});

  @override
  State<Reservations> createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      body: SafeArea(
        child: Shimmer(
          linearGradient: global.shimmerGradient,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Sizes().width(context, 0.04)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Space().height(context, 0.04),
                const Text("Reservations", style: heading3Information),
                Space().height(context, 0.02),
                const Expanded(child: ReservationsData()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
