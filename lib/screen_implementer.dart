import 'package:flutter/material.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/src/mainSection/reservations/widgets/filter_buttons_widget.dart';

import 'src/mainSection/reservations/data/reservations_data.dart';

class ReservationsPageMock extends StatefulWidget {
  const ReservationsPageMock({super.key});

  @override
  State<ReservationsPageMock> createState() => _ReservationsPageMockState();
}

class _ReservationsPageMockState extends State<ReservationsPageMock> {
  final List<String> sections = [
    'All',
    'Ongoing',
    'Completed',
    'Cancelled',
  ];

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Reservations", style: heading3Information),
              Space().height(context, 0.02),
              SizedBox(
                height: Sizes().height(context, 0.03),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sections.length,
                  itemBuilder: (context, index) {
                    return buildFilterButtons(
                      label: sections[index],
                      context: context,
                      onTap: () {},
                    );
                  },
                ),
              ),
              Space().height(context, 0.02),
              const ReservationsData(),
            ],
          ),
        ),
      ),
    );
  }
}
