import 'package:flutter/widgets.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/textfields/generic_textfield_widget.dart';

buildMobileMoneyPayment({
  required String hint,
  required BuildContext context,
  required void Function(String) onChanged,
  required TextEditingController controller,
}) {
  return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      alignment: Alignment.center,
      width: Sizes().width(context, 1),
      child: buildGenericTextfield(
        hint: hint,
        context: context,
        controller: controller,
        onChanged: onChanged,
      ));
}
