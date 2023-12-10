part of 'reservations_bloc.dart';

sealed class ReservationsEvent extends Equatable {
  const ReservationsEvent();

  @override
  List<Object> get props => [];
}

final class MakeReservationEvent extends ReservationsEvent {
  final Map<String, dynamic> params;

  const MakeReservationEvent({required this.params});
}

final class GetAllReservationsEvent extends ReservationsEvent {
  final Map<String, dynamic> params;

  const GetAllReservationsEvent({required this.params});
}

final class ChangeReservationStatusEvent extends ReservationsEvent {
  final Map<String, dynamic> params;

  const ChangeReservationStatusEvent({required this.params});
}
