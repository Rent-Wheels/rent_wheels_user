import 'package:flutter/material.dart';
import 'package:rent_wheels/core/backend/reservations/methods/reservations_methods.dart';
import 'package:rent_wheels/core/models/reservations/reservations_model.dart';
import 'package:rent_wheels/core/widgets/buttons/adaptive_back_button_widget.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/src/mainSection/reservations/widgets/horizontal_scroll_list.dart';

import 'src/mainSection/reservations/data/reservations_data.dart';

class ReservationsPageMock extends StatefulWidget {
  const ReservationsPageMock({super.key});

  @override
  State<ReservationsPageMock> createState() => _ReservationsPageMockState();
}

class _ReservationsPageMockState extends State<ReservationsPageMock> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Sizes().width(context, 0.04)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildAdaptiveBackButton(onPressed: (){}),
                Space().height(context, 0.02),
                const Text("Reservations", style: heading3Information),
                Space().height(context, 0.02),

                // Reservation filters
                // TODO: Add the horizontal scroll list for the reservation filters.
                const HorizontalScroll(),
                Space().height(context, 0.02),

                // Reservation Data
                const ReservationsData(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
