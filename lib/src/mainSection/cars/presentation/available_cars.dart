import 'package:flutter/material.dart';

import 'package:rent_wheels/src/mainSection/cars/data/available_cars_data.dart';

import 'package:rent_wheels/core/enums/enums.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/widgets/loadingIndicator/shimmer_loading_placeholder.dart';

class AvailableCars extends StatefulWidget {
  const AvailableCars({super.key});

  @override
  State<AvailableCars> createState() => _AvailableCarsState();
}

class _AvailableCarsState extends State<AvailableCars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      body: Shimmer(
        linearGradient: global.shimmerGradient,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Sizes().width(context, 0.04)),
          child: const AvailableCarsData(
            type: AvailableCarsType.allAvailableCars,
          ),
        ),
      ),
    );
  }
}
