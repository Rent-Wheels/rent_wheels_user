import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/buttons/adaptive_back_button_widget.dart';

class MakeReservationMock extends StatefulWidget {
  const MakeReservationMock({super.key});

  @override
  State<MakeReservationMock> createState() => _MakeReservationMockState();
}

class _MakeReservationMockState extends State<MakeReservationMock> {
  DateTime currentDate = DateTime.now();
  // DateTime endDate = new DateTime(currentDate.year, currentDate.month)
  DateRangePickerController date = DateRangePickerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: rentWheelsBrandDark900,
        backgroundColor: rentWheelsNeutralLight0,
        leading: buildAdaptiveBackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes().height(context, 0.02)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Make Reservation",
                style: heading3Information,
              ),
              Space().height(context, 0.03),
              const Text(
                "Please your start and end date.",
                style: body1Information,
              ),
              Space().height(context, 0.03),

              SfDateRangePicker(
                selectionMode: DateRangePickerSelectionMode.range,
                enablePastDates: false,
                controller: date,
                onSelectionChanged: (dateRangePickerSelectionChangedArgs) {},
              )
              // DateRangePickerDialog(
              //     firstDate: currentDate,
              //     lastDate: DateTime(
              //       currentDate.year,
              //       currentDate.month + 6,
              //       currentDate.day,
              //     ))
            ],
          ),
        ),
      ),
    );
  }
}
