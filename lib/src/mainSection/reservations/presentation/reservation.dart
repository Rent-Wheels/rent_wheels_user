import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';

class Reservations extends StatelessWidget {
  const Reservations({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      body: Center(
        child: Text(
          'Reservations',
          style: heading1Brand,
        ),
      ),
    );
  }
}
