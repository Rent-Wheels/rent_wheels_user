import 'package:rent_wheels/core/models/reservations/reservations_model.dart';

abstract class RentWheelsReservationsEndpoint {
  Future<List<ReservationModel>> getAllReservations();
  Future<ReservationModel> cancelReservation({required String reservationId});
  Future<ReservationModel> makeReservation(
      {required ReservationModel reservationDetails});
}
