import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rent_wheels/injection.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/extenstions/date_compare.dart';
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/core/widgets/popups/success_popup.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/dialogs/confirmation_dialog_widget.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels/core/widgets/buttons/adaptive_back_button_widget.dart';

import 'package:rent_wheels/src/cars/domain/entity/cars.dart';
import 'package:rent_wheels/src/cars/data/models/cars_model.dart';
import 'package:rent_wheels/src/renter/domain/entity/renter.dart';
import 'package:rent_wheels/src/renter/data/models/renter_model.dart';
import 'package:rent_wheels/src/reservations/domain/entity/reservations.dart';
import 'package:rent_wheels/src/reservations/data/model/reservation_model.dart';
import 'package:rent_wheels/src/global/presentation/provider/global_provider.dart';
import 'package:rent_wheels/src/reservations/presentation/bloc/reservations_bloc.dart';
import 'package:rent_wheels/src/reservations/presentation/widgets/reservation_details_widget.dart';
import 'package:rent_wheels/src/reservations/presentation/widgets/reservation_details_bottom_sheet_widget.dart';

class MakeReservationPageTwo extends StatefulWidget {
  final String? car;
  final String? renter;
  final String reservation;
  final ReservationView view;

  const MakeReservationPageTwo({
    super.key,
    required this.car,
    required this.view,
    required this.renter,
    required this.reservation,
  });

  @override
  State<MakeReservationPageTwo> createState() => _MakeReservationPageTwoState();
}

class _MakeReservationPageTwoState extends State<MakeReservationPageTwo> {
  Car? _car;
  Renter? _renter;
  DateTime? startDate;
  DateTime? returnDate;
  Reservation? _reservation;

  final _reservationBloc = sl<ReservationsBloc>();

  initPayment() async {
    final update = await context.pushNamed(
      'payment',
      pathParameters: {
        'reservationId': _reservation!.id!,
      },
      queryParameters: {
        'car': jsonEncode(_car?.toMap()),
        'reservation': jsonEncode(_reservation?.toMap()),
      },
    );

    if (update != null) {
      setState(() {
        _reservation = update as Reservation;
      });
    }
  }

  makeReservation() async {
    buildLoadingIndicator(context, 'Making Reservation');

    final params = {
      'headers': context.read<GlobalProvider>().headers,
      'body': {
        'price': _reservation!.price,
        'carId': _reservation!.car!.id,
        'renterId': _reservation!.renter!.id,
        'startDate': _reservation!.startDate!,
        'returnDate': _reservation!.returnDate!,
        'destination': _reservation!.destination,
        'customerId': _reservation!.customer!.id,
      }
    };

    _reservationBloc.add(MakeReservationEvent(params: params));
  }

  modifyReservation({
    required String reservationStatus,
  }) async {
    String loadingMessage = reservationStatus == 'Cancelled'
        ? 'Cancelling Reservation'
        : reservationStatus == 'Ongoing'
            ? 'Starting Trip'
            : 'Ending Trip';

    buildLoadingIndicator(context, loadingMessage);

    final params = {
      'headers': context.read<GlobalProvider>().headers,
      'urlParameters': {
        'reservationId': _reservation!.id!,
      },
      'body': {
        'status': reservationStatus,
      }
    };
    _reservationBloc.add(ChangeReservationStatusEvent(params: params));
  }

  bookAgain() => context.pushNamed(
        'makeReservation',
        queryParameters: {
          'car': jsonEncode(_car!.toMap()),
        },
      );

  initData() {
    if (widget.car != null) {
      _car = CarModel.fromJSON(jsonDecode(widget.car!));
    }

    if (widget.renter != null) {
      _renter = RenterModel.fromJSON(jsonDecode(widget.renter!));
    }

    _reservation = ReservationModel.fromJSON(jsonDecode(widget.reservation));

    startDate = DateTime.parse(_reservation!.startDate!);
    returnDate = DateTime.parse(_reservation!.returnDate!);
  }

