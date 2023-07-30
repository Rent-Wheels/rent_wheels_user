import 'package:flutter/material.dart';

import 'package:rent_wheels/src/mainSection/reservations/data/reservations_data.dart';

import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';

class Reservations extends StatelessWidget {
  const Reservations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      appBar: AppBar(
        backgroundColor: rentWheelsNeutralLight0,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Sizes().width(context, 0.04)),
          child: const Column(
            children: [ReservationsData()],
          ),
        ),
      ),
    );
  }
}
