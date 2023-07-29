import 'package:flutter/material.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/popups/date_range_picker_widget.dart';
import 'package:rent_wheels/core/widgets/search/custom_search_bar.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/textfields/tappable_textfield.dart';
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
  bool isDateValid = false;
  bool isLocationValid = false;

  Duration duration = const Duration(days: 2);
  TextEditingController location = TextEditingController();

  DateTime? maxDate;

  TextEditingController date = TextEditingController();

  showDateRangeSelector() {
    return buildDateRangePicker(
      endDate: maxDate,
      context: context,
      duration: duration,
      onCancel: () => Navigator.pop(context),
      onSubmit: (dateRange) {
        if (dateRange is PickerDateRange) {
          Navigator.pop(context);
          setState(() {
            date.text = dateRange.startDate.toString();
          });
        }
      },
    );
  }

  bool isActive() {
    return isDateValid && isLocationValid;
  }

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
              buildTappableTextField(
                  hint: 'Destination',
                  context: context,
                  controller: location,
                  onTap: () async {
                    final response = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomSearchScaffold(),
                      ),
                    );

                    if (response != null) {
                      setState(() {
                        location.text = response;
                      });
                    }
                  }),
              Space().height(context, 0.03),
              buildTappableTextField(
                hint: 'Date',
                context: context,
                controller: date,
                onTap: showDateRangeSelector,
              ),
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
              isActive: isActive(),
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
