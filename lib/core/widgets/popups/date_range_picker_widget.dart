import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/buttons/text_button_widget.dart';

buildDateRangePicker({
  required DateTime? endDate,
  required Duration duration,
  required BuildContext context,
  PickerDateRange? selectedRange,
  required bool isDateRangeSelected,
  required void Function() onCancel,
  required DateRangePickerController date,
  required void Function(Object?)? onSubmit,
  required void Function(DateRangePickerSelectionChangedArgs)?
      onSelectionChanged,
}) {
  return showDialog(
    context: context,
    builder: (context) => Container(
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
            onSelectionChanged: onSelectionChanged,
            endRangeSelectionColor: rentWheelsBrandDark800,
            startRangeSelectionColor: rentWheelsBrandDark800,
            selectionMode: DateRangePickerSelectionMode.range,
            rangeSelectionColor: rentWheelsBrandDark800.withOpacity(
              0.3,
            ),
            //
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButtonWidget(
                isActive: true,
                onPressed: onCancel,
                buttonName: 'Cancel',
                width: Sizes().width(context, 0.2),
              ),
              TextButtonWidget(
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
}
