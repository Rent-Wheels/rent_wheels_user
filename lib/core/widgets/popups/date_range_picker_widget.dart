import 'package:flutter/material.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

buildDateRangePicker({
  required DateTime? endDate,
  required BuildContext context,
  required void Function() onCancel,
  required void Function(Object?) onSubmit,
  required DateRangePickerController controller,
  required void Function(DateRangePickerSelectionChangedArgs)
      onSelectionChanged,
}) =>
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: Sizes().width(context, 0.8),
            height: Sizes().height(context, 0.6),
            padding: EdgeInsets.all(Sizes().height(context, 0.02)),
            color: rentWheelsNeutralLight0,
            child: SfDateRangePicker(
              maxDate: endDate,
              onCancel: onCancel,
              onSubmit: onSubmit,
              controller: controller,
              enablePastDates: false,
              showActionButtons: true,
              onSelectionChanged: onSelectionChanged,
              endRangeSelectionColor: rentWheelsBrandDark800,
              startRangeSelectionColor: rentWheelsBrandDark800,
              selectionMode: DateRangePickerSelectionMode.range,
              rangeSelectionColor: rentWheelsBrandDark800.withOpacity(0.3),
              //
            ),
          ),
        );
      },
    );
