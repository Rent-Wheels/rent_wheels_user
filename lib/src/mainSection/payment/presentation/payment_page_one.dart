import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:rent_wheels/core/enums/enums.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/textfields/dropdown_input_field.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/src/mainSection/payment/widgets/credit_card_payment_widget.dart';
import 'package:rent_wheels/src/mainSection/payment/widgets/mobile_money_payment_widget.dart';

class PaymentPageOne extends StatefulWidget {
  final String value;
  final String cvvCode;
  final String cardNumber;
  final String expiryDate;
  final bool isCvvFocused;
  final String cardHolderName;
  final PaymentMethods? paymentType;
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final void Function(String) textOnChanged;
  final void Function(Object?)? dropdownOnChanged;
  final void Function(CreditCardModel) onCreditCardModelChange;

  const PaymentPageOne({
    super.key,
    this.paymentType,
    required this.value,
    required this.cvvCode,
    required this.formKey,
    required this.cardNumber,
    required this.expiryDate,
    required this.controller,
    required this.isCvvFocused,
    required this.textOnChanged,
    required this.cardHolderName,
    required this.dropdownOnChanged,
    required this.onCreditCardModelChange,
  });

  @override
  State<PaymentPageOne> createState() => _PaymentPageOneState();
}

class _PaymentPageOneState extends State<PaymentPageOne> {
  List<DropdownMenuItem<Object>> dropdownItems = [
    DropdownMenuItem(
      value: PaymentMethods.creditCard.value,
      child: const Text('Credit Card'),
    ),
    DropdownMenuItem(
      value: PaymentMethods.mobileMoney.value,
      child: const Text('MTN Mobile Money'),
    ),
    DropdownMenuItem(
      value: PaymentMethods.airtelTigoCash.value,
      child: const Text('Tigo Cash'),
    ),
    DropdownMenuItem(
      value: PaymentMethods.vfCash.value,
      child: const Text('VFCash'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    Widget options = buildDropDownInputField(
        context: context,
        items: dropdownItems,
        hintText: 'Select Payment Option',
        value: widget.value.isNotEmpty ? widget.value : null,
        onChanged: widget.dropdownOnChanged);
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      body: Padding(
        padding: EdgeInsets.only(
          left: Sizes().width(context, 0.04),
          right: Sizes().width(context, 0.04),
          top: Sizes().height(context, 0.01),
          bottom: Sizes().width(context, 0.05),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.value.isEmpty
                ? Center(child: options)
                : Flexible(flex: 1, child: options),
            if (widget.value.isNotEmpty)
              Flexible(
                flex: widget.paymentType == PaymentMethods.airtelTigoCash ||
                        widget.paymentType == PaymentMethods.mobileMoney ||
                        widget.paymentType == PaymentMethods.vfCash
                    ? 4
                    : 3,
                child: SingleChildScrollView(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    child: widget.paymentType == PaymentMethods.creditCard
                        ? CreditCardPayment(
                            cvvCode: widget.cvvCode,
                            formKey: widget.formKey,
                            expiryDate: widget.expiryDate,
                            cardNumber: widget.cardNumber,
                            isCvvFocused: widget.isCvvFocused,
                            cardHolderName: widget.cardHolderName,
                            onCreditCardModelChange:
                                widget.onCreditCardModelChange,
                          )
                        : widget.paymentType == PaymentMethods.airtelTigoCash ||
                                widget.paymentType ==
                                    PaymentMethods.mobileMoney ||
                                widget.paymentType == PaymentMethods.vfCash
                            ? MobileMoneyPayment(
                                hint: 'Phone Number',
                                controller: widget.controller,
                                onChanged: widget.textOnChanged,
                              )
                            : null,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
