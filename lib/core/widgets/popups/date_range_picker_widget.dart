import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/buttons/text_button_widget.dart';

buildDateRangePicker({
  PickerDateRange? selectedRange,
  required Duration duration,
  required BuildContext context,
  required void Function() onCancel,
  required void Function(Object?)? onSubmit,
}) {
  DateTime? endDate;
  bool isDateRangeSelected = false;
  DateRangePickerController date = DateRangePickerController();

  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            child: Container(
              width: Sizes().width(context, 0.8),
              height: Sizes().height(context, 0.55),
              padding: EdgeInsets.symmetric(
                horizontal: Sizes().width(context, 0.04),
              ),
              color: rentWheelsNeutralLight0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SfDateRangePicker(
                    maxDate: endDate,
                    initialSelectedRange: selectedRange,
                    onCancel: onCancel,
                    onSubmit: onSubmit,
                    controller: date,
                    enablePastDates: false,
                    onSelectionChanged: (dateRange) {
                      if (dateRange.value is PickerDateRange) {
                        setState(() {
                          endDate = dateRange.value.startDate.add(duration);
                        });
                        if (dateRange.value.startDate != null &&
                            dateRange.value.endDate != null &&
                            !dateRange.value.endDate.isAfter(endDate)) {
                          setState(() {
                            isDateRangeSelected = true;
                          });
                        } else {
                          setState(() {
                            isDateRangeSelected = false;
                          });
                        }
                      }
                    },
                    endRangeSelectionColor: rentWheelsBrandDark800,
                    startRangeSelectionColor: rentWheelsBrandDark800,
                    selectionMode: DateRangePickerSelectionMode.range,
                    rangeSelectionColor:
                        rentWheelsBrandDark800.withOpacity(0.3),
                    //
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      buildTextButtonWidget(
                        context: context,
                        isActive: true,
                        onPressed: onCancel,
                        buttonName: 'Cancel',
                        width: Sizes().width(context, 0.2),
                      ),
                      buildTextButtonWidget(
                        context: context,
                        buttonName: 'Okay',
                        isActive: isDateRangeSelected,
                        onPressed: isDateRangeSelected
                            ? () => onSubmit!(date.selectedRange)
                            : null,
                        width: Sizes().width(context, 0.15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
