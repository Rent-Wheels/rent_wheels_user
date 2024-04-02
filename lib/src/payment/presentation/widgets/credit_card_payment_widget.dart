import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';

class CreditCardPayment extends StatefulWidget {
  final String cvvCode;
  final String cardNumber;
  final String expiryDate;
  final bool isCvvFocused;
  final String cardHolderName;
  final GlobalKey<FormState> formKey;
  final void Function(CreditCardModel) onCreditCardModelChange;

  const CreditCardPayment({
    super.key,
    required this.cvvCode,
    required this.cardNumber,
    required this.expiryDate,
    required this.isCvvFocused,
    required this.cardHolderName,
    required this.formKey,
    required this.onCreditCardModelChange,
  });

  @override
  State<CreditCardPayment> createState() => _CreditCardPaymentState();
}

class _CreditCardPaymentState extends State<CreditCardPayment> {
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(
        color: rentWheelsNeutral,
        width: Sizes().width(context, 0.002),
      ),
    );
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Column(
        children: [
          CreditCardWidget(
            cvvCode: widget.cvvCode,
            cardNumber: widget.cardNumber,
            expiryDate: widget.expiryDate,
            isHolderNameVisible: true,
            showBackView: widget.isCvvFocused,
            cardHolderName: widget.cardHolderName,
            cardBgColor: rentWheelsBrandDark900,
            onCreditCardWidgetChange: (_) {},
          ),
          CreditCardForm(
            cvvCode: widget.cvvCode,
            formKey: widget.formKey,
            cardNumber: widget.cardNumber,
            expiryDate: widget.expiryDate,
            cardHolderName: widget.cardHolderName,
            themeColor: rentWheelsBrandDark900,
            textColor: rentWheelsNeutralDark900,
            onCreditCardModelChange: widget.onCreditCardModelChange,
            cardNumberDecoration: InputDecoration(
              border: border,
              focusedBorder: border,
              enabledBorder: border,
              hintStyle: theme.textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: rentWheelsNeutralDark900,
              ),
              hintText: 'Credit Card Number',
            ),
            expiryDateDecoration: InputDecoration(
              border: border,
              focusedBorder: border,
              enabledBorder: border,
              hintText: 'Expiry Date',
              hintStyle: theme.textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: rentWheelsNeutralDark900,
              ),
            ),
            cvvCodeDecoration: InputDecoration(
              border: border,
              hintText: 'CVV',
              focusedBorder: border,
              enabledBorder: border,
              hintStyle: theme.textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: rentWheelsNeutralDark900,
              ),
            ),
            cardHolderDecoration: InputDecoration(
              border: border,
              focusedBorder: border,
              enabledBorder: border,
              hintText: 'Card Holder',
              hintStyle: theme.textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: rentWheelsNeutralDark900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
