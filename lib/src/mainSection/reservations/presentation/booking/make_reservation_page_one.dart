import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/search/custom_search_bar.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/textfields/tappable_textfield.dart';
import 'package:rent_wheels/core/widgets/popups/date_range_picker_widget.dart';
import 'package:rent_wheels/core/widgets/buttons/adaptive_back_button_widget.dart';

class MakeReservationPageOne extends StatefulWidget {
  final Car car;
  const MakeReservationPageOne({super.key, required this.car});

  @override
  State<MakeReservationPageOne> createState() => _MakeReservationPageOneState();
}

class _MakeReservationPageOneState extends State<MakeReservationPageOne> {
  bool isDateValid = false;
  bool isLocationValid = false;

  Duration duration = const Duration(days: 2);
  TextEditingController location = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  TextEditingController date = TextEditingController();

  bool isActive() {
    return isDateValid && isLocationValid;
  }

  Duration getDuration() {
    Car car = widget.car;
    num days = 0;

    switch (car.durationUnit) {
      case 'weeks':
        days = car.maxDuration! * 7;
        break;
      case 'days':
        days = car.maxDuration!;
      case 'months':
        int year = DateTime.now().year;
        int month = DateTime.now().month;
        DateTime thisMonth = DateTime(year, month.toInt(), 0);
        DateTime finalMonth =
            DateTime(year, month + car.maxDuration!.toInt(), 0);

        days = finalMonth.difference(thisMonth).inDays;

      default:
        days = 0;
    }

    return Duration(days: days.toInt() - 1);
  }

  showDateRangeSelector() {
    timeDilation = 1;
    return buildDateRangePicker(
      context: context,
      duration: getDuration(),
      onCancel: () => Navigator.pop(context),
      onSubmit: (dateRange) {
        if (dateRange is PickerDateRange) {
          Navigator.pop(context);
          setState(() {
            date.text = dateRange.startDate.toString();
            startDate = dateRange.startDate;
            endDate = dateRange.endDate;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Car car = widget.car;

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
              Space().height(context, 0.01),
              RichText(
                text: TextSpan(
                  text:
                      "You can rent this ${car.make} ${car.model} for a maximum of ",
                  style: body2Brand,
                  children: [
                    TextSpan(
                      text: ' ${car.maxDuration} ${car.durationUnit}',
                      style: heading6BrandBold,
                    ),
                  ],
                ),
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
