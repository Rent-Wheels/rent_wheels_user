import 'package:flutter/widgets.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/textfields/generic_textfield_widget.dart';

class MobileMoneyPayment extends StatefulWidget {
  final String hint;
  final void Function(String) onChanged;
  final TextEditingController controller;

  const MobileMoneyPayment({
    super.key,
    required this.hint,
    required this.onChanged,
    required this.controller,
  });

  @override
  State<MobileMoneyPayment> createState() => _MobileMoneyPaymentState();
}

class _MobileMoneyPaymentState extends State<MobileMoneyPayment> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      alignment: Alignment.center,
      width: Sizes().width(context, 1),
      child: GenericTextField(
        hint: widget.hint,
        controller: widget.controller,
        onChanged: widget.onChanged,
      ),
    );
  }
}
