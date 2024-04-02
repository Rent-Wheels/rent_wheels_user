import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/buttons/text_button_widget.dart';

buildDateRangePicker({
  required Duration duration,
  required BuildContext context,
  PickerDateRange? selectedRange,
  required bool isDateRangeSelected,
  required void Function() onCancel,
  required DateRangePickerController date,
  required void Function(Object?)? onSubmit,
}) {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      child: DateRangePicker(
        date: date,
        onCancel: onCancel,
        onSubmit: onSubmit,
        duration: duration,
      ),
    ),
  );
}

class DateRangePicker extends StatefulWidget {
  final Duration duration;
  final void Function() onCancel;
  final PickerDateRange? selectedRange;
  final DateRangePickerController date;
  final void Function(Object?)? onSubmit;

  const DateRangePicker({
    super.key,
    this.selectedRange,
    required this.date,
    required this.duration,
    required this.onCancel,
    required this.onSubmit,
  });

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DateTime? endDate;
  bool isDateRangeSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes().width(context, 0.8),
      height: Sizes().height(context, 0.50),
      color: rentWheelsNeutralLight0,
      padding: EdgeInsets.symmetric(
        horizontal: Sizes().width(context, 0.04),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SfDateRangePicker(
            maxDate: endDate,
            enablePastDates: false,
            controller: widget.date,
            onSubmit: widget.onSubmit,
            onCancel: widget.onCancel,
            initialSelectedRange: widget.selectedRange,
            endRangeSelectionColor: rentWheelsBrandDark800,
            startRangeSelectionColor: rentWheelsBrandDark800,
            selectionMode: DateRangePickerSelectionMode.range,
            rangeSelectionColor: rentWheelsBrandDark800.withOpacity(0.3),
            onSelectionChanged: (dateRange) {
              if (dateRange.value is PickerDateRange) {
                endDate = dateRange.value.startDate.add(widget.duration);
                if (dateRange.value.startDate != null &&
                    dateRange.value.endDate != null &&
                    !dateRange.value.endDate.isAfter(endDate)) {
                  isDateRangeSelected = true;
                } else {
                  isDateRangeSelected = false;
                }
                setState(() {});
              }
            },
            //
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButtonWidget(
                isActive: true,
                onPressed: widget.onCancel,
                buttonName: 'Cancel',
                width: Sizes().width(context, 0.2),
              ),
              TextButtonWidget(
                buttonName: 'Confirm',
                isActive: isDateRangeSelected,
                onPressed: isDateRangeSelected
                    ? () => widget.onSubmit!(widget.date.selectedRange)
                    : null,
                width: Sizes().width(context, 0.15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
