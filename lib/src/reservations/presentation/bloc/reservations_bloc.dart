import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rent_wheels/src/reservations/domain/entity/reservations.dart';
import 'package:rent_wheels/src/reservations/domain/usecases/change_reservation_status.dart';
import 'package:rent_wheels/src/reservations/domain/usecases/get_all_reservations.dart';
import 'package:rent_wheels/src/reservations/domain/usecases/make_reservation.dart';

part 'reservations_event.dart';
part 'reservations_state.dart';

class ReservationsBloc extends Bloc<ReservationsEvent, ReservationsState> {
  final MakeReservation makeReservation;
  final GetAllReservations getAllReservations;
  final ChangeReservationStatus changeReservationStatus;
  ReservationsBloc({
    required this.makeReservation,
    required this.getAllReservations,
    required this.changeReservationStatus,
  }) : super(ReservationsInitial()) {
    on<MakeReservationEvent>((event, emit) async {
      emit(MakeReservationLoading());

      final response = await makeReservation(event.params);

      emit(
        response.fold(
          (errorMessage) =>
              GenericReservationsError(errorMessage: errorMessage),
          (response) => MakeReservationLoaded(reservation: response),
        ),
      );
    });

    on<GetAllReservationsEvent>((event, emit) async {
      emit(GetAllReservationsLoading());

      final response = await getAllReservations(event.params);

      emit(
        response.fold(
          (errorMessage) =>
              GenericReservationsError(errorMessage: errorMessage),
          (response) => GetAllReservationsLoaded(reservations: response),
        ),
      );
    });

    on<ChangeReservationStatusEvent>((event, emit) async {
      emit(ChangeReservationStatusLoading());

      final response = await changeReservationStatus(event.params);

      emit(
        response.fold(
          (errorMessage) =>
              GenericReservationsError(errorMessage: errorMessage),
          (response) => ChangeReservationStatusLoaded(reservation: response),
        ),
      );
    });
  }
}
