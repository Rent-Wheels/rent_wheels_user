import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/core/widgets/popups/success_popup.dart';
import 'package:rent_wheels/injection.dart';
import 'package:rent_wheels/src/cars/domain/entity/cars.dart';
import 'package:rent_wheels/src/global/presentation/provider/global_provider.dart';

import 'package:rent_wheels/src/reservations/domain/entity/reservations.dart';
import 'package:rent_wheels/src/reservations/presentation/bloc/reservations_bloc.dart';
import 'package:rent_wheels/src/reservations/presentation/widgets/reservations_loading.dart';
import 'package:rent_wheels/src/reservations/presentation/widgets/reservation_information.dart';

class ReservationsData extends StatefulWidget {
  final bool isLoading;
  final int currentIndex;
  final List<Reservation> reservations;
  final void Function(int)? filterButtonOnTap;
  const ReservationsData({
    super.key,
    this.isLoading = true,
    this.currentIndex = 0,
    this.filterButtonOnTap,
    required this.reservations,
  });

  @override
  State<ReservationsData> createState() => _ReservationsDataState();
}

class _ReservationsDataState extends State<ReservationsData> {
  final _reservationBloc = sl<ReservationsBloc>();

  List<Reservation>? _reservations;

  Map<String, List<Reservation>> getReservations() {
    Map<String, List<Reservation>> reservationCategories = {
      'All': _reservations ?? widget.reservations,
    };

    for (var reservation in widget.reservations) {
      String status = reservation.status!;
      if (reservationCategories.containsKey(status)) {
        reservationCategories[status]!.add(reservation);
      } else {
        reservationCategories.addEntries({
          reservation.status!: [reservation]
        }.entries);
      }
    }

    return reservationCategories;
  }

  modifyReservation({
    required String reservationId,
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
        'reservationId': reservationId,
      },
      'body': {
        'status': reservationStatus,
      }
    };
    _reservationBloc.add(ChangeReservationStatusEvent(params: params));
  }

  onPayment(Reservation reservation) async {
    final update = await context.pushNamed(
      'payment',
      pathParameters: {
        'reservationId': reservation.id!,
      },
      queryParameters: {
        'car': jsonEncode(reservation.car?.toMap()),
        'reservation': jsonEncode(reservation.toMap()),
      },
    );

    if (update != null && update is Reservation) {
      final i = _reservations!.indexWhere((e) => e.id! == update.id!);
      setState(() {
        _reservations![i] = update;
      });
    }
  }

  bookTrip(Car car) => context.pushNamed(
        'makeReservation',
        queryParameters: {
          'car': jsonEncode(car.toMap()),
        },
      );

  @override
  Widget build(BuildContext context) {
    final sections = getReservations();

    return widget.isLoading
        ? ReservationsLoading(
            isLoading: widget.isLoading,
          )
        : BlocListener(
            bloc: _reservationBloc,
            listener: (context, state) {
              if (state is GenericReservationsError) {
                context.pop();
                showErrorPopUp(state.errorMessage, context);
              }

              if (state is ChangeReservationStatusLoaded) {
                _reservations = widget.reservations;
                if (state.reservation.status! == 'Cancelled') {
                  context.pop();
                }

                context.pop();

                String successMessage = state.reservation.status! == 'Cancelled'
                    ? 'Reservation Cancelled'
                    : state.reservation.status! == 'Ongoing'
                        ? 'Trip Started'
                        : 'Trip Ended';

                showSuccessPopUp(successMessage, context);

                final i = _reservations!.indexWhere(
                  (e) => e.id! == state.reservation.id!,
                );

                setState(() {
                  _reservations![i] = state.reservation;
                });
              }
            },
            child: ReservationInformation(
              onBook: bookTrip,
              sections: sections,
              onPayment: onPayment,
              currentIndex: widget.currentIndex,
              reservations: widget.reservations,
              filterButtonOnTap: widget.isLoading
                  ? null
                  : (p0) => widget.filterButtonOnTap!(p0),
              onCancelAccept: (p0) => modifyReservation(
                reservationId: p0.id!,
                reservationStatus: 'Cancelled',
              ),
              onStart: (p0) => modifyReservation(
                reservationId: p0.id!,
                reservationStatus: 'Ongoing',
              ),
              onEnd: (p0) => modifyReservation(
                reservationId: p0.id!,
                reservationStatus: 'Completed',
              ),
            ),
          );
  }
}
