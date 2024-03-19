import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';

Widget buildCreditCardPayment({
  required BuildContext context,
  required String cvvCode,
  required String cardNumber,
  required String expiryDate,
  required bool isCvvFocused,
  required String cardHolderName,
  required GlobalKey<FormState> formKey,
  required void Function(CreditCardModel) onCreditCardModelChange,
}) {
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
          cvvCode: cvvCode,
          cardNumber: cardNumber,
          expiryDate: expiryDate,
          isHolderNameVisible: true,
          showBackView: isCvvFocused,
          cardHolderName: cardHolderName,
          cardBgColor: rentWheelsBrandDark900,
          onCreditCardWidgetChange: (_) {},
        ),
        CreditCardForm(
          cvvCode: cvvCode,
          formKey: formKey,
          cardNumber: cardNumber,
          expiryDate: expiryDate,
          cardHolderName: cardHolderName,
          themeColor: rentWheelsBrandDark900,
          textColor: rentWheelsNeutralDark900,
          onCreditCardModelChange: onCreditCardModelChange,
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
