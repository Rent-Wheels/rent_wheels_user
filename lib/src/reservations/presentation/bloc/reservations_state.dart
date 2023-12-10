part of 'reservations_bloc.dart';

sealed class ReservationsState extends Equatable {
  const ReservationsState();

  @override
  List<Object> get props => [];
}

final class ReservationsInitial extends ReservationsState {}

//!STATES
final class MakeReservationLoading extends ReservationsState {}

final class MakeReservationLoaded extends ReservationsState {
  final Reservation reservation;

  const MakeReservationLoaded({required this.reservation});
}

final class GetAllReservationsLoading extends ReservationsState {}

final class GetAllReservationsLoaded extends ReservationsState {
  final List<Reservation> reservations;

  const GetAllReservationsLoaded({required this.reservations});
}

final class ChangeReservationStatusLoading extends ReservationsState {}

final class ChangeReservationStatusLoaded extends ReservationsState {
  final Reservation reservation;

  const ChangeReservationStatusLoaded({required this.reservation});
}

//!ERRORS
final class GenericReservationsError extends ReservationsState {
  final String errorMessage;

  const GenericReservationsError({required this.errorMessage});
}
