import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'package:rent_wheels/src/mainSection/payment/widgets/credit_card_payment_widget.dart';
import 'package:rent_wheels/src/mainSection/payment/widgets/mobile_money_payment_widget.dart';

import 'package:rent_wheels/core/models/enums/enums.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/textfields/dropdown_input_field.dart';
import 'package:rent_wheels/core/widgets/buttons/adaptive_back_button_widget.dart';

class PaymentMock extends StatefulWidget {
  const PaymentMock({super.key});

  @override
  State<PaymentMock> createState() => _PaymentMockState();
}

class _PaymentMockState extends State<PaymentMock> {
  PaymentMethods? paymentType;

  String value = '';
  String cvvCode = '';
  String cardNumber = '';
  String expiryDate = '';
  bool isCvvFocused = false;
  String cardHolderName = '';
  bool isMobileNumberValid = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController mobileNumber = TextEditingController();

  bool isActive() {
    return (cvvCode.isNotEmpty &&
            cardNumber.isNotEmpty &&
            expiryDate.isNotEmpty &&
            cardHolderName.isNotEmpty) ||
        isMobileNumberValid;
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

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
      value: value.isNotEmpty ? value : null,
      onChanged: (paymentMethod) {
        if (paymentMethod is String) {
          setState(() {
            cvvCode = '';
            cardNumber = '';
            expiryDate = '';
            cardHolderName = '';
            mobileNumber.text = '';
            isMobileNumberValid = false;
            value = paymentMethod.toString();
          });
          PaymentMethods.airtelTigoCash.value == paymentMethod
              ? setState(() {
                  paymentType = PaymentMethods.airtelTigoCash;
                })
              : PaymentMethods.creditCard.value == paymentMethod
                  ? setState(() {
                      paymentType = PaymentMethods.creditCard;
                    })
                  : PaymentMethods.mobileMoney.value == paymentMethod
                      ? setState(() {
                          paymentType = PaymentMethods.mobileMoney;
                        })
                      : setState(() {
                          paymentType = PaymentMethods.vfCash;
                        });
        }
      },
    );
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: rentWheelsNeutralLight0,
        foregroundColor: rentWheelsBrandDark900,
        leading: buildAdaptiveBackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
            value.isEmpty
                ? Center(child: options)
                : Flexible(flex: 1, child: options),
            if (value.isNotEmpty)
              Flexible(
                flex: paymentType == PaymentMethods.airtelTigoCash ||
                        paymentType == PaymentMethods.mobileMoney ||
                        paymentType == PaymentMethods.vfCash
                    ? 4
                    : 5,
                child: SingleChildScrollView(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    child: paymentType == PaymentMethods.creditCard
                        ? buildCreditCardPayment(
                            context: context,
                            cvvCode: cvvCode,
                            formKey: formKey,
                            cardNumber: cardNumber,
                            expiryDate: expiryDate,
                            isCvvFocused: isCvvFocused,
                            cardHolderName: cardHolderName,
                            onCreditCardModelChange: onCreditCardModelChange,
                          )
                        : paymentType == PaymentMethods.airtelTigoCash ||
                                paymentType == PaymentMethods.mobileMoney ||
                                paymentType == PaymentMethods.vfCash
                            ? buildMobileMoneyPayment(
                                hint: 'Phone Number',
                                context: context,
                                onChanged: (value) {
                                  final mtnRegExp =
                                      RegExp(r'(?=^.{10}$)0[25][3459]\d{7}');
                                  final vodafoneRegExp =
                                      RegExp(r'(?=^.{10}$)0[25]0\d{7}');
                                  final airtelRegExp =
                                      RegExp(r'(?=^.{10}$)0[25][67]\d{7}');

                                  if ((paymentType ==
                                              PaymentMethods.airtelTigoCash &&
                                          airtelRegExp.hasMatch(value)) ||
                                      (paymentType ==
                                              PaymentMethods.mobileMoney &&
                                          mtnRegExp.hasMatch(value)) ||
                                      (paymentType == PaymentMethods.vfCash &&
                                          vodafoneRegExp.hasMatch(value))) {
                                    setState(() {
                                      isMobileNumberValid = true;
                                    });
                                  } else {
                                    setState(() {
                                      isMobileNumberValid = false;
                                    });
                                  }
                                },
                                controller: mobileNumber,
                              )
                            : null,
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: value.isNotEmpty
          ? Container(
              height: Sizes().height(context, 0.15),
              color: rentWheelsNeutralLight0,
              padding: EdgeInsets.all(Sizes().height(context, 0.02)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildGenericButtonWidget(
                    width: Sizes().width(context, 0.85),
                    isActive: isActive(),
                    buttonName: 'Continue',
                    context: context,
                    onPressed: () {},
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