  Duration getDuration() {
    Duration duration = returnDate!.difference(startDate!);

    if (returnDate!.isAtSameMomentAs(startDate!)) {
      duration = const Duration(days: 1);
    }

    return duration;
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AdaptiveBackButton(
          onPressed: () => context.pop(_reservation),
        ),
      ),
      body: BlocListener(
        bloc: _reservationBloc,
        listener: (context, state) {
          if (state is GenericReservationsError) {
            context.pop();
            showErrorPopUp(state.errorMessage, context);
          }

          if (state is MakeReservationLoaded) {
            context.pop();
            context.goNamed('reservationSuccess');
          }

          if (state is ChangeReservationStatusLoaded) {
            if (state.reservation.status! == 'Cancelled') context.pop();
            context.pop();

            String successMessage = state.reservation.status! == 'Cancelled'
                ? 'Reservation Cancelled'
                : state.reservation.status! == 'Ongoing'
                    ? 'Trip Started'
                    : 'Trip Ended';

            showSuccessPopUp(successMessage, context);

            setState(() {
              _reservation = state.reservation;
            });
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: Sizes().width(context, 0.04),
              right: Sizes().width(context, 0.04),
              bottom: Sizes().height(context, 0.15),
            ),
            child: widget.view == ReservationView.make
                ? ReservationDetails(
                    car: _car,
                    renter: _renter,
                    duration: getDuration(),
                    reservation: _reservation!,
                    pageTitle: 'Make Reservation',
                  )
                : ReservationDetails(
                    car: _car,
                    renter: _renter,
                    duration: getDuration(),
                    pageTitle: 'Reservation',
                    reservation: _reservation!,
                  ),
          ),
        ),
      ),
      bottomSheet: widget.view == ReservationView.make
          ? ReservationDetailsBottomSheet(
              items: [
                GenericButton(
                  isActive: true,
                  onPressed: makeReservation,
                  buttonName: 'Make Reservation',
                  width: Sizes().width(context, 0.85),
                ),
              ],
            )
          : widget.view == ReservationView.view && _car != null
              ? _reservation!.status == 'Pending'
                  ? ReservationDetailsBottomSheet(
                      items: [
                        GenericButton(
                          isActive: true,
                          buttonName: 'Cancel Reservation',
                          btnColor: rentWheelsErrorDark700,
                          width: Sizes().width(context, 0.85),
                          onPressed: () => buildConfirmationDialog(
                            context: context,
                            label: 'Cancel Reservation',
                            buttonName: 'Cancel Reservation',
                            message:
                                'Are you sure you want to cancel your reservation?',
                            onAccept: () => modifyReservation(
                              reservationStatus: 'Cancelled',
                            ),
                          ),
                        ),
                      ],
                    )
                  : _reservation!.status == 'Ongoing'
                      ? ReservationDetailsBottomSheet(
                          items: [
                            GenericButton(
                              isActive: true,
                              buttonName: 'End Trip',
                              btnColor: rentWheelsErrorDark700,
                              width: Sizes().width(context, 0.85),
                              onPressed: () => modifyReservation(
                                reservationStatus: 'Completed',
                              ),
                            ),
                          ],
                        )
                      : _reservation!.status == 'Accepted'
                          ? ReservationDetailsBottomSheet(
                              items: [
                                GenericButton(
                                  isActive: true,
                                  buttonName: 'Make Payment',
                                  width: Sizes().width(context, 0.4),
                                  onPressed: initPayment,
                                ),
                                Space().width(context, 0.04),
                                GenericButton(
                                  isActive: true,
                                  buttonName: 'Cancel Reservation',
                                  btnColor: rentWheelsErrorDark700,
                                  width: Sizes().width(context, 0.4),
                                  onPressed: () => buildConfirmationDialog(
                                    context: context,
                                    label: 'Cancel Reservation',
                                    buttonName: 'Cancel Reservation',
                                    message:
                                        'Are you sure you want to cancel your reservation?',
                                    onAccept: () => modifyReservation(
                                      reservationStatus: 'Cancelled',
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : _reservation!.status == 'Paid'
                              ? ReservationDetailsBottomSheet(
                                  items: [
                                    GenericButton(
                                      buttonName: 'Start Trip',
                                      width: Sizes().width(context, 0.4),
                                      isActive:
                                          DateTime.now().isSameDate(startDate!),
                                      onPressed: () => modifyReservation(
                                        reservationStatus: 'Ongoing',
                                      ),
                                    ),
                                    Space().width(context, 0.04),
                                    GenericButton(
                                      isActive: true,
                                      buttonName: 'Cancel Reservation',
                                      btnColor: rentWheelsErrorDark700,
                                      width: Sizes().width(context, 0.4),
                                      onPressed: () => buildConfirmationDialog(
                                        context: context,
                                        label: 'Cancel Reservation',
                                        buttonName: 'Cancel Reservation',
                                        message:
                                            'Are you sure want to cancel your reservation? Only 50% of the trip price will be refunded to you.',
                                        onAccept: () => modifyReservation(
                                          reservationStatus: 'Cancelled',
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : ReservationDetailsBottomSheet(
                                  items: [
                                    GenericButton(
                                      isActive: true,
                                      onPressed: bookAgain,
                                      buttonName: 'Book Again',
                                      width: Sizes().width(context, 0.85),
                                    ),
                                  ],
                                )
              : null,
    );
  }
}

enum ReservationView { make, view }
