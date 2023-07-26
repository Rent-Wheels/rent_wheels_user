import 'package:flutter/material.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';

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
  bool isDateRangeSelected = false;
  Duration duration = const Duration(days: 2);
  DateTime? currentDate;
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
                "Select date range.",
                style: body1Information,
              ),
              Space().height(context, 0.03),
              SfDateRangePicker(
                controller: date,
                enablePastDates: false,
                toggleDaySelection: true,
                maxDate: currentDate?.add(duration),
                endRangeSelectionColor: rentWheelsBrandDark800,
                startRangeSelectionColor: rentWheelsBrandDark800,
                selectionMode: DateRangePickerSelectionMode.range,
                rangeSelectionColor: rentWheelsBrandDark800.withOpacity(0.3),
                onSelectionChanged: (dateRange) {
                  if (dateRange.value is PickerDateRange) {
                    setState(() {
                      currentDate = dateRange.value.startDate;
                    });
                    if (dateRange.value.startDate != null &&
                        dateRange.value.endDate != null) {
                      setState(() {
                        isDateRangeSelected = true;
                      });
                    } else {
                      setState(() {
                        currentDate = null;
                        isDateRangeSelected = false;
                      });
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: rentWheelsNeutralLight0,
        padding: EdgeInsets.all(Sizes().height(context, 0.02)),
        height: Sizes().height(context, 0.13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildGenericButtonWidget(
              width: Sizes().width(context, 0.85),
              isActive: isDateRangeSelected,
              buttonName: 'Continue',
              context: context,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
