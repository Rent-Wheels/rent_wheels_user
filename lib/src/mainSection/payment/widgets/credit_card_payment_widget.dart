import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';

import 'package:rent_wheels/core/widgets/theme/colors.dart';

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
          onCreditCardWidgetChange: (brand) {},
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
            hintStyle: heading6Neutral500,
            hintText: 'Credit Card Number',
          ),
          expiryDateDecoration: InputDecoration(
            border: border,
            focusedBorder: border,
            enabledBorder: border,
            hintText: 'Expiry Date',
            hintStyle: heading6Neutral500,
          ),
          cvvCodeDecoration: InputDecoration(
            border: border,
            hintText: 'CVV',
            focusedBorder: border,
            enabledBorder: border,
            hintStyle: heading6Neutral500,
          ),
          cardHolderDecoration: InputDecoration(
            border: border,
            focusedBorder: border,
            enabledBorder: border,
            hintText: 'Card Holder',
            hintStyle: heading6Neutral500,
          ),
        ),
      ],
    ),
  );
}
