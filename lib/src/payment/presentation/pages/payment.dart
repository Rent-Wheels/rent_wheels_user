import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_wheels/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/core/widgets/popups/success_popup.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/src/reservations/domain/entity/reservations.dart';
import 'package:rent_wheels/src/reservations/data/model/reservation_model.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels/core/widgets/buttons/adaptive_back_button_widget.dart';

import 'package:rent_wheels/src/cars/domain/entity/cars.dart';
import 'package:rent_wheels/src/cars/data/models/cars_model.dart';
import 'package:rent_wheels/src/payment/presentation/pages/payment_page_one.dart';
import 'package:rent_wheels/src/payment/presentation/pages/payment_page_two.dart';
import 'package:rent_wheels/src/global/presentation/provider/global_provider.dart';
import 'package:rent_wheels/src/reservations/presentation/bloc/reservations_bloc.dart';

class Payment extends StatefulWidget {
  final String car;
  final String reservation;
  const Payment({
    super.key,
    required this.car,
    required this.reservation,
  });

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Car? _car;
  Reservation? _reservation;
  PaymentMethods? _paymentType;

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

  final _reservationBloc = sl<ReservationsBloc>();

  bool isActive() {
    return (cvvCode.isNotEmpty &&
            cardNumber.isNotEmpty &&
            expiryDate.isNotEmpty &&
            cardHolderName.isNotEmpty) ||
        isMobileNumberValid;
  }

  initData() {
    _car = CarModel.fromJSON(jsonDecode(widget.car));
    _reservation = ReservationModel.fromJSON(jsonDecode(widget.reservation));
  }

  makePayment(Reservation reservation) {
    buildLoadingIndicator(context, 'Processing');

    final params = {
      'headers': context.read<GlobalProvider>().headers,
      'urlParameters': {
        'reservationId': reservation.id,
      },
      'body': {
        'status': 'Paid',
      }
    };
    _reservationBloc.add(ChangeReservationStatusEvent(params: params));
  }

  onCreditCardModelChange(CreditCardModel? creditCardModel) {
    cvvCode = creditCardModel!.cvvCode;
    expiryDate = creditCardModel.expiryDate;
    cardNumber = creditCardModel.cardNumber;
    isCvvFocused = creditCardModel.isCvvFocused;
    cardHolderName = creditCardModel.cardHolderName;
    setState(() {});
  }

  dropdownOnChanged(paymentMethod) {
    if (paymentMethod is String) {
      cvvCode = '';
      cardNumber = '';
      expiryDate = '';
      cardHolderName = '';
      value = paymentMethod;
      mobileNumber.text = '';
      isMobileNumberValid = false;
      _paymentType = PaymentMethods.values.firstWhere(
        (element) => element.value == paymentMethod,
        orElse: () => PaymentMethods.vfCash,
      );

      setState(() {});
    }
  }

  textOnChanged(value) {
    final mtnRegExp = RegExp(r'(?=^.{10}$)0[25][3459]\d{7}');
    final vodafoneRegExp = RegExp(r'(?=^.{10}$)0[25]0\d{7}');
    final airtelRegExp = RegExp(r'(?=^.{10}$)0[25][67]\d{7}');

    isMobileNumberValid = (_paymentType == PaymentMethods.airtelTigoCash &&
            airtelRegExp.hasMatch(value)) ||
        (_paymentType == PaymentMethods.mobileMoney &&
            mtnRegExp.hasMatch(value)) ||
        (_paymentType == PaymentMethods.vfCash &&
            vodafoneRegExp.hasMatch(value));
    setState(() {});
  }

  @override
  void initState() {
    initData();
    super.initState();
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
        paymentType: _paymentType,
        isCvvFocused: isCvvFocused,
        textOnChanged: textOnChanged,
        cardHolderName: cardHolderName,
        dropdownOnChanged: dropdownOnChanged,
        onCreditCardModelChange: onCreditCardModelChange,
      ),
      PaymentPageTwo(
        car: _car!,
        value: value,
        cvvCode: cvvCode,
        cardNumber: cardNumber,
        expiryDate: expiryDate,
        isCvvFocused: isCvvFocused,
        cardHolderName: cardHolderName,
        phoneNumber: mobileNumber.text,
        reservation: _reservation!,
        paymentType: _paymentType ?? PaymentMethods.airtelTigoCash,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: AdaptiveBackButton(
          onPressed: () {
            if (currentIndex == 0) {
              context.pop();
            } else {
              payments.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
              );
            }
          },
        ),
      ),
      body: BlocListener(
        bloc: _reservationBloc,
        listener: (context, state) {
          if (state is GenericReservationsError) {
            context.pop();
            showErrorPopUp(state.errorMessage, context);
          }

          if (state is ChangeReservationStatusLoaded) {
            context.pop();
            context.pop(state.reservation);

            showSuccessPopUp('Payment Successful', context);
          }
        },
        child: PageView.builder(
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
      ),
      bottomNavigationBar: value.isNotEmpty
          ? Container(
              height: Sizes().height(context, 0.15),
              color: rentWheelsNeutralLight0,
              padding: EdgeInsets.all(Sizes().height(context, 0.02)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GenericButton(
                    isActive: isActive(),
                    width: Sizes().width(context, 0.85),
                    buttonName: currentIndex != pages.length - 1
                        ? 'Continue'
                        : 'Make Payment',
                    onPressed: () {
                      if (currentIndex != pages.length - 1) {
                        payments.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear,
                        );
                      } else {
                        makePayment(_reservation!);
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
