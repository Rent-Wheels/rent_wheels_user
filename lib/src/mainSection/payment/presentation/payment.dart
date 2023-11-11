import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:rent_wheels/core/widgets/popups/success_popup.dart';

import 'package:rent_wheels/src/mainSection/payment/presentation/payment_page_one.dart';
import 'package:rent_wheels/src/mainSection/payment/presentation/payment_page_two.dart';

import 'package:rent_wheels/core/enums/enums.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/models/reservations/reservations_model.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels/core/widgets/buttons/adaptive_back_button_widget.dart';
import 'package:rent_wheels/core/backend/reservations/methods/reservations_methods.dart';

class Payment extends StatefulWidget {
  final Car car;
  final ReservationModel reservation;
  const Payment({
    super.key,
    required this.car,
    required this.reservation,
  });

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  PaymentMethods? paymentType;
  String value = '';
  String cvvCode = '';
  int currentIndex = 0;
  String cardNumber = '';
  String expiryDate = '';
  bool isCvvFocused = false;
  String cardHolderName = '';
  bool isMobileNumberValid = false;
  PageController payments = PageController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController mobileNumber = TextEditingController();

  bool isActive() {
    return (cvvCode.isNotEmpty &&
            cardNumber.isNotEmpty &&
            expiryDate.isNotEmpty &&
            cardHolderName.isNotEmpty) ||
        isMobileNumberValid;
  }

  makePayment({required String reservationId}) async {
    try {
      buildLoadingIndicator(context, 'Processing');
      await RentWheelsReservationsMethods().changeReservationStatus(
          reservationId: reservationId, status: 'Paid');
      if (!mounted) return;
      Navigator.pop(context);
      Navigator.pop(context, 'Paid');
      showSuccessPopUp('Payment Successful', context);
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      showErrorPopUp(e.toString(), context);
    }
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

  void dropdownOnChanged(paymentMethod) {
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
  }

  void textOnChanged(value) {
    final mtnRegExp = RegExp(r'(?=^.{10}$)0[25][3459]\d{7}');
    final vodafoneRegExp = RegExp(r'(?=^.{10}$)0[25]0\d{7}');
    final airtelRegExp = RegExp(r'(?=^.{10}$)0[25][67]\d{7}');

    if ((paymentType == PaymentMethods.airtelTigoCash &&
            airtelRegExp.hasMatch(value)) ||
        (paymentType == PaymentMethods.mobileMoney &&
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
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      PaymentPageOne(
        value: value,
        cvvCode: cvvCode,
        formKey: formKey,
        cardNumber: cardNumber,
        expiryDate: expiryDate,
        controller: mobileNumber,
        paymentType: paymentType,
        isCvvFocused: isCvvFocused,
        textOnChanged: textOnChanged,
        cardHolderName: cardHolderName,
        dropdownOnChanged: dropdownOnChanged,
        onCreditCardModelChange: onCreditCardModelChange,
      ),
      PaymentPageTwo(
        value: value,
        car: widget.car,
        cvvCode: cvvCode,
        cardNumber: cardNumber,
        expiryDate: expiryDate,
        isCvvFocused: isCvvFocused,
        cardHolderName: cardHolderName,
        phoneNumber: mobileNumber.text,
        reservation: widget.reservation,
        paymentType: paymentType ?? PaymentMethods.airtelTigoCash,
      ),
    ];
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: rentWheelsNeutralLight0,
        foregroundColor: rentWheelsBrandDark900,
        leading: buildAdaptiveBackButton(
          onPressed: () {
            if (currentIndex == 0) {
              Navigator.pop(context);
            } else {
              payments.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
              );
            }
          },
        ),
      ),
      body: PageView.builder(
        controller: payments,
        itemCount: pages.length,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) => setState(() {
          currentIndex = value;
        }),
        itemBuilder: (context, index) {
          return pages[index];
        },
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
                    context: context,
                    isActive: isActive(),
                    width: Sizes().width(context, 0.85),
                    buttonName: currentIndex != pages.length - 1
                        ? 'Continue'
                        : 'Make Payment',
                    onPressed: () async {
                      if (currentIndex != pages.length - 1) {
                        payments.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear,
                        );
                      } else {
                        await makePayment(
                            reservationId: widget.reservation.id!);
                      }
                    },
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
